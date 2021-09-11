curl -L https://github.com/thesofproject/sof-bin/archive/refs/heads/main.tar.gz | tar xz
cd sof-bin-main
mkdir -p /lib/firmware/intel
./install.sh v1.8.x/v1.8
