#Makefile
.PHONY: run
run: 
	git submodule init
	docker-compose up --build --exit-code-from nginx 
	
.PHONY: rm-docker
rm-docker: 
	docker-compose rm --force --stop

.PHONY: rm-data-updater
rm-data-updater:
	docker volume rm nginx-online-router_oc_updater_data

.PHONY: rm-data-admin
rm-data-admin:
	docker volume rm nginx-online-router_data

.PHONY: rm-and-run
rm-and-run: rm-docker rm-data-admin run