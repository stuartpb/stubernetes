mkdir -p /root/.ssh
curl $ROOT_KEY_SOURCE > /root/.ssh/authorized_keys
chmod 0600 /root/.ssh/authorized_keys
