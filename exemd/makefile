.DEFAULT_GOAL := all

.build/0-client.css: assets/less/client.less assets/less/material.less
	lessc assets/less/client.less .build/0-client.css

_site/css/client.css: .build/0-client.css
	@mkdir -p _site/css/
	cp .build/0-client.css $@

.build/1-index.html: assets/example.html assets/index.jade
	cat assets/index.jade  | jade -O ./site.json -P -p assets/index.jade | beml-cli  | stupid-replace {{include}} -f ./assets/example.html | stupid-replace {{usage}} -f ./assets/usage.html > .build/1-index.html 

_site/index.html: .build/1-index.html
	@mkdir -p _site/
	cp .build/1-index.html $@

.build/2-client.js: assets/js/client.ls
	browserify -t liveify assets/js/client.ls -o .build/2-client.js

_site/js/client.js: .build/2-client.js
	@mkdir -p _site//js
	cp .build/2-client.js $@

.build/3-example.md: assets/example.md
	cp assets/example.md .build/3-example.md

_site/example.md: .build/3-example.md
	@mkdir -p _site/
	cp .build/3-example.md $@

.PHONY : cmd-4
cmd-4: 
	../cli.js -g ./assets/example.md > ./assets/example.html

.PHONY : cmd-5
cmd-5: 
	(echo "\`\`\`" && cat ../docs/usage.md && echo "\`\`\`" && cat ../docs/description.md) | pandoc > ./assets/usage.html

.PHONY : update-docs
update-docs: cmd-4 cmd-5

.PHONY : all
all: _site/css/client.css _site/index.html _site/js/client.js _site/example.md update-docs

.PHONY : cmd-6
cmd-6: 
	make update-docs

.PHONY : cmd-7
cmd-7: 
	make all

.PHONY : cmd-8
cmd-8: 
	blog-ftp-cli -l _site -r /exemd

.PHONY : cmd-seq-9
cmd-seq-9: 
	make cmd-6
	make cmd-7
	make cmd-8

.PHONY : deploy
deploy: cmd-seq-9

.PHONY : clean-10
clean-10: 
	rm -rf .build/0-client.css _site/css/client.css .build/1-index.html _site/index.html .build/2-client.js _site/js/client.js .build/3-example.md _site/example.md

.PHONY : clean-11
clean-11: 
	rm -rf .build

.PHONY : clean-12
clean-12: 
	mkdir -p .build

.PHONY : cmd-13
cmd-13: 
	rm -rf _site

.PHONY : clean
clean: clean-10 clean-11 clean-12 cmd-13
