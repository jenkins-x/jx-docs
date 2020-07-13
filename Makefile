HUGO_VERSION := v0.74.0

.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -h -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: server 
server: ## Runs Hugo locally `hugo server`
	@hugo version | grep -q $(HUGO_VERSION) || echo "Your Hugo version does not match the recommended Hugo version $(HUGO_VERSION). If you are having problems make sure to align your version."
	@hugo server

.PHONY: generate 
generate: ## Let's hugo generate the site into the configured directory
	# Generating locally, since in container an error is thrown
	@hugo -d public

.PHONY: compose-up 
compose-up: ## Runs Hugo in container in background via Docker Compose
	docker-compose up -d server

.PHONY: compose-down 
compose-down: ## Stops Hugo container
	docker-compose down	

.PHONY: spellcheck
spellcheck: ## Runs spell checker using Docker Compose in foreground
	docker-compose up spellchecker

.PHONY: linkcheck
linkcheck: generate ## Runs spell checker using Docker Compose in foreground
	docker-compose run linkchecker	

.PHONY: clean
clean: ## Deletes temporary/generated files
	rm -rf public
	rm -rf resources
