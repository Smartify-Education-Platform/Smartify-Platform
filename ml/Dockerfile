FROM python:3.11-slim

WORKDIR /app


# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \

    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy backend files
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY AI ./AI
COPY main.py .

EXPOSE 8091


CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8091"]
