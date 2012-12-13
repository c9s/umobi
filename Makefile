.PHONY: build

all: build
	# node node_modules/requirejs/bin/r.js -o js/build.js
	# ls -lh js/umobi.min.js

build:
	grunt --config Gruntfile.coffee js
	grunt --config Gruntfile.coffee css

node_modules:
	npm install

gem_modules:
	gem install sass listen

deps: node_modules gem_modules

sass:
	sass -c --update css

sass-updater:
	sass -q --watch css &


