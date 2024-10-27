
# Add here the supported distros
export SUPPORTED_DISTROS=(
    "arch"
    "debian"
    "fedora"
)

declare -A PACKAGE_MANAGERS
PACKAGE_MANAGERS=( 
    ["arch"]="yay"
    ["debian"]="apt"
    ["fedora"]="dnf"
)
