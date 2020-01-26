.PHONY: serve
serve: install stop server.pid
	bundle exec guard -g serve
	@echo to stop run "make stop"

server.pid:
	bundle exec ruby app.rb & echo $$! > $@;

.PHONY: stop
stop: server.pid
	kill `cat $<` || true
	rm $<

.PHONY: install
install:
	bundle install
