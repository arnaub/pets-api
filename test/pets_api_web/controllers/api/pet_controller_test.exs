defmodule PetsApiWeb.Api.PetControllerTest do
  use PetsApiWeb.ConnCase

  alias PetsApi.Owners
  alias PetsApi.Pets

  @path "/api/pets"

  setup do
    owners =
      Enum.map(1..10, fn _ ->
        {:ok, owner} = Owners.create_owner(%{name: Faker.Person.name()})
        create_pets(owner)
        owner
      end)

    %{owners: owners}
  end

  test "GET pets pagination with default params returns default_per_page pets", %{conn: conn} do
    conn = get(conn, @path)
    response = json_response(conn, 200)

    assert Enum.empty?(response["errors"])
    assert Enum.count(response["pets"]) == String.to_integer(Pets.default_per_page())
  end

  test "GET pets pagination by owner returns owner's pets", %{conn: conn} do
    {:ok, owner} = Owners.create_owner(%{name: Faker.Person.name()})
    {:ok, pet} = Pets.create_pet(%{name: Faker.Cat.name(), owner_id: owner.id})
    conn = get(conn, "api/owners/#{owner.id}/pets")
    response = json_response(conn, 200)
    pet_ids = response["pets"] |> Enum.map(fn pet -> pet["id"] end)
    assert pet_ids == [pet.id]
  end

  defp create_pets(owner) do
    Enum.map(1..10, fn _ ->
      Pets.create_pet(%{name: Faker.Cat.name(), owner_id: owner.id})
    end)
  end
end
