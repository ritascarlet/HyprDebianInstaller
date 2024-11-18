sudo apt install linux-headers-$(uname -r) build-essential dkms curl wget

cd

wget https://developer.download.nvidia.com/compute/nvidia-driver/560.35.03/local_installers/nvidia-driver-local-repo-debian12-560.35.03_1.0-1_amd64.deb

sudo dpkg -i nvidia-driver-local-repo-debian12-560.35.03_1.0-1_amd64.deb

sudo cp /var/nvidia-driver-local-repo-debian12-560.35.03/nvidia-driver-local-8192D793-keyring.gpg /usr/share/keyrings/

sudo apt-get install -y nvidia-open-560
