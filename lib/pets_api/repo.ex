defmodule PetsApi.Repo do
  use Ecto.Repo,
    otp_app: :pets_api,
    adapter: Ecto.Adapters.Postgres
end
