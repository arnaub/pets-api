defmodule PetsApiWeb.Api.OwnerController do
  use PetsApiWeb, :controller

  alias PetsApi.Owners
  alias PetsApi.Owners.Owner

  def index(conn, params) do
    pagination_params = build_pagination_params(params)
    owners = Owners.paginate_owners(pagination_params) |> Enum.map(&Owners.owner_api_object(&1))
    json(conn, %{owners: owners, errors: []})
  end

  def show(conn, %{"id" => id}) do
    case Owners.get_owner(id) do
      %Owner{} = owner ->
        json(conn, %{owner: Owners.owner_api_object(owner), errors: []})

      nil ->
        json(conn, %{owner: nil, errors: [%{field: "id", message: "User not found"}]})
    end
  end

  def create(conn, params) do
    case Owners.create_owner(params) do
      {:ok, owner} ->
        json(conn, %{owner: Owners.owner_api_object(owner), errors: []})

      {:error, changeset} ->
        json(conn, %{owner: nil, errors: changeset.errors |> Enum.map(&get_error_name(&1))})
    end
  end

  def update(conn, %{"id" => id, "owner" => owner_params}) do
    owner = Owners.get_owner!(id)

    case Owners.update_owner(owner, owner_params) do
      {:ok, owner} ->
        json(conn, %{owner: Owners.owner_api_object(owner), errors: []})

      {:error, changeset} ->
        json(conn, %{owner: nil, errors: changeset.errors |> Enum.map(&get_error_name(&1))})
    end
  end

  def delete(conn, %{"id" => id}) do
    case Owners.get_owner(id) do
      %Owner{} = owner ->
        case Owners.delete_owner(owner) do
          {:ok, owner} ->
            json(conn, %{owner: Owners.owner_api_object(owner), errors: []})

          {:error, changeset} ->
            json(conn, %{owner: nil, errors: changeset.errors |> Enum.map(&get_error_name(&1))})
        end

      nil ->
        json(conn, %{owner: nil, errors: [%{field: "id", message: "User not found"}]})
    end
  end

  defp build_pagination_params(params) do
    %{
      per_page: String.to_integer(params["per_page"] || Owners.default_per_page()),
      page: String.to_integer(params["page"] || Owners.default_page())
    }
  end

  defp get_error_name({key, {message, _validations}}) do
    %{field: key, message: message}
  end
end
