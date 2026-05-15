FROM python:3.10-slim

WORKDIR /app

RUN pip install --no-cache-dir \
    websockets>=12.0 \
    redis>=5.0 \
    requests>=2.31

COPY server.py .

EXPOSE 8765

CMD ["python", "-u", "server.py"]
