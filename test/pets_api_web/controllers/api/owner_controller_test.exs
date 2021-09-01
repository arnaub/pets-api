defmodule PetsApiWeb.Api.OwnerControllerTest do
  use PetsApiWeb.ConnCase

  alias PetsApi.Owners

  @path "/api/owners"

  setup do
    owners =
      Enum.map(1..10, fn _ ->
        {:ok, owner} = Owners.create_owner(%{name: Faker.Person.name()})
        owner
      end)

    %{owners: owners}
  end

  test "GET owners pagination with default params returns default_per_page owners", %{conn: conn} do
    conn = get(conn, @path)
    response = json_response(conn, 200)

    assert Enum.empty?(response["errors"])
    assert Enum.count(response["owners"]) == String.to_integer(Owners.default_per_page())
  end

  test "GET owners pagination follows pagination correctly", %{conn: conn} do
    conn = get(conn, @path)
    first_page = json_response(conn, 200)
    conn = get(conn, "#{@path}?page=2")
    second_page = json_response(conn, 200)

    last_owner_first_page_id = first_page["owners"] |> Enum.at(-1) |> Map.get("id")

    first_owner_second_page_id = second_page["owners"] |> Enum.at(0) |> Map.get("id")

    assert last_owner_first_page_id + 1 == first_owner_second_page_id
  end
end
