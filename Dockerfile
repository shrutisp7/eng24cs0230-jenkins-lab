FROM python:3.12-slim

WORKDIR /app

COPY calculator.py .
COPY test_calculator.py .

RUN pip install --no-cache-dir pytest

RUN python3 -m pytest -v

CMD ["python3", "--version"]
