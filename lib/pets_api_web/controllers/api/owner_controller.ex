defmodule PetsApiWeb.Api.OwnerController do
  use PetsApiWeb, :controller

  alias PetsApi.Owners
  alias PetsApi.Owners.Owner

  def index(conn, _params) do
    owners = Owners.list_owners() |> Enum.map(&Owners.owner_api_object(&1))
    json(conn, %{owners: owners, errors: []})
  end

  def show(conn, %{"id" => id}) do
    case Owners.get_owner(id) do
      %Owner{} = owner ->
        json(conn, %{owner: Owners.owner_api_object(owner), errors: []})

      nil ->
        json(conn, %{owner: nil, errors: [field: "id", message: "User not found"]})
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

  def update(conn, %{"id" => id}, params) do
  end

  defp get_error_name({key, {message, _validations}}) do
    %{field: key, message: message}
  end
end
