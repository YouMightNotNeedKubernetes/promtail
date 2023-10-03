docker_stack_name = promtail


it:
	@echo "make [deploy|destroy]"

deploy:
	test -f "configs/promtail.yaml" || cp configs/promtail.base.yaml configs/promtail.yaml
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
