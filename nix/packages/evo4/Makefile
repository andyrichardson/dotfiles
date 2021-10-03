PREFIX ?= /usr
ROOT ?= /
UDEV_DIR ?= $(PREFIX)/lib/udev/rules.d
BIN_DIR ?= $(PREFIX)/local/bin

RULE_FILE = 90-pulseaudio-evo4.rules
SCRIPT_FILE = evo4.sh
SERVICE_FILE = evo4.service

install:
	@mkdir -p $(BIN_DIR)
	@cp $(SCRIPT_FILE) $(BIN_DIR)/$(SCRIPT_FILE)
	@mkdir -p $(ROOT)/etc/systemd/system
	@cp $(SERVICE_FILE) $(ROOT)/etc/systemd/system/$(SERVICE_FILE)
	@chmod +x $(BIN_DIR)/$(SCRIPT_FILE)
	@mkdir -p $(UDEV_DIR)
	@sed "s|RUN_TARGET|$(BIN_DIR)/$(SCRIPT_FILE)|g" $(RULE_FILE) > $(UDEV_DIR)/$(RULE_FILE)
