FROM python:alpine3.20

COPY entrypoint /entrypoint
RUN chmod +x /entrypoint

RUN adduser -D -u 54000 radio && \
    apk add --no-cache gcc musl-dev && \
    pip install --no-cache-dir --upgrade pip

WORKDIR /opt/rysen-sp

COPY requirements.txt version.txt ./
COPY sync/hotspot_proxy_v2.py sync/proxy-SAMPLE.cfg ./

RUN pip install --no-cache-dir -r requirements.txt && \
    apk del gcc musl-dev

USER radio

ENTRYPOINT [ "/entrypoint" ]
