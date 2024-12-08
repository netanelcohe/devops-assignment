# Use a lightweight base image with the desired Python version
FROM python:3.10-slim as base

# Set metadata labels
LABEL maintainer="netanel.cohen@pentera.io"
LABEL version="1.0"
LABEL description="A Dockerized Arithmetic Python Server-Client Application"

# Set a dedicated working directory
WORKDIR /

# Copy only the requirements file to leverage Docker caching
# COPY requirements.txt .

# Install dependencies efficiently
# RUN pip install --no-cache-dir -r requirements.txt

# Copy only the necessary files into the image
COPY server.py ./

# Create a non-root user for security
RUN useradd -m netcalc
USER netcalc

# Expose the port for the server
EXPOSE 5000

# Default command to run the server
CMD ["python3", "server.py"]

