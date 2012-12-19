.PHONY: build js css

all: .deps build

stat:
	@stat -f "%N: %z bytes" compiled/umobi.min.js
	@stat -f "%N: %z bytes" compiled/umobi.min.css

build:
	grunt --no-color

js:
	grunt --no-color js

css:
	grunt --no-color css

gem_modules:
	gem install sass listen

.deps:
	npm install --quiet
	tuouch .deps

sass:
	sass -c --update css

sass-updater:
	sass -q --debug-info --watch css &

clean:
	rm -rf compiled/ .sass-cache/ .deps

clean_all: clean
	rm -rf node_modules
