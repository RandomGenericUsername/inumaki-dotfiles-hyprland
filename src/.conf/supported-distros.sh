
# Add here the supported distros
export SUPPORTED_DISTROS=(
    "arch"
    #"debian"
    #"fedora"
)

declare -A PACKAGE_MANAGERS
PACKAGE_MANAGERS=(
    ["arch"]="yay"
    ["debian"]="apt"
    ["fedora"]="dnf"
)

declare -A PACKAGE_MANAGERS_INSTALL_COMMANDS
PACKAGE_MANAGERS_INSTALL_COMMANDS=(
    ["arch"]="yay --noconfirm -S"
    ["debian"]="apt install -y"
    ["fedora"]="sudo dnf install -y"
)

declare -A PACKAGE_MANAGERS_FORCE_INSTALL_COMMANDS
PACKAGE_MANAGERS_FORCE_INSTALL_COMMANDS=(
    ["arch"]="yay --noconfirm --needed -S"
    ["debian"]=""
    ["fedora"]=""
)

declare -A PACKAGE_CHECKS
PACKAGE_CHECKS=(
    ["arch"]="yay -Q"
    ["debian"]="dpkg -l"
    ["fedora"]="rpm -q"
)