#!/usr/bin/env python3
import subprocess
import time
import sys

# Try to import and initialize the Sense HAT. 
# If it's missing or not a Raspberry Pi, exit gracefully.
try:
    from sense_hat import SenseHat
    sense = SenseHat()
except (ImportError, OSError):
    sys.exit(0)

def get_ip_address():
    try:
        # 'hostname -I' returns all IP addresses; we split it and take the first one (IPv4)
        ip = subprocess.check_output(['hostname', '-I']).decode('utf-8').strip().split()[0]
        return ip
    except Exception:
        return None

# Wait for the network to assign an IP address during boot
ip_address = None
for _ in range(12):  # Try for up to 60 seconds (12 tries * 5 seconds)
    ip_address = get_ip_address()
    if ip_address:
        break
    time.sleep(5)

# Fallback if no IP is found after 60 seconds
if not ip_address:
    ip_address = "No Network"

# Optional: Un-comment the line below if your display is upside down
# sense.set_rotation(180) 

# Display the IP address 3 times
for _ in range(3):
    sense.show_message(
        "IP: " + ip_address, 
        text_colour=[0, 255, 0],  # Green text
        back_colour=[0, 0, 0],    # Black background
        scroll_speed=0.08         # Adjust for faster/slower scrolling
    )
    time.sleep(1) # Small pause between scrolls

# Clear the LEDs when finished
sense.clear()