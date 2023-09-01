#!/bin/bash
while true; do
    echo -e "HTTP/1.1 200 OK\r\nContent-Length: $(echo -n 'Hello, world!' | wc -c)\r\n\r\nHello, world!" | nc -l -p 80 -q 1
done
