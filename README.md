# promtail
Docker Stack deployment for Grafana Loki's Promtail.

## Getting Started

You might need to create swarm-scoped overlay network called `dockerswarm_monitoring` for all the stacks to communicate if you haven't already.

```sh
$ docker network create --scope swarm --driver overlay --attachable dockerswarm_monitoring
```

We provided a base configuration file for Promtail. You can find it in the `config` folder.  
Please make a copy as `configs/promtail.yaml`, make sure to change the following values:

```yml
clients:
  - # The tenant ID used by default to push logs to Loki. If omitted or empty
    # it assumes Loki is running in single-tenant mode and no X-Scope-OrgID header
    # is sent.
    tenant_id: demo
    url: http://loki:3100/loki/api/v1/push
```

And add any additional configuration you need to `configs/promtail.yaml`.

## Deployment

To deploy the stack, run the following command:

```sh
$ make deploy
```

## Destroy

To destroy the stack, run the following command:

```sh
$ make destroy
```

## Collecting logs from other services

You need to add `io.promtail.enabled=true` label to the any service you want to collect logs from.

**Example `docker-compose.yml`**

```yaml
# docker-compose.yml
services:
  app:
    image: app:latest
    # ...
    deploy:
      labels:
        io.promtail.enabled: "true"
```
