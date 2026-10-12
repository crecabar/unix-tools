
PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin
CONFIGDIR ?= $(HOME)/.config/unix-tools

SCRIPTS := $(wildcard bin/*)
INSTALLED_SCRIPTS := $(patsubst bin/%,$(BINDIR)/%,$(SCRIPTS))

.PHONY: all help install uninstall reinstall

.DEFAULT_GOAL := help

all: install

help:
	@echo "Unix Tools"
	@echo ""
	@echo "Targets:"
	@echo "  install     Install scripts and default configuration"
	@echo "  uninstall   Remove installed scripts"
	@echo "  reinstall   Reinstall scripts"
	@echo "  help        Show this help"
	@echo ""
	@echo "Directories:"
	@echo "  BINDIR      $(BINDIR)"
	@echo "  CONFIGDIR   $(CONFIGDIR)"

install: $(INSTALLED_SCRIPTS)
	@install -d "$(CONFIGDIR)"
	@if [ ! -e "$(CONFIGDIR)/wake-lab.conf" ]; then \
		install -m 600 \
			config/wake-lab.conf.example \
			"$(CONFIGDIR)/wake-lab.conf"; \
		echo "Created wake-lab configuration"; \
	else \
		echo "Keeping existing wake-lab configuration"; \
	fi

$(BINDIR)/%: bin/%
	@install -d "$(BINDIR)"
	@install -m 755 "$<" "$@"
	@echo "Installed $@"

uninstall:
	@for script in $(notdir $(SCRIPTS)); do \
		rm -f "$(BINDIR)/$$script"; \
		echo "Removed $$script"; \
	done
	@echo "Configuration files preserved"

reinstall:
	@$(MAKE) uninstall
	@$(MAKE) install

