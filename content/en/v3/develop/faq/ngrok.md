---
title: Ngrok
linktitle: Ngrok
type: docs
description: Questions about setting up ngrok for local set ups
weight: 600
---

Follow these steps to set up ngrok for local Jenkins X installs.

- Download and install [ngrok](https://ngrok.com/).
- Log into ngrok account and get the ngrok auth token (Authenticated sessions can run for unlimited time, unauthenticated sessions expire in 1.5 hours):

- Create a ngrok config file at `~/.config/ngrok/ngrok.yml` with the following content (replace `<ngrok-auth-token>` with the auth token from the ngrok account):

```yaml
authtoken: <ngrok-auth-token>
tunnels:
  hook:
    proto: http
    addr: 8080
    schemes:
      - http
  ui:
    proto: http
    addr: 9090
    schemes:
      - http
version: "2"
region: us
```

- Verify that the config is correct using:

```bash
ngrok config check
```

- Run this in a new terminal window/tab:

```bash
ngrok start --all
```

- Once the command succeeds, you should see something like this:

```text
ngrok                                                                                                                                                                                       (Ctrl+C to quit)

Hello World! https://ngrok.com/next-generation

Session Status                online
Account                       user123 (Plan: Free)
Update                        update available (version 3.0.6, Ctrl-U to update)
Version                       3.0.5
Region                        United States (us)
Latency                       25ms
Web Interface                 http://127.0.0.1:4040
Forwarding                    http://XXXX.ngrok.io -> http://localhost:8080
Forwarding                    http://YYYY.ngrok.io -> http://localhost:9090

Connections                   ttl     opn     rt1     rt5     p50     p90
                              0       0       0.00    0.00    0.00    0.00
```