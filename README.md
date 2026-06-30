# RYSEN Hotspot Proxy

Docker image for the [RYSEN](https://github.com/ShaYmez/RYSEN) stack: one public UDP port to many backend master slots.

**Image:** `shaymez/rysen-sp:latest`

For MariaDB selfcare options, use [RYSEN-SP-SELFCARE](https://github.com/ShaYmez/RYSEN-SP-SELFCARE) instead.

## Docker

Copy `sync/proxy-SAMPLE.cfg` to your host (e.g. `/etc/rysen/proxy.cfg`) and set `MASTER` to your RYSEN instance.

```yaml
proxy:
    container_name: proxy
    image: shaymez/rysen-sp:latest
    volumes:
        - '/etc/rysen/proxy.cfg:/opt/rysen-sp/proxy.cfg'
    ports:
        - '62031:62031/udp'
    restart: unless-stopped
    read_only: true
```

## Configuration

| Key | Purpose |
|-----|---------|
| `MASTER` | Backend RYSEN master IP |
| `LISTENPORT` | Public UDP port (usually 62031) |
| `DESTPORTSTART` / `DESTPORTEND` | Backend slot port range |
| `TIMEOUT` | Idle peer timeout (seconds) |

See [hotspot proxy docs](https://github.com/ShaYmez/RYSEN/blob/master/doc/hotspot-proxy-v2.md) on RYSEN for more detail.
