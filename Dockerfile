FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application
COPY service/ ./service/

# Create and switch user to theia(none root user)
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run and expose service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
