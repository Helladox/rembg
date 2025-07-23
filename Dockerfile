FROM python:3.10-slim

WORKDIR /rembg

RUN pip install --upgrade pip

# Install curl for debugging (optional)
RUN apt-get update && apt-get install -y curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy your source files
COPY . .

# Install rembg with server support
RUN python -m pip install ".[cpu,cli]"

# Download default model (optional: pre-load it)
RUN rembg d u2net

# Use PORT from environment variable or default to 3000
ENV PORT=3000

EXPOSE $PORT

# Start the rembg HTTP server
CMD ["rembg", "server", "--host", "0.0.0.0", "--port", "3000"]
