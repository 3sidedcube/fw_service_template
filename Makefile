.PHONY:

up-and-build:
	docker-compose up -d --build

up:
	docker-compose up -d

down:
	docker-compose down

logs:
	docker logs -f fw-service-template

tests:
	docker logs -f fw-service-template-test
