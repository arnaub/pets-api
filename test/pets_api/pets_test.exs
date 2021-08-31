defmodule PetsApi.PetsTest do
  use PetsApi.DataCase

  alias PetsApi.Pets
  alias PetsApi.Owners

  describe "pets" do
    alias PetsApi.Pets.Pet

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def owner_fixture do
      {:ok, owner} = Owners.create_owner(%{name: "some owner name"})
      owner
    end

    def pet_fixture(attrs \\ %{}) do
      owner = owner_fixture()

      {:ok, pet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.merge(%{owner_id: owner.id})
        |> Pets.create_pet()

      pet
    end

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert Pets.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert Pets.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      owner = owner_fixture()

      assert {:ok, %Pet{} = pet} =
               Pets.create_pet(@valid_attrs |> Map.merge(%{owner_id: owner.id}))

      assert pet.name == "some name"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pets.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{} = pet} = Pets.update_pet(pet, @update_attrs)
      assert pet.name == "some updated name"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = Pets.update_pet(pet, @invalid_attrs)
      assert pet == Pets.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = Pets.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> Pets.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = Pets.change_pet(pet)
    end
  end
end
