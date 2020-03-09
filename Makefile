PRODUCT_NAME = ChangelogGen

generate:
	@swift package generate-xcodeproj

build-debug:
	@swift build

.PHONY: generate build-debug run