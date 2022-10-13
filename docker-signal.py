#!/usr/bin/python
import argparse

import docker


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("container")
    parser.add_argument("--signal", default="USR1")
    parser.add_argument("--docker-sock", default="unix:///tmp/docker.sock")
    args = parser.parse_args()

    signal = args.signal
    if not signal.startswith("-SIG"):
        if signal.startswith("SIG"):
            signal = "-" + signal
        else:
            signal = "-SIG" + signal

    client = docker.DockerClient(base_url=args.docker_sock)
    container = client.containers.get(args.container)
    container.exec_run(["kill", signal, "1"])


if __name__ == "__main__":
    main()
