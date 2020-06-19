#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>

#define PORT 8080
#define BUFFER_SIZE 1024

int main() {
    int sd; // socket fd
    char buffer[BUFFER_SIZE];
    struct sockaddr_in server;

    while (1) {
        printf("Choose option: \n\t1. Request time. \n\t2. Exit. \n");
        int ch;
        scanf("%d", &ch);

        if (ch == 1) {
            // Open a datagram socket
            if ((sd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
                perror("Socket creation failed!\n");
                exit(EXIT_FAILURE);
            }

            // clear out the server struct
            memset((void *)&server, 0, sizeof(server));

            // set family and port
            server.sin_family = AF_INET; // IPv4
            server.sin_addr.s_addr = INADDR_ANY;
            server.sin_port = htons(PORT);

            int len, n;
            char *req = "get_time";

            sendto(sd, (const char *) req, strlen(req), MSG_CONFIRM, (const struct sockaddr *)&server, sizeof(server));

            n = recvfrom(sd, (char *) buffer, BUFFER_SIZE, 0, (struct sockaddr *)&server, &len);
            if (n < 0) {
                perror("Could not receive datagram!\n");
                exit(EXIT_FAILURE);
            }
            buffer[n] = '\0';
            printf("Time@Server: %s\n", buffer);

        } else if (ch == 2) break;
        else {
            printf("Choose valid option!\n");
            continue;
        }
    }

    return 0;
}