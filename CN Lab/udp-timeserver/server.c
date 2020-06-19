#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <time.h>

#define PORT 8080
#define BUFFER_SIZE 1024

int main() {
    int sd; // socket fd
    struct sockaddr_in server, client;

    // Open a datagram socket
    if ((sd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("Socket creation failed!\n");
        exit(EXIT_FAILURE);
    }

    // clear out the server struct
    memset((void *)&server, 0, sizeof(server));
    memset((void *)&client, 0, sizeof(server));

    // set family and port
    server.sin_family = AF_INET; // IPv4
    server.sin_addr.s_addr = INADDR_ANY;
    server.sin_port = htons(PORT);

    // bind the socket with the server address
    if (bind(sd, (const struct sockaddr *)&server, sizeof(server)) < 0) {
        perror("bind failure!\n");
        exit(EXIT_FAILURE);
    }

    int client_length, n;
    char buffer[BUFFER_SIZE];

    client_length = sizeof(client);

    while (1) {
        // receive the datagram from the client
        n = recvfrom(sd, (char *) buffer, BUFFER_SIZE, 0, (struct sockaddr *)&client, &client_length);
        if (n < 0) {
            perror("Could not receive datagram!\n");
            exit(EXIT_FAILURE);
        }
        buffer[n] = '\0';

        printf("Recd request: %s\n", buffer);
        
        // check for time request
        if (strcmp(buffer, "get_time") == 0) {
            // get current time
            time_t curTime;
            time(&curTime);
            char *timeString = ctime(&curTime);
            printf("Sending time: %s\n", timeString);

            // send data back
            if (sendto(sd, (const char *)timeString, strlen(timeString), MSG_CONFIRM, (struct sockaddr *)&client, client_length) != strlen(timeString)) {
                perror("Error sending datagram");
                exit(EXIT_FAILURE);
            }
        }
    }

    return 0;
}