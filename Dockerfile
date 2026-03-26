# Use small Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy everything into container
COPY . .

# Install dependencies
RUN pip install flask pytest

# Create non-root user
RUN useradd -m appuser
USER appuser

# Expose the port your app runs on
EXPOSE5000

# Health check so Docker can know if app is alive
HEALTHCHECK CMD curl --fail http://localhost:5000/health || exit 1

# Run your app
CMD ["python","app.py"]
