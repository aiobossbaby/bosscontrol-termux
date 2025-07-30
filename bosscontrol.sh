#!/data/data/com.termux/files/usr/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

echo ""
echo "🛡️  ${BOLD}BossControl.sh v1.0 – Termux Master Cleaner & Dev Toolkit${NORMAL}"
echo "--------------------------------------------------------------"
echo "By: ᴹʳ.ᴮᴼˢˢ ᴮᴬᴮʸ 亗 ▄︻̷┻═━一"
echo ""

## Function Definitions

clean_system() {
    echo "🧹 Cleaning system junk..."

    apt clean && apt autoclean && apt autoremove -y
    rm -rf ~/.cache/pip ~/.cache/yarn ~/.npm
    find $HOME -type f \( -name "*.log" -o -name "*.tmp" \) -delete
    find $HOME -type f \( -name "*.zip" -o -name "*.tar.gz" -o -name "*.xz" -o -name "*.iso" \) -delete
    find $HOME -type d -name "__pycache__" -exec rm -rf {} +
    echo "✅ System junk cleaned."
}

clean_nethunter() {
    echo "🐍 Searching for NetHunter archives..."
    if [ -f "$HOME/kali-nethunter-rootfs-full-arm64.tar.xz" ]; then
        rm -f "$HOME/kali-nethunter-rootfs-full-arm64.tar.xz"
        echo "🗑️  NetHunter archive deleted."
    else
        echo "ℹ️  No NetHunter archive found."
    fi
}

check_tools() {
    echo "🔍 Checking common dev tools..."
    for tool in python git node php curl wget nano java termux-setup-storage; do
        if command -v $tool >/dev/null 2>&1; then
            echo "✅ $tool installed"
        else
            echo "❌ $tool missing"
        fi
    done
}

kill_zombies() {
    echo "💀 Killing stuck background processes..."
    ps -aux | grep -E 'ngrok|python|node|php' | awk '{print $2}' | xargs -r kill -9
    echo "✅ Background zombies cleared."
}

show_info() {
    echo ""
    echo "📊 System Info"
    echo "-------------------"
    termux-info | head -n 10
    echo ""
    df -h | grep data
    echo ""
    uptime
    echo ""
}

## Menu Interface

while true; do
echo ""
echo "📜 ${BOLD}Select an action:${NORMAL}"
echo "1. 🧹 Clean system junk"
echo "2. 🐍 Clean NetHunter archive"
echo "3. 🔍 Check dev tools"
echo "4. 💀 Kill zombie processes"
echo "5. 📊 Show system info"
echo "0. ❌ Exit"
echo ""
read -p "👉 Enter your choice: " choice

case $choice in
    1) clean_system ;;
    2) clean_nethunter ;;
    3) check_tools ;;
    4) kill_zombies ;;
    5) show_info ;;
    0) echo "🚪 Exiting... Keep , Boss Baby!"; break ;;
    *) echo "❌ Invalid choice. Try again." ;;
esac
done
