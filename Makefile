.PHONY: build js css

all: .deps build
	# node node_modules/requirejs/bin/r.js -o js/build.js

stat:
	@stat -f "%N: %z bytes" compiled/umobi.min.js
	@stat -f "%N: %z bytes" compiled/umobi.min.css

build: js css

js:
	grunt --config Gruntfile.coffee js

css:
	grunt --config Gruntfile.coffee css

node_modules:
	npm install --dev --quiet

gem_modules:
	gem install sass listen

.deps: node_modules
	touch .deps

sass:
	sass -c --update css

sass-updater:
	sass -q --debug-info --watch css &

clean:
	rm -rf compiled/ .sass-cache/
