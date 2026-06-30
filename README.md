# RYSEN Hotspot Proxy V2 (standalone)

Homebrew hotspot UDP proxy for the [RYSEN](https://github.com/ShaYmez/RYSEN) stack — single public port to many backend master slots. **No MariaDB / selfcare** (use [RYSEN-SP-SELFCARE](https://github.com/ShaYmez/RYSEN-SP-SELFCARE) for that).

Published as **`shaymez/rysen-sp:latest`**.

## Develop in RYSEN; publish here

**Source of truth:** [ShaYmez/RYSEN](https://github.com/ShaYmez/RYSEN) (`ipsc` branch during milestone work; `master` after merge). Edit **`hotspot_proxy_v2.py`** and tests **only in RYSEN** — not `hotspot_proxy_v2_sc.py` (that is the selfcare variant).

| Synced from RYSEN | Local path |
|-------------------|------------|
| `hotspot_proxy_v2.py` | `sync/hotspot_proxy_v2.py` |
| `hotspot_proxy_v2-SAMPLE.cfg` | `sync/proxy-SAMPLE.cfg` |
| `tests/test_rysen_sp_proxy.py` | `tests/test_rysen_sp_proxy.py` |

Refresh via [`.github/workflows/sync-from-rysen.yml`](.github/workflows/sync-from-rysen.yml) (manual, `repository_dispatch`, or daily cron). Sync commits trigger **Build-RYSEN-SP** (tests → Docker Hub).

### Wiring RYSEN → this repo

1. **`SATELLITE_DISPATCH_TOKEN`** on RYSEN (same PAT as other satellite repos).
2. **`RYSEN_SYNC_REF`** = `ipsc` on this repo (→ `master` after merge).
3. **`DOCKER_USERNAME`** / **`DOCKER_PASSWORD`** for image push.

See [satellite-proxy-repos.md](https://github.com/ShaYmez/RYSEN/blob/ipsc/doc/satellite-proxy-repos.md).

## Quick start (Docker)

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

## Quick start (bare metal)

```bash
pip install -r requirements.txt
cp sync/proxy-SAMPLE.cfg proxy.cfg
# edit proxy.cfg
PYTHONPATH=sync python sync/hotspot_proxy_v2.py -c proxy.cfg
```

## Tests

```bash
pip install -r requirements.txt
PYTHONPATH=sync python -m unittest discover -s tests -v
```

## Build image locally

```bash
docker build -t shaymez/rysen-sp:latest .
```

## Related

- Selfcare proxy: [RYSEN-SP-SELFCARE](https://github.com/ShaYmez/RYSEN-SP-SELFCARE) (`shaymez/rysen-sp-selfcare:latest`)
- RYSEN docs: [hotspot-proxy-v2.md](https://github.com/ShaYmez/RYSEN/blob/master/doc/hotspot-proxy-v2.md)
