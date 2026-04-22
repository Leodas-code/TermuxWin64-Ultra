#!/bin/bash
# TermuxWin64 Ultra - Automated High-FPS Installer
# Architecture: ARM64 (Android 10+)
# Optimized for: Box64 + Wine-GE + Turnip/Zink

set -e

# Colors for terminal output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}--- TERMUXWIN64 ULTRA INSTALLER ---${NC}"
echo -e "${BLUE}Initializing Core Environment...${NC}"

# 1. Update and Prep Termux
echo -e "${GREEN}[1/5] Updating Termux packages...${NC}"
pkg update -y && pkg upgrade -y
pkg install x11-repo -y
pkg install termux-x11-nightly termux-am proot-distro pulseaudio mesa-demos -y

# 2. Setup Specialized Debian Distribution
echo -e "${GREEN}[2/5] Setting up performance-tuned Debian Proot...${NC}"
proot-distro install debian

# 3. Enter Proot and Setup Components
echo -e "${GREEN}[3/5] Configuring internal packages (Box64/Wine)...${NC}"
cat <<EOF > install_inside.sh
#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt update && apt upgrade -y
apt install wget git build-essential cmake libasound2 pulseaudio-utils libgl1-mesa-dri mesa-vulkan-drivers libvulkan1 vulkan-tools -y

# Install Box64
echo "Deploying Box64 Dynarec..."
wget -O box64.deb https://github.com/ptitSeb/box64/releases/download/v0.3.2/box64-debian-arm64.deb
dpkg -i box64.deb && rm box64.deb

# Install Wine-GE
echo "Deploying Wine-GE (GloriousEggroll)..."
wget https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton8-25/wine-lutris-GE-Proton8-25-x86_64.tar.xz
mkdir -p /opt/wine-ge
tar -xvf wine-lutris-GE-Proton8-25-x86_64.tar.xz -C /opt/wine-ge --strip-components=1

# Setup Symlinks
ln -sf /opt/wine-ge/bin/wine /usr/local/bin/wine
ln -sf /opt/wine-ge/bin/wine64 /usr/local/bin/wine64

# Install DXVK
echo "Configuring DXVK (Async Patch)..."
wget https://github.com/doitsujin/dxvk/releases/download/v2.3/dxvk-2.3.tar.gz
tar -xvf dxvk-2.3.tar.gz
cd dxvk-2.3/x64
cp *.dll /opt/wine-ge/lib64/wine/x86_64-windows/
EOF

proot-distro login debian -- bash install_inside.sh

# 4. Finalizing Launcher
echo -e "${GREEN}[4/5] Creating Ultra-Launcher...${NC}"
cat <<EOF > ~/start-win64
#!/bin/bash
# Performance Overrides
export BOX64_DYNAREC_FAST=1
export MESA_GLTHREAD=true
export vblank_mode=0
export DXVK_ASYNC=1

# Start Termux-X11
termux-x11 :0 &
sleep 2

# Start Proot Environment
proot-distro login debian -- bash -c "export DISPLAY=:0 && wine explorer"
EOF
chmod +x ~/start-win64

# 5. Summary
echo -e "${BLUE}------------------------------------${NC}"
echo -e "${GREEN}INSTALLATION COMPLETE!${NC}"
echo -e "Run ${BLUE}~/start-win64${NC} to launch the emulator."
echo -e "Configure your UI and Layout in the TermuxWin64 Ultra App."
echo -e "${BLUE}------------------------------------${NC}"
