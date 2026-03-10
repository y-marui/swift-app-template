SHELL := /bin/bash
.PHONY: bootstrap lint format test clean

bootstrap:
	bash scripts/bootstrap.sh

lint:
	bash scripts/lint.sh

format:
	swiftformat .

test:
	bash scripts/test.sh

clean:
	swift package clean
	rm -rf .build
