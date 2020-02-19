#include<stdio.h>
#include<unistd.h>

int main() {
    int fd1[2], fd2[2];
    int returnstatus1, returnstatus2, pid;
    char pipe1writemsg[20] = "Hi";
    char pipe2writemsg[20] = "hello";
    char readMsg[20];
    returnstatus1 = pipe(fd1);

    if (returnstatus1 == -1) {
        printf("Unable to create pipe 1. \n");
        return 1;
    }
    returnstatus2 = pipe(fd2);

    if (returnstatus2 == -1) {
        printf("Unable to create pipe 1. \n");
        return 1;
    }
    pid = fork();

    if (pid) { // parent process
        close(fd1[0]); // close read end of pipe 1
        close(fd2[1]); // close write end of pipe 2
        printf("In Parent: Writing to pipe 1 - Message is: %s\n", pipe1writemsg);
        write(fd1[1], pipe1writemsg, sizeof(pipe1writemsg));
        read(fd2[0], readMsg, sizeof(readMsg));
        printf("In Parent: Reading from pipe 2 - Message is: %s\n", readMsg);
    } else { // child process
        close(fd1[1]); // close write end of pipe 1
        close(fd2[0]); // close read end of pipe 2
        read(fd1[0], readMsg, sizeof(readMsg));
        printf("In Child: Reading from pipe 1 - Message is: %s\n", readMsg);
        printf("In Child: Writing to pipe 2 - Message is: %s\n", pipe2writemsg);
        write(fd2[1], pipe2writemsg, sizeof(pipe2writemsg));
    }
    return 0;
}