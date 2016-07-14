default:

build:
	rm -fr dist/
	time ./node_modules/.bin/webpack \
	    --production --hide-modules --stats=errors-only

dist-tgz: build
	npm pack

dist-dir: dist-tgz
	tar xzf schematype-editor-*.tgz
	rm -fr schematype-editor
	mv package schematype-editor

clean:
	rm -fr schematype-editor*

start:
	npm start

open:
