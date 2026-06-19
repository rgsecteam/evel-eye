<div align="center">

<!-- Replace with your actual logo -->
<img src="/lib/imgs/evel-eye.png" alt="Evil-Eye Logo" width="160"/>

<br/>

# EVIL-EYE
### Silent Camera Capture Framework

[![Version](https://img.shields.io/badge/version-0.1-red?style=flat-square)](https://github.com/RGSecurityTeam/evil-eye)
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS-blue?style=flat-square)](#)
[![Shell](https://img.shields.io/badge/shell-bash-orange?style=flat-square)](#)
[![PHP](https://img.shields.io/badge/php-7.4%2B-purple?style=flat-square)](#)

<br/>

> A modern, modular camera phishing framework capable of silently capturing  
> high-quality images from a target's webcam using social engineering templates  
> and a Cloudflare encrypted tunnel.

<br/>

**Developed by [RGSecurityTeam](https://github.com/rgsecteam) — For educational & authorized penetration testing only.**

</div>

---

## ⚠️ Disclaimer

> **This tool is developed strictly for educational purposes and authorized penetration testing only.**  
> The developer of Evil-Eye is **not responsible** for any misuse or damage caused by this program.  
> Using this tool against any individual or system **without explicit written permission is illegal**.  
> By using this tool, you agree that you are solely responsible for your actions.

---

## ✨ Features

| Feature | Description |
|---|---|
| 📷 **Silent Camera Capture** | Captures images from the target's front camera via browser's `getUserMedia` API |
| 🌐 **Cloudflare Tunnel** | Instantly generates a public HTTPS link — no port forwarding needed |
| 🎭 **5 Lure Templates** | YouTube Live, Birthday Wish, Secret Message, Fake Instagram, AI Chatbot |
| 📍 **IP & UA Logging** | Logs victim's IP address and browser user-agent on link open |
| 🔧 **Auto Dependency Install** | Detects and installs missing tools automatically on first run |
| 🖥️ **Cross-Distro Support** | Kali Linux, Termux, Parrot OS, Ubuntu, macOS — auto-detects OS and architecture |

---

## 📋 Requirements

### Operating System
- Kali Linux
- Parrot OS
- Ubuntu / Debian
- macOS (with Homebrew)
- Termux (Android)

### Dependencies

| Tool | Purpose | Install |
|---|---|---|
| `php` | Built-in web server | *Auto-installed on first run*  |
| `curl` | Network requests & health checks | *Auto-installed on first run*  |
| `wget` | Download cloudflared binary | *Auto-installed on first run*  |
| `jq` | JSON processing for templates | *Auto-installed on first run*  |
| `cloudflared` | Public HTTPS tunnel | *Auto-downloaded on first run* |
| `lolcat` | Colorful terminal banners | *Auto-installed on first run* |

---

## 🚀 Installation

### 1. Clone the repository

```bash
git clone https://github.com/rgsecteam/evil-eye.git
```

### 2. Go to **evil-eye** Directory

```bash
cd evil-eye
```

### 3. Run

```bash
./evel.sh
```

> `cloudflared` and `lolcat` will be installed automatically if not found.

---
## 🚀 Termux Setup 
### Install ca-certificates
```bash
pkg update && pkg install ca-certificates -y
```
### update ca-certificates
```bash
export SSL_CERT_FILE=$PREFIX/etc/tls/cert.pem
```
> **install and setup this `ca-certificates.` If this is not enabled, the `cloudflare` tunnel will not start.**

## 🎭 Templates

<details>
<summary><b>[01] YouTube Live TV</b></summary>

Presents a fake YouTube Live stream page. Prompts the victim to allow camera access to "verify their age" or "enable interactive mode". You provide any YouTube video link which plays embedded on the page.

</details>

<details>
<summary><b>[02] Birthday Wish</b></summary>

A personalized birthday celebration page with animations, balloons, cake, and music. The victim's name is embedded in the page. Camera permission is requested to "take a birthday selfie".

</details>

<details>
<summary><b>[03] Secret Message</b></summary>

A mysterious page that claims to have a secret message for the target. You provide a `.txt` file with the message content which is loaded as a JSON data source. Camera access is triggered in the background.

</details>

<details>
<summary><b>[04] Fake Instagram Followers</b></summary>

A convincing fake page promising free Instagram followers. Victim is told camera verification is required to "prove they are human".

</details>

<details>
<summary><b>[05] AI Chatbot (Fake AI)</b></summary>

A fake AI assistant chat interface. Camera access is requested in the background while the victim interacts with the chat.

</details>

---

### Where is captured data saved?

| Data | Location |
|---|---|
| Camera images | `captured_imgs/cam<timestamp>.jpg` |
| IP addresses | `captured_ip.txt` |

---

## 🌐 Tested On

| OS | Version | Status |
|---|---|---|
| Kali Linux | 2024.x | ✅ Working |
| Termux | 0.118.x | ✅ Working |
| Parrot OS | 6.x | ✅ Working |
| Ubuntu | 22.04 / 24.04 | ✅ Working |
| macOS | Ventura / Sonoma | ✅ Working |

---

## 🙏 Credits & Inspiration

- Inspired by **[techchip's champhish](https://github.com/techchipnet/CamPhish)** project
- Camera capture engine adapted from **wybiral's tiny-mirror**
- Tunnel powered by **[Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)**

---

<div align="center">

**Made with ❤️ by RGSecurityTeam**

*Use responsibly. Hack ethically.*

</div>
