

install_wal(){
    local source=$dotfiles_dir/wal
    local dest=$dotfiles_install_path
    print "Copying $source into $dest" "debug" "$log"
    cp -r $source $dest 
    _installSymLink wal ~/.config/wal $dotfiles_install_path/wal/ ~/.config
    print "Finished installing wal" "debug" "$log"
}


