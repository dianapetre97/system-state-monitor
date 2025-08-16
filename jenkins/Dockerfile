FROM python:3.11-slim

WORKDIR /src

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 8090

COPY scripts/backup.py /app/backup.py

ENTRYPOINT ["python", "/app/backup.py"]