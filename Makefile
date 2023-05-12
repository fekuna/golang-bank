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

.PHONY: postgres createdb dropdb migrateup migratedown test