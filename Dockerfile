FROM python:3.13-slim

RUN apt-get update && apt-get install -y --no-install-recommends libgomp1 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements-api.txt .
RUN pip install --no-cache-dir -r requirements-api.txt

COPY src/ ./src/
COPY data/06_models/ ./data/06_models/

ENV PYTHONPATH=/app/src
ENV MODEL_PATH=/app/data/06_models/tuned_model.pkl

EXPOSE 8000

CMD ["uvicorn", "crash_kedro.api.app:app", "--host", "0.0.0.0", "--port", "8000"]
