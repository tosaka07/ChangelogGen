PRODUCT_NAME = ChangelogGen
EXECUTABLE_NAME = changeloggen

PREFIX? = /usr/local
INSTALL_PATH = $(PREFIX)/bin/$(EXECUTABLE_NAME)

.PHONY: generate build-debug build install

generate:
	@swift package generate-xcodeproj

build-debug:
	@swift build

build:
	@swift build -c release --disable-sandbox

install: build
	@mkdir -p "$(PREFIX)/bin"
	@cp -f ".build/release/$(EXECUTABLE_NAME)" $(INSTALL_PATH)
