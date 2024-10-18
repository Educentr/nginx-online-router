#Makefile
.PHONY: run
run:
	git submodule update --init --recursive
	git submodule sync
	docker compose up --build --exit-code-from nginx

run-scale:
	git submodule update --init --recursive
	git submodule sync
	docker compose up --scale testapp1=3 --scale testapp2=3 --build --exit-code-from nginx

.PHONY: clean
clean: rm-docker rm-data-updater rm-data-admin

.PHONY: rm-docker
rm-docker:
	docker compose rm --force --stop

.PHONY: rm-data-admin
rm-data-admin:
	docker volume rm nginx-online-router_data

.PHONY: rm-data-updater
rm-data-updater:
	docker volume rm nginx-online-router_oc_updater_data
