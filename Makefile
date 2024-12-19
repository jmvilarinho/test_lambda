NAME = dxc/batch
VERSION = latest

APP_NAME=$(shell echo "$(NAME)" | tr -cd '[[:alnum:]]')_$(VERSION)

# HELP
# This will output the help for each task
# author: jmvilarinho@gmail.com
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

	
build: ## Crea image python3.12
	docker build -t awslambda:python3.12 -f Dockerfile.python3.12 .

run: ## Run container
	-docker rm -f test_aws
	docker run -it --name test_aws -d -v /mnt/c/ExtraHD/test_lambda/aws-lambda:/tmp/pip/  -v /mnt/c/ExtraHD/test_lambda/init.sh:/app/init.sh awslambda:python3.12
	docker logs test_aws

stop: ## Stop container
	docker rm -f test_aws

shell: ## Run container
	docker exec -it test_aws /bin/bash
    
clean:  ## Remove unused images
	-docker rm `docker ps -a -q`
	-docker rmi `docker images -f dangling=true -q`
	-docker volume rm `docker volume ls -qf dangling=true`
	