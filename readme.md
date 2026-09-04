# Sense HAT IP Display on Boot

A simple script for headless Raspberry Pi setups. It automatically runs at boot, waits for the network, and scrolls your Pi's IP address across the Sense HAT LED matrix three times so you know exactly where to SSH into (to avoid the hassle of connecting a monitor and keyboard).

## Requirements

* Raspberry Pi with a Sense HAT attached
* `sense-hat` Python library (Install via: `sudo apt install python3-sense-hat` should be installed by default on Raspbian)

## Download & Installation

It is recommended to clone this repository into your home directory (`~`) so it stays in a safe, permanent location. 

Open your Raspberry Pi terminal and run the following commands:

```bash
cd ~
git clone https://github.com/perhenrikgithub/RaspberryPiShowIpOnBoot.git
cd RaspberryPiShowIpOnBoot
make install
```


## Uninstallation
If you no longer want the script to run on boot, simply navigate back to the folder and run the uninstall command:

```bash
make uninstall
```