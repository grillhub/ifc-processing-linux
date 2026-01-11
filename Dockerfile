FROM ubuntu:22.04

# Install dependencies required for Unity Linux builds
RUN apt-get update && apt-get install -y \
    libc6 \
    libstdc++6 \
    libgcc1 \
    libx11-6 \
    libxext6 \
    libxrandr2 \
    libasound2 \
    libpulse0 \
    libcups2 \
    libgl1-mesa-glx \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Expose port for HTTP API (adjust if your application uses a different port)
EXPOSE 8080

# Create entrypoint script to set permissions and run the application
RUN echo '#!/bin/bash\n\
chmod +x /app/server.x86_64\n\
chmod +x /app/server_Data/IfcConvert\n\
exec /app/server.x86_64' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Run the application via entrypoint
ENTRYPOINT ["/entrypoint.sh"]

