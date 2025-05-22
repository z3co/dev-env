# Dev env setup
Some scripts to set up archlinux to my liking in minutes and not half an hour

## How to use it?
From a clean install of archlinux simply edit the packages.conf file using your prefered editor.(The best one of course being neovim) Add the packages you need under the categorys you think fits them best, or just put them all in one of the categorys if you are weird. Add any package you like from the AUR or the official repos, and add any flatpaks in the flatpak category. Note that flatpaks can only be installed if listed in the FLATPAK category in the packages.conf. For help structuring the packages.conf just see my example in the repo [packages.conf](https://github.com/z3co/dev-env/blob/main/packages.conf).

***Remember to cd into the repo with these scripts***

Now you are ready to run the script(Hopefully)
```bash
./run.sh
```
**<span style="color: red">DONT RUN ANY OF THE SCRIPTS AS ROOT(Meaning dont use sudo)</span>**

If you use tmux you can install Tmux Plugin Manager by running the install-tpm.sh script
```bash
./install-tpm.sh
```

If your have a dotfiles setup for stow like [mine](https://github.com/z3co/dotfiles) you can use the stow-dotfiles.sh script toeasily set them up. Just add the REPO_URL env variable to the packages.conf like in [my example](https://github.com/z3co/dev-env/blob/main/packages.conf), it nees to point to your dotfile repo. The add all the folders to be stowed names, not full paths just there names, to the CONFIG_LIST in the packages.conf, see my example [packages.conf](https://github.com/z3co/dev-env/blob/main/packages.conf) for better understanding. 

When that is done you can run the stow-dotfiles.sh(You need to have git and stow installed)
```bash
./stow-dotfiles.sh
```
*The dotfiles will be cloned into ~/dotfiles, there you can make any changes to them you want stow will auto update the real dotfiles*


### Custom keybinds
For custom keybinds i recommend [kanata](https://github.com/jtroo/kanata)

To try it out just install kanata by adding it to the packages.conf. Then you can add your kanata config to the dotfiles repo at ~/dotfiles. For an example see [my setup](https://github.com/z3co/dotfiles/tree/main/kanata/.config) where i swap capslock for esc/ctrl and esc for capslock. Note that we also a systemd service file in here as that is needed for running kanata on arch linux. For that you can copy mine and put it correctly in your dotfiles repo.

Now you can run the [install-kanata.sh](https://github.com/z3co/dev-env) script
```bash
./install-kanata.sh
```

## Credit typecraft_dev
Typecraft has written most of this i have only made few adjustments for it to better fit my use case, go visit the yt channel

- [Youtube](https://youtube.com/@typecraft_dev)
- [Github](https://github.com/typecraft-dev/crucible)

## Contributing
You are very welcome to contribute

- Fork the repo
- Clone to your machine  ``` git clone https://github.com/z3co/dev-env.git ```
- Make your changes commit and push
- Create a pull request with your changes
