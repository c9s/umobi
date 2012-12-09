


sass:
	sass -c --update css

sass-updater:
	sass -q --watch css &

all:
	node node_modules/requirejs/bin/r.js -o js/build.js

node_modules:
	npm install requirejs

gem_modules:
	gem install sass listen

deps: node_modules gem_modules

