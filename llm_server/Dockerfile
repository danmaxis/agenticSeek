FROM ubuntu:20.04

WORKDIR /app

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements_extra.txt requirements_ai.txt .

RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir -r requirements_extra.txt
RUN pip3 install --no-cache-dir -r requirements_ai.txt

CMD ["python3", "--version"]