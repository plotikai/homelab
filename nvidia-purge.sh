sudo nvidia-uninstall
sudo apt purge -y '^nvidia-*' '^libnvidia-*'
sudo rm -r /var/lib/dkms/nvidia
sudo apt -y autoremove
sudo update-initramfs -c -k `uname -r`
sudo update-grub2
read -p "Press any key to reboot... " -n1 -s
sudo reboot
