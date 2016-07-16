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

open:
	open http://127.0.0.1:8080

restart: stop start

start:
	@[ ! -f .server.pid ] || { echo 'already running'; exit 1; }
	node server.js --schematype-editor 2>&1 > .server.log & \
	    echo $$! > .server.pid

stop:
	@[ -f .server.pid ] || exit 1
	kill -9 `cat .server.pid`
	rm .server.pid

show:
	@[ ! -f .server.pid ] || echo "Running pid $$(cat .server.pid)"
	@ps aux | grep schematype-editor | grep -v grep || true

clean:
	rm -fr schematype-editor* package
