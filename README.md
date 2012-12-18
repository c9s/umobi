<img height="120" src="https://raw.github.com/c9s/umobi/master/assets/logo.png"/>

µMobi
=======
µMobi: A Micro Mobile Web Framework for Smartphones & Tablets, 
which aims to be a smaller, faster, touch-optimized mobile web framework.

uMobi uses jQueryMobile compatible HTML template, the same template in
jQueryMobile also works in uMobi.

uMobi is pretty small, and is 11X smaller than jQueryMobile, if you 
don't need such rich components like jQueryMobile, you can simply pick up uMobi.

**WORKING IN PROGRESS**


## Why?

Though there are jQueryMobile, iUI, jqTouch frameworks for mobile web
development, but their files are too huge for 3G devices to download, the
size of jQueryMobile is even more than 220KB (without jQuery or Zepto),
but the startup bandwidth of 3G devices only has 8KB or uppper, therefore,
jQueryMobile costs more than 4-6 seconds to download the whole
jQueryMobile files.

Beyond that, jQuery runs slower 8 times than pure DOM manipulation.

But we found that the UI design, effects of jQueryMobile are so splendid,
and other frameworks are not.  So we decide to make a smaller, faster,
lighter mobile web framework, especially for 3G-bandwidth devices.

## Features

- fast 
- small
- extra feature with extensions

## Band width limitation

### Band width for 3G devices

In real world, tested with iPhone 4S

- Start up speed: 4KB ~ 8KB/s
- Maximum speed: 696.32KB/s or 0.68MB/s
- Average speed: 317KB/s or 0.31MB/s

### Band width for wifi devices

In real world, 802.11b/g/n Wi-Fi (test incomplete)


## Benchmarks

- jQuery addClass vs DOM classList: <http://jsperf.com/jquery-addclass-vs-dom-classlist/2>

## File sizes

uMobi (minified 16KB)

Zepto (minified 23KB, 22KB through Google closure compiler)

jQuery 1.8.3 (minified 32KB)

jQuery Mobile 1.2 (minified 227KB)

- jquery.mobile.min.js 119KB
- jquery.mobile.min.css 76KB
- images/ 32KB

Enyo (237KB)

- enyo.css 2.7K
- enoy.js  111K
- app.js    97K
- app.css   27K

jQuery UI 1.9.2 (minified 335KB)

- jquery-ui-1.9.2.custom.min.js 232KB
- css/ui-lightness/jquery-ui-1.9.2.custom.min.css 27KB
- images/   76KB

## Development

### Special Requirement

We use Grunt.js 0.4.x, which is still in development. there are some fixed dependencies 
to install.

- Grunt.js 0.4.x <http://github.com/gruntjs/grunt>
- Grunt-cli <http://github.com/gruntjs/grunt-cli>
- grunt-css <http://github.com/c9s/grunt-css>

Then run:

    npm install

This should install grunt dependencies and contributed tasks.

### Build 

To build compiled js through requirejs and uglifyjs:

    grunt js

To build compiled css through cssmin and jshint:

    grunt css

The compiled css/js files are located in `compiled` directory,
Below is the compiled directory structure:

    compiled
    ├── images
    │   ├── icons-18-black.png
    │   ├── icons-18-white.png
    │   ├── icons-36-black.png
    │   └── icons-36-white.png
    ├── umobi.css
    ├── umobi.js
    ├── umobi.min.css
    ├── umobi.min.js
    ├── umobi.structure.css
    ├── umobi.structure.min.css
    ├── umobi.theme.css
    └── umobi.theme.min.css

