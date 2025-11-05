# Dockerfile

# Use the official Python 3.11 slim image as a base
FROM python:3.11-slim

# Install libgl1 and libglib2.0-0 dependencies for the image processing library
RUN apt-get update \
    && apt-get install -y \
       libgl1 \
       libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

RUN pip install --upgrade pip

# Copy the pyproject.toml file to take advantage of Docker caching
COPY pyproject.toml .

# Install project dependencies according to pyproject.toml
RUN pip install .

# Copy all source code of the project to the working directory
COPY . .

# Declare the port where the service runs
EXPOSE 2024

# Define the container startup command
CMD ["langgraph", "dev", "--host", "0.0.0.0", "--port", "2024"]

#Start the project directly with the script
# CMD ["python", "server.py"]