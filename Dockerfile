# Use the official Python 2.7 image
# This ensures Python 2.7 is correctly installed and resolved automatically
FROM python:2.7

# Set metadata (preferred over MAINTAINER)
LABEL maintainer="lumorgan@cmc.edu"

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker's cache
# This ensures that if only requirements change, you don't have to re-copy all source files
COPY ./requirements.txt /app/requirements.txt

# Install dependencies
# --no-cache-dir to save space in the final image
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the application
COPY . /app

# Create a non-root user for security (optional but recommended)
# We use 'app_user' as the username
RUN adduser --disabled-password --gecos '' app_user
USER app_user

# Expose any ports if your app needs them (e.g., 8080)
# EXPOSE 8080

# Set entrypoint to python
ENTRYPOINT ["python"]

# Default command is the main app script
CMD ["app.py"]
