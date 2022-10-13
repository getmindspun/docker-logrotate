FROM alpine:latest

ENV CRON_SCHEDULE="0 0 * * * *"
ENV PYTHONUNBUFFERED=1

# Install Python3 for Docker signaling.
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools docker

# Install logrotate
RUN apk --update add logrotate
RUN echo "${CRON_SCHEDULE}	/usr/sbin/logrotate -v /etc/logrotate.conf" >> /etc/crontabs/root && \
    mkdir -p /etc/logrotate.d

ADD logrotate.conf /etc/logrotate.conf
ADD docker-signal.py /usr/bin/docker-signal
RUN chmod a+x /usr/bin/docker-signal

CMD ["crond", "-f"]
