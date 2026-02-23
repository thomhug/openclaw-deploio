# OpenClaw auf Deploio

OpenClaw (191k+ GitHub Stars) als Self-Hosted AI-Assistent auf Nine's Deploio PaaS.

## Deployment

### 1. Repository auf GitLab pushen

```bash
cd openclaw-deploio
git init
git remote add origin git@gitlab.nine.ch:tom/openclaw-deploio.git
git add .
git commit -m "OpenClaw on Deploio"
git push -u origin main
```

### 2. Auf Deploio deployen

```bash
nctl create application openclaw \
  --git-url=git@gitlab.nine.ch:tom/openclaw-deploio.git \
  --git-revision=main \
  --dockerfile \
  --size=micro
```

### 3. Environment Variables setzen

```bash
nctl update application openclaw \
  --env ANTHROPIC_API_KEY=sk-ant-...
```

### 4. WhatsApp verbinden

- Öffne die Deploio App-URL im Browser (Control UI)
- Navigiere zu Channels > WhatsApp
- Scanne den QR-Code mit WhatsApp > Einstellungen > Verknüpfte Geräte

## Hinweise

- **Storage**: Deploio hat ephemeral Storage. Bei einem Redeploy muss WhatsApp neu verknüpft werden.
- **Port**: Deploio erwartet `$PORT` (default 8080). Das Dockerfile konfiguriert den Gateway entsprechend.
- **Kosten**: Deploio Micro (CHF 8/Mt.) + Anthropic API-Kosten je nach Nutzung.

## Für Produktion

Für persistente WhatsApp-Sessions in Produktion:
- Object Storage (S3-kompatibel) für Session-Backup nutzen
- Oder: NKE (Managed Kubernetes) mit Persistent Volumes
