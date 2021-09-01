# PetsApi

To start your Phoenix server:

- Setup local configuration:
  - copy `config/dev.local.exs.example` to `config/dev.local.exs`
  - copy `config/test.local.exs.example` to `config/test.local.exs`
  - Update `.local.exs` files if it's needed.
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Seeds

```
mix run priv/repo/seeds.exs
```

## Endpoints

Owners

```
http://localhost:4000/api/owners // default options
http://localhost:4000/api/owners?page=2&per_page=5
```

Pets

```
http://localhost:4000/api/pets // default options
http://localhost:4000/api/pets?page=2&per_page=5
```

Pets by Owner

```
http://localhost:4000/api/owners/:owner_id/pets // default options
http://localhost:4000/api/owners/:owner_id/pets?page=2&per_page=5
```

### Extra Endpoints

Show owner

```
http://localhost:4000/api/owners/:owner_id
```

Create owner

```
curl -d '{"name":"arnau"}' -H "Content-Type: application/json" -X POST http://localhost:4000/api/owners/
```

Update owner

```
curl -d '{"owner": {"names":"david"}}' -H "Content-Type: application/json" -X PUT http://localhost:4000/api/owners/:owner_id
```

Delete owner

```
curl -H "Content-Type: application/json" -X DELETE http://localhost:4000/api/owners/:owner_id
```

## Test

```
mix test
```

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
