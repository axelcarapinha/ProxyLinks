source src/configs/config.conf

cd ~/
chmod 600 root/.ssh/"$SSH_KEY_FILENAME"
cd /app/proxylinks/src/
bash main.bash