# Install Portainer
docker volume create portainer_data

docker run -d \
  -p 8000:8000 
  -p 9443:9443 
  --name portainer 
  --restart=always 
  -v /var/run/docker.sock:/var/run/docker.sock 
  -v portainer_data:/data 
  portainer/portainer-ce:latest

# Install Portainer Agent https://docs.portainer.io/admin/environments/add/docker/agent
docker run -d \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  -v /:/host \ # If you want to use the host management features of the Portainer Agent
  portainer/agent:2.19.1

# Install Plex
docker volume create plex_config

docker run -d \
  --name=plex \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ="America/Vancouver" \ 
  -e PLEX_CLAIM="claim-s6-ZV1uHyqbFZNiSLAh9" \     # Get claim code: https://www.plex.tv/claim/
  -e VERSION=docker \
  -e NVIDIA_VISIBLE_DEVICES=all \                  # To passthrough GPU to container
  -v plex_config:/config \
  -v /mnt/media/movies:/Movies \
  -v /mnt/media/television:/Television \
  -v /mnt/media/music:/Music \
  --device /dev/dri/renderD128:/dev/dri/renderD128 # If Intel Quick Sync is enabled
  --device /dev/dri/card0:/dev/dri/card0           # If Intel Quick Sync is enabled
  --restart unless-stopped \
  lscr.io/linuxserver/plex:latest

# Install Watchtower https://containrrr.dev/watchtower
docker run --detach \
    --name watchtower \
    -e TZ="America/Vancouver" \ 
    -e WATCHTOWER_CLEANUP="true" # Removes old image
    --volume /var/run/docker.sock:/var/run/docker.sock \
    containrrr/watchtower

# Install Kasm https://kasmweb.com/docs/latest/install/single_server_install.html
# Create swap first
sudo fallocate -l 4g /mnt/4GiB.swap
sudo chmod 600 /mnt/4GiB.swap
sudo mkswap /mnt/4GiB.swap
sudo swapon /mnt/4GiB.swap
cat /proc/swaps # Verify swap exists
echo '/mnt/4GiB.swap swap swap defaults 0 0' | sudo tee -a /etc/fstab # Make swap available on boot

cd /tmp
curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.14.0.3a7abb.tar.gz
tar -xf kasm_release_1.14.0.3a7abb.tar.gz
sudo bash kasm_release/install.sh
