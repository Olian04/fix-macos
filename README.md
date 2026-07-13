# fix-macos

I don't like a lot of the default behavior in MacOS. This list contains the fixes I've found to make MacOS less annoying.

> Disclaimer: This is NOT a definitive list and will grow & shrink as I see fit. If you have any comments or concerns, keep them to your self.

## Fixing missing behavior

Adding new behavior or changing built in behavior that is either missing from the OS or behaves very differently compared to Linux or Windows.

- ⌨️ **Karabiner-Elements** — [pqrs-org/Karabiner-Elements](https://github.com/pqrs-org/Karabiner-Elements) [![stars](https://img.shields.io/github/stars/pqrs-org/Karabiner-Elements?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/pqrs-org/Karabiner-Elements)
  - Remaps keys so a Windows/Linux keyboard works right on Mac — without it, keys land in the wrong place or don't work at all.
- 🖱️ **Smooze** — [smooze.co](https://smooze.co)
  - Disables scroll acceleration and jerky scroll animations that make Mac scrolling feel alien coming from Windows/Linux. (Proprietary; free tier is enough.)
- 🔌 **Ethernet Status** — [ethernetstatus.com](https://ethernetstatus.com)
  - Adds the wired-connection menu bar indicator Mac lacks, since it assumes everyone is on Wi-Fi. (Proprietary.)
- 🍺 **Homebrew** — [Homebrew/brew](https://github.com/Homebrew/brew) [![stars](https://img.shields.io/github/stars/Homebrew/brew?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/Homebrew/brew)
  - The package manager Mac is missing — install and update CLI tools the way you would with `apt` or `pacman`.
- 🪟 **Rectangle** — [rxhanson/Rectangle](https://github.com/rxhanson/Rectangle) [![stars](https://img.shields.io/github/stars/rxhanson/Rectangle?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/rxhanson/Rectangle)
  - Keyboard-driven window snapping and tiling that Windows/Linux ship by default.

## Improving built in behavior

Improving built in behavior either making it easier to use or more powerful.

- 🔀 **AltTab** — [lwouis/alt-tab-macos](https://github.com/lwouis/alt-tab-macos) [![stars](https://img.shields.io/github/stars/lwouis/alt-tab-macos?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/lwouis/alt-tab-macos)
  - Turns Mac's near-useless alt-tab into a proper Windows-style window switcher with thumbnails.
- 🔓 **Gatekeeper bypass guide** — [macpaw.com](https://macpaw.com/how-to/fix-macos-cannot-verify-that-app-is-free-from-malware)
  - How to run unsigned apps and stop Mac from blocking software you trust. (Guide, not an app.)
- 💻 **iTerm2** — [gnachman/iTerm2](https://github.com/gnachman/iTerm2) [![stars](https://img.shields.io/github/stars/gnachman/iTerm2?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/gnachman/iTerm2)
  - A far more capable Terminal.app replacement; I use its hotkey pop-over so my terminal follows me to whichever screen is active.

## Adding new behavior

Adding genuinely new behavior that is nice to have but not needed.

- 🔣 **Nerd Fonts** — [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts) [![stars](https://img.shields.io/github/stars/ryanoasis/nerd-fonts?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/ryanoasis/nerd-fonts)
  - Patched fonts packed with icon glyphs; a de facto dependency for most modern TUIs and prompts.
- ✂️ **Click to Remove Element** — [Chrome Web Store](https://chromewebstore.google.com/detail/click-to-remove-element/jcgpghgjhhahcefnfpbncdmhhddedhnk)
  - One-click deletion of page elements to fix broken websites — beat scroll locks and paywalls, unpad text boxes, and clean up pages before screenshots or screencasts.

## Optional domain specific nice to have

Grouped by domain and only that which does not clearly fit into the other categories.

- 📦 **OrbStack** — [orbstack.dev](https://orbstack.dev)
  - Fast, low-overhead Docker containers, local Kubernetes, and headless Linux VMs in one app. (Proprietary; Docker Desktop replacement.)
- ☸️ **k9s** — [derailed/k9s](https://github.com/derailed/k9s) [![stars](https://img.shields.io/github/stars/derailed/k9s?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/derailed/k9s)
  - Terminal UI for navigating and managing local or remote Kubernetes clusters — a must-have for any k8s work.
- 🔍 **jq** — [jqlang/jq](https://github.com/jqlang/jq) [![stars](https://img.shields.io/github/stars/jqlang/jq?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/jqlang/jq)
  - The standard CLI for slicing, filtering, and transforming JSON.
- 📄 **yq** — [mikefarah/yq](https://github.com/mikefarah/yq) [![stars](https://img.shields.io/github/stars/mikefarah/yq?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/mikefarah/yq)
  - Same idea as JQ but for YAML; invaluable for k8s manifests and CRDs.
- 🐶 **Bruno** — [usebruno/bruno](https://github.com/usebruno/bruno) [![stars](https://img.shields.io/github/stars/usebruno/bruno?style=flat&label=%E2%98%86&labelColor=333&color=333)](https://github.com/usebruno/bruno)
  - Local-first, git-native API client, so request configs live in version control like the rest of my IaC/GitOps. Replaced Postman for me the day it launched.
