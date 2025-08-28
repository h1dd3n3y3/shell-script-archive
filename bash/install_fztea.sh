#!/bin/bash

# Check and prompt tmux installation
if command -v tmux >/dev/null 2>&1; then
    echo "[+] Tmux is installed: $(tmux -V)"
else
    echo "[-] Tmux is not installed."

    while true; do
	read -p "[!] Would you like to install it now?(Y/n)" ans
	ans=${ans:-Y} # Default to Y if empty

	case "$ans" in
            [Yy])
                echo "[!] OK! Installing it now..."
                echo "[!] But first, updating..."
                sudo apt-get -y update
                sudo apt-get -y install tmux
                break
                ;;
            [Nn])
                echo "[!] OK. Ignoring tmux..."
                break
                ;;
            *)
                echo "[!] Invalid input. Please try again..."
                ;;
        esac
    done
fi

# Check and prompt go installation
if command -v go >/dev/null 2>&1; then
    echo "[+] Go is installed: $(go version)"
else
    echo "[-] Go is not installed."

    while true; do
        read -p "[!] Would you like to install it now? (Y/n) " ans
        ans=${ans:-Y}  # default to Yes if empty

        case "$ans" in
            [Yy])
                echo "[!] OK! Installing Go..."
                echo "[!] But first, downloading..."
		wget https://go.dev/dl/go1.25.0.linux-arm64.tar.gz
		echo "[!] Cleaning up previous installation..."
		sudo rm -rf /usr/local/go
		echo "[!] Extracting archive..."
		sudo tar -C /usr/local -xzf go1.25.0.linux-arm64.tar.gz
		echo "[!] Putting it to PATH..."
		echo 'export PATH=$PATH:/usr/local/go/bin' >> .bashrc
		source ~/.bashrc
                break
                ;;
            [Nn])
                echo "[!] OK. Ignoring Go installation..."
                break
                ;;
            *)
                echo "[!] Invalid input. Please try again..."
                ;;
        esac
    done
fi

# Install fztea
echo "[!] Installing fztea via go..."
go install github.com/jon4hz/fztea@latest
echo "[!] Moving fztea under /usr/local/go/bin/..."
sudo mv -iv $HOME/go/bin/fztea /usr/local/go/bin/
sudo chown root:root /usr/local/go/bin/fztea
ls -l /usr/local/go/bin/fztea
echo "[!] Removing obsolete files..."
sudo rm -rf $HOME/go/ go*tar.gz
echo "[+] Done!"
