defmodule PetsApi.DatabaseSeeder do
  alias PetsApi.Owners
  alias PetsApi.Owners.Owner
  alias PetsApi.Pets

  alias PetsApi.Repo
  @owners_count 200
  @pets_count 20

  def run do
    delete_data()
    create_owners()
  end

  defp create_owners() do
    Enum.map(1..@owners_count, fn _ ->
      {:ok, owner} = Owners.create_owner(%{name: Faker.Person.name()})
      create_pets(owner)
    end)
  end

  defp create_pets(owner) do
    Enum.map(1..@pets_count, fn _ ->
      Pets.create_pet(%{name: Faker.Cat.name(), owner_id: owner.id})
    end)
  end

  defp delete_data do
    Repo.delete_all(Owner)
  end
end

PetsApi.DatabaseSeeder.run()
