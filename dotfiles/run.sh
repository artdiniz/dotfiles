# TODO Check or creates symlink in ~/dotfiles

# TODO =>
for program in ~/dotfiles/programs/*; do
    # install
        # RUN `programs/$program/install.sh` OR `brew-installer *` IF [ -r programs/$program/brew.sh ]
        install_status=$?
        if [ $install_status -eq 3 ]; then
            #   VIEW Already Installed
        fi
        if [ $install_status -eq 0 ]; then
            #   VIEW Successfull Install
        fi
        if [ $install_status -eq 1 ]; then
            #   VIEW Failed install
        fi

        if [ $install_status -eq 3 ] || [ $install_status -eq 0 ]; then
            # RUN postinstall.sh IF [ -r programs/$program/postinstall.sh ]
            postin_status=$?
            if [ $postin_status -eq 3 ]; then
                #     VIEW Post install setup already executed
            fi
            if [ $postin_status -eq 0 ]; then
                #     VIEW Successfull Post install 
            fi
            if [ $postin_status -eq 1 ]; then
                #     VIEW Failed Post install 
            fi
        fi
    # link files
done
