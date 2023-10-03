docker_stack_name = promtail


it:
	@echo "make [configs|deploy|destroy]"

.PHONY: configs
configs:
	test -f "configs/promtail.yaml" || cp configs/promtail.base.yaml configs/promtail.yaml

deploy: configs
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
