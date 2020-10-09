# node-setup

This directory contains utility scripts and resources I use to bootstrap the initial stages of nodes in my personal Kubernetes cluster (running on [OpenSUSE Kubic](https://kubic.opensuse.org/) as of 2020-10-01).

They are all laid out to be run from this directory.

## config-writers

These are scripts that make files to be placed on removable media to configure a freshly-installed system.

The `combustion` directory contains a script to write a sequence of commands (ie. another script) that will configure a Kubic node to conform to the current specification (as of 2020-10-01):

- setting the hostname
- setting root keys
- systemd-networkd and systemd-resolved replacing wicked
  - DHCP on ethernet with search domain
- ensuring laptops stay on when the lid is closed

The `ignition` directory contains scripts to generate Ignition configuration files for some subset of the above. They are obsolete, and likely to be removed in a future release. The only reason they haven't been removed here is because they are still technically more portable than the Kubic-specific `combustion`, and may be revisited at some point in the future if the cluster migrates away from Kubic.

## files

These are source files, mostly from previous iterations of the project:

-`kubic/dhcp.cfg` is an altered version of a default Kubic config file to set Wicked to not use the hostname from DHCP.
  - This ultimately didn't solve the problem this config tweak was intended to fix;
  - In any case, the configuration has moved toward `systemd-networkd` instead, so this file is no longer used.
- `logind.conf` is the expected state of `/etc/systemd/logind.conf` after running `steps/disable-lid-switch.sh`.

## mount-tweakers

These are scripts used to modify/pre-configure a flashed image, rather than relying on a config source like ignition/combustion to configure the installed system on first boot.

The `mount-tweakers/load-root-keys.sh` script mounts the subvolume for `/root` from a given Kubic btrfs partition and copies

## steps

These are separate shell snippet scripts for each step taken by the `combustion` script, to be composed as needed.

They can also be invoked manually, eg. by executing redirected output from a curl request to the repo on GitHub within an instance of `transactional-update shell`.
