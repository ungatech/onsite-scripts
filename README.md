# Ungatech Onsite Deployment Scripts
This repository contains streamlined deployment scripts for the [RustDesk](https://rustdesk.com) remote desktop client. These scripts allow Ungatech engineers to quickly provision managed endpoints with pre-configured relay settings.

## 🛠️ Script Features
* **Auto-Dependency Check:** Installs Flatpak (Linux) or verifies Winget (Windows).
* **Persistent Updates:** Flatpak or Winget updates keeps the client current.
* **Zero-Touch Config:** Pre-sets the relay.unga.tech host and key.
* **Secure Setup:** Uses masked password prompts with matching verification.
* **Privacy Focused:** Wipes variables from memory and clears session history.

## 🚀 One-Liner Deployments
### 🪟 Windows (10 / 11)
Installs via Winget. Automatically handles UAC elevation and applies relay configuration. Run the following from a Win+R (Run Command) prompt:

```powershell
powershell -Command "irm https://raw.githubusercontent.com/ungatech/onsite-scripts/refs/heads/main/install-rustdesk.bat -OutFile $env:TEMP\ir.bat; & $env:TEMP\ir.bat"
```

### 🐧 Linux (Ubuntu / Zorin OS)
Installs via Flatpak. Verifies Flathub, applies relay configuration, and prompts for a secure password. Run the following from your desktop terminal:

```bash
wget -qO- https://raw.githubusercontent.com/ungatech/onsite-scripts/refs/heads/main/install-rustdesk.sh | bash
```

---
![Ungatech Logo](https://unga.tech/img/logo_inlinegreen-25.png)