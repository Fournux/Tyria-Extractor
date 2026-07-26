.PHONY: all build build-capture inject extract extract-all extract-skills extract-images extract-items extract-quests extract-npcs extract-vendors validate-items regen check test fmt help

PYTHON ?= python3

all: build

build:
	cargo build --release -p tyria-extractor-rs

build-capture:
	cargo build --release --target i686-pc-windows-msvc -p tyria_sniffer -p tyria_injector

inject:
	target/i686-pc-windows-msvc/release/tyria_injector.exe Gw.exe target/i686-pc-windows-msvc/release/tyria_sniffer.dll

extract: extract-all

extract-all:
	$(PYTHON) tools/extract.py all

extract-skills:
	$(PYTHON) tools/extract.py skills

extract-images:
	$(PYTHON) tools/extract.py images

extract-items:
	$(PYTHON) tools/extract.py items

extract-quests:
	$(PYTHON) tools/extract.py quests

extract-npcs:
	$(PYTHON) tools/extract.py npcs

extract-vendors:
	$(PYTHON) tools/extract.py vendors

validate-items:
	$(PYTHON) tools/validate_items_catalog.py output/items/items.json --require-complete

regen: extract-all validate-items

check:
	cargo check --workspace

test:
	cargo test --workspace

fmt:
	cargo fmt --all

help:
	@echo "TyriaExtractor Makefile targets:"
	@echo "  build           Build extractor CLI (release)"
	@echo "  build-capture   Build Win32 sniffer & injector"
	@echo "  inject          Run injector on Gw.exe"
	@echo "  extract-all     Run all extraction pipelines"
	@echo "  extract-skills  Extract skills catalog & icons"
	@echo "  extract-images  Extract map/UI images"
	@echo "  extract-items   Extract items (requires capture)"
	@echo "  extract-quests  Extract quests (requires capture)"
	@echo "  extract-npcs    Extract NPCs (requires capture)"
	@echo "  extract-vendors Extract vendors (requires capture)"
	@echo "  validate-items  Validate items output catalog"
	@echo "  regen           Run extract-all and validate-items"
	@echo "  check           Run cargo check"
	@echo "  test            Run cargo test"
	@echo "  fmt             Run cargo fmt"
