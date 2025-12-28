# Ungatech RustDesk Deployment Script (Linux/Flatpak)

This repository contains a streamlined deployment script for the [RustDesk](https://rustdesk.com/) remote desktop client optimally on Ubuntu-based Linux distros. 

It automates the installation via **Flatpak** to ensure the client remains updated alongside the system, and it pre-configures the client to connect to a specific self-hosted relay server we use at Ungatech.

## Features
* **Auto-Dependency Check:** Verifies and installs Flatpak/Flathub if missing.
* **Persistent Updates:** Installs via Flathub so `flatpak update` keeps the client current.
* **Zero-Touch Config:** Automatically applies the relay server and public key.
* **Secure Setup:** Includes a double-blind, masked password prompt to set a permanent password for unattended access.
* **Privacy Focused:** Automatically clears terminal history after execution to prevent password leaks in `~/.bash_history`.

## Usage

### 1. Default Installation (Ungatech Support)
To install using the default **Ungatech** relay settings, run:

```bash
wget -qO- https://raw.githubusercontent.com/ungatech/onsite-scripts/refs/heads/main/install-rustdesk.sh | bash
