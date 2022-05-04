# Calendeno API

## Documentation

https://calendeno.github.io/api/

## Development

### Run Rails server

```bash
docker compose up app
```

### Run tests

```bash
# You must run server before running tests.
docker compose exec app bundle exec rspec
```

### Run Redoc to preview API documentation

```bash
docker compose up doc
```

Then, preview server is running at http://localhost:18080/
