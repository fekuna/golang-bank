postgres:
	docker run --name pg-gobank -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it pg-gobank createdb --username=root --owner=root gobank

dropdb:
	docker exec -it pg-gobank dropdb gobank

migrateup:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/gobank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/gobank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/fekuna/golang-bank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown test server mock

# ==============================================================================
# Docker support

FILES := $(shell docker ps -aq)

down-local:
	docker stop $(FILES)
	docker rm $(FILES)

clean:
	docker system prune -f

logs-local:
	docker logs -f $(FILES)