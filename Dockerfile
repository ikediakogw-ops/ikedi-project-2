# Use small Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install curl (for healthcheck)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Copy everything into container
COPY . .

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create non-root user
RUN useradd -m appuser
USER appuser

# Expose the port your app runs on
EXPOSE 5000

# Health check so Docker can know if app is alive
HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit 1

# Run your app
CMD ["python","app.py"]
