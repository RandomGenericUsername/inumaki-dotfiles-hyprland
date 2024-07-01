install_wallpapers(){
    local source=$dotfiles_dir/wallpappers
    local dest=$dotfiles_install_path
    print "Copying wallpapers from $source to $dest"
    cp -r $source $dest
}
