FROM alpine:3.19

LABEL maintainer="chkp-yossefk"
LABEL description="Simple test image for ARC DinD validation"

RUN apk add --no-cache \
    curl \
    jq \
    bash

# Create a simple script
RUN echo '#!/bin/bash' > /app/hello.sh && \
    echo 'echo "Hello from ARC DinD runner!"' >> /app/hello.sh && \
    echo 'echo "Build time: $(date)"' >> /app/hello.sh && \
    echo 'echo "Hostname: $(hostname)"' >> /app/hello.sh && \
    chmod +x /app/hello.sh

WORKDIR /app

ENTRYPOINT ["/app/hello.sh"]