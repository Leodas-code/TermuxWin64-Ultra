# TermuxWin64 Ultra | High-FPS Windows Layer 🚀

**TermuxWin64 Ultra** is an elite, zero-bloat Windows compatibility layer for Android devices. Built on top of **Termux + Termux-X11**, it leverages **Box64** and **Wine-GE** to deliver desktop-class performance with a modern, customizable UI inspired by projects like *Dark OS* and *Winlator*.

![TermuxWin64 Banner](https://img.shields.io/badge/Performance-Ultra_Fast-brightgreen)
![Vulkan Support](https://img.shields.io/badge/Vulkan-Enabled-orange)
![Android Requirement](https://img.shields.io/badge/Android-10%2B-blue)

## ⚡ Core Features

- **Extreme Performance**: Optimized for 60+ FPS in titles like *Genshin Impact*, *Star Rail*, and *Elder Ring*.
- **Zero-Weight Architecture**: No heavy desktop environments (XFCE/LXQt) by default. Direct game launching for maximum RAM availability.
- **Dynamic Recompilation**: Uses the latest **Box64 Dynarec** with custom tuning for ARM82+ processors.
- **Modern UI Engine**: Fully customizable launcher and touch-control overlays with adjustable opacity and accent colors.
- **Auto-GPU Detection**: Intelligent switching between **Adreno (Turnip)** and **Mali (Zink/Panfrost)** drivers.
- **DXVK-Async**: Bypasses shader stuttering for smooth 3D rendering from the first frame.

## 📥 Fast Install

Paste this command into your **Termux** terminal to begin the automated setup:

```bash
curl -sL https://raw.githubusercontent.com/termuxwin64/ultra/main/install.sh | bash
```

*Note: Requires Termux-X11 (Nightly) and storage permissions.*

## 🛠 Tuning & Environment

For maximum performance, the following variables are injected into the environment:

```bash
export BOX64_DYNAREC_FAST=1      # Extreme instruction throughput
export MESA_GLTHREAD=true         # Multi-threaded OpenGL
export vblank_mode=0              # Unlock Framerates
export DXVK_ASYNC=1               # Enable Async Shader Compilation
```

## 🎮 Game Optimization

| Game | Target FPS | Optimization |
| :--- | :--- | :--- |
| **Genshin Impact** | 45-60 FPS | Use Turnip Drivers + DXVK Async |
| **Honkai: Star Rail** | 60 FPS | Dynarec Strongmem = 1 |
| **Cyberpunk 2077** | 24-30 FPS | 720p + FSR Balanced |
| **Elden Ring** | 30 FPS | Proton-GE 8.x + No-Anti-Cheat |

## 🎨 Modern UX Designer

TermuxWin64 Ultra includes a built-in **UX Designer** allowed you to:
- Customize your **Dark OS** theme with multiple accent colors.
- Design **On-Screen Controller** layouts with drag-and-drop handles.
- Adjust **Control Opacity** for immersive gameplay.
- Monitor **Performance HUDs** (FPS, CPU, GPU, Temperature).

## 🆘 Troubleshooting

- **Black Screen**: Restart Termux-X11 session and ensure "Prefer GPU" is set in settings.
- **Low FPS**: Check if Android thermal throttling is active. Keep device cool.
- **Audio Desync**: Ensure PulseAudio is running with `pulseaudio --start`.

## 🤝 Credits & Tech Stack

- **Box64**: [ptitSeb](https://github.com/ptitSeb/box64) (Emulation Core)
- **Wine-GE**: [GloriousEggroll](https://github.com/GloriousEggroll) (Gaming Wine builds)
- **Termux-X11**: High-performance X11 server for Android.
- **Mesa/Turnip**: Open-source Vulkan drivers for Adreno.

---
*Disclaimer: Use at your own risk. This project is for educational and performance testing purposes.*
