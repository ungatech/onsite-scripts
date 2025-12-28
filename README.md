# Ungatech Onsite Deployment Scripts
This repository contains streamlined deployment scripts for the [RustDesk](https://rustdesk.com) remote desktop client. These scripts allow Ungatech engineers to quickly provision managed endpoints with pre-configured relay settings and securely setup unattended remote access.

## 🛠️ Script Features
* **Persistent Updates:** [Winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/) (Windows) or [Flatpak](https://flatpak.org/) (Linux) updates keep the client current.
* **Zero-Touch Config:** Pre-sets the `relay.unga.tech` host and key.
* **Secure Setup:** Uses masked password prompts with matching verification.
* **Privacy Focused:** Wipes variables from memory and clears session history.

## 🚀 One-Liner Deployments
### 🪟 Windows (10 / 11)
Installs via Winget. Automatically handles UAC elevation and applies relay configuration. Run the following from a PowerShell or Command Prompt window:

```powershell
powershell -Command "irm https://raw.githubusercontent.com/ungatech/onsite-scripts/refs/heads/main/install-rustdesk.bat -OutFile $env:TEMP\ir.bat; & $env:TEMP\ir.bat"
```

### 🐧 Linux (Ubuntu / Zorin OS)
Installs via Flatpak. Verifies Flathub, applies relay configuration, and prompts for a secure password. Run the following from your desktop terminal with a user in the sudoers group (You may be prompted for your local password to authorize the installation):

```bash
wget -qO- https://raw.githubusercontent.com/ungatech/onsite-scripts/refs/heads/main/install-rustdesk.sh | bash
```

## 🔄 Updating RustDesk Client
Updates follow their respective package managers, as demonstrated below:

### 🪟 Windows (10 / 11)
```powershell
winget upgrade --id RustDesk.RustDesk --silent --force --accept-source-agreements
```

### 🐧 Linux (Ubuntu / Zorin OS)
```bash
flatpak update -y com.rustdesk.RustDesk
```

---
[![Ungatech Logo](https://unga.tech/img/logo_inlinegreen-25.png)](https://unga.tech)