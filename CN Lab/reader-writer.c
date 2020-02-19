#include <stdio.h>
#include <unistd.h>
#include <sys/shm.h>
#include <sys/ipc.h>
#include <semaphore.h>
#include <pthread.h>

sem_t readlock, writelock;
int counter;
int shmid;

void *writer(void *arg)
{
    sem_wait(&writelock); // writer decrements (locks) writelock => no other writers can enter at this time. 
    printf("\nWriter is in critical section\n");
    char *str = (char *)shmat(shmid, (void *)0, 0); // open the shared memory for writing
    sprintf(str, "%d", (int)arg); // write the argument received into the shared memory
    printf("Data written in memory is: %d\n\n", (int)arg); // echo the data written
    shmdt(str); // detach the shared memory
    sem_post(&writelock); // writer increments (unlocks) writelock after write completion. 
}

void *reader(void *arg)
{
    sem_wait(&readlock); // reader decrements (locks) readlock
    counter++;  // keeps track of no. of readers
    if (counter == 1)
        sem_wait(&writelock); // the first reader locks out the writers by decrementing the writelock
    sem_post(&readlock); // the reader increments (unlocks) the readlock to allow the other readers to read
    char *str = (char *)shmat(shmid, (void *)0, 0); // open the shared memory for reading
    printf("Data read from memory is: %s\n", str);
    shmdt(str);
    sem_wait(&readlock); // another critical section - don't let the other readers enter this section now
    counter--;  // reader is done - leaving
    if (counter == 0)
        sem_post(&writelock); // the last reader increments (unlocks) the writelock to let the writer in, if waiting
    sem_post(&readlock); // let the other readers now
}

void main()
{
    sem_init(&readlock, 0, 1); // initializes readlock to 1, shared only between threads of the process
    sem_init(&writelock, 0, 1); // initializes writelock to 1, shared only between threads of the process
    key_t key = ftok("shmfile", 65);
    shmid = shmget(key, 1024, 0666 | IPC_CREAT);

    pthread_t t1[5], t2[5]; // 5 reader tids, 5 writer tids
    for (int i = 0; i < 5; i++)
    {
        pthread_create(&t1[i], NULL, writer, (void *)i); // tid, no attr, writer function invoked on thread creation, arg i passed to the writer function
        pthread_create(&t2[i], NULL, reader, (void *)i); // tid, no attr, reader function invoked on thread creation, arg i passed to the reader function
    }
    for (int i = 0; i < 5; i++)
    {
        pthread_join(t1[i], NULL); // wait for the readers and writers to finish
        pthread_join(t2[i], NULL); // wait for the readers and writers to finish
    }

    shmctl(shmid, IPC_RMID, NULL);  // destroy the shared memory after its use is over
    sem_destroy(&readlock); // destry the semaphore
    sem_destroy(&writelock); // destry the semaphore
}