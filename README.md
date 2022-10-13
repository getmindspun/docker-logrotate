# Dockerized Logrotate

Containerized logrotate.

Runs logrotate then sends a signal to the parent container.

## How to run

* Your logrotate config files should be mapped in the `/etc/logrotate.d` inside the container
* The cron job will run daily at 00:00:00 UTC time by default. You can override the cron schedule by overwriting the `CRON_SCHEDULE` environment variable.
* Run the following to run the docker container.

```bash
    docker run -d -v $(pwd)/logrotate/:/etc/logrotate.d/ -v /var/run/docker.sock:/tmp/docker.sock mindspun/logrotate
```

## Example

```
/var/log/nginx/*.log {
    size 10M
    missingok
    rotate 5
    compress
    delaycompress
    notifempty
    sharedscripts
    postrotate
    docker-signal nginx
    endscript
}
```

This example rotates logs for an `nginx` container with the following setup:
* nginx is running in a container named 'nginx'.
* nginx writes logs to a shared volume with the host.


## References

* Based on the archived project: https://github.com/stakater/dockerfile-logrotate
* Implements #2 from https://meerkatwatch.com/blog/nginx-docker-logrotate/.
* How to write a logrotate config file: https://serversforhackers.com/c/managing-logs-with-logrotate