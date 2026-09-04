# Get the absolute path of the directory
PYTHON_SCRIPT = $(PWD)/display_ip.py

install:
	@echo "Checking hardware..."
	@if [ -f /sys/firmware/devicetree/base/model ] && grep -iq "raspberry" /sys/firmware/devicetree/base/model; then \
		echo "✅ Raspberry Pi detected."; \
	else \
		echo "❌ Error: This device does not appear to be a Raspberry Pi."; \
		exit 1; \
	fi
	@python3 -c "from sense_hat import SenseHat; SenseHat()" 2>/dev/null && echo "✅ Sense HAT detected." || (echo "❌ Error: Sense HAT not found or python3-sense-hat library missing. Try 'sudo apt install python3-sense-hat' or ask llm 'How do I install the python3-sense-hat library on a Raspberry Pi?'" && exit 1)
	@echo "Setting execution permissions..."
	@chmod +x display_ip.py
	@echo "Installing cron job..."
	@crontab -l 2>/dev/null | grep -v "$(PYTHON_SCRIPT)" > mycron || true
	@echo "@reboot /usr/bin/python3 $(PYTHON_SCRIPT) &" >> mycron
	@crontab mycron
	@rm mycron
	@echo "🎉 Installed successfully! The IP will display on next boot."
	@echo "🚀 Running a test now... (this is how it will show on boot)"
	@/usr/bin/python3 $(PYTHON_SCRIPT)

uninstall:
	@echo "Removing cron job..."
	@crontab -l 2>/dev/null | grep -v "$(PYTHON_SCRIPT)" > mycron || true
	@crontab mycron
	@rm mycron
	@echo "🗑️ Uninstalled successfully!"