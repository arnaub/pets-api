defmodule PetsApiWeb.Api.PetController do
  use PetsApiWeb, :controller

  alias PetsApi.Pets

  def index(conn, %{"owner_id" => owner_id} = params) do
    pagination_params = build_pagination_params(params)

    pets =
      Pets.paginate_pets_by_owner(owner_id, pagination_params)
      |> Enum.map(&Pets.pet_api_object(&1))

    json(conn, %{pets: pets, errors: []})
  end

  def index(conn, params) do
    pagination_params = build_pagination_params(params)

    pets =
      Pets.paginate_pets(pagination_params)
      |> Enum.map(&Pets.pet_api_object(&1))

    json(conn, %{pets: pets, errors: []})
  end

  defp build_pagination_params(params) do
    %{
      per_page: String.to_integer(params["per_page"] || Pets.default_per_page()),
      page: String.to_integer(params["page"] || Pets.default_page())
    }
  end
end
