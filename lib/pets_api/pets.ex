defmodule PetsApi.Pets do
  @moduledoc """
  The Pets context.
  """

  import Ecto.Query, warn: false
  alias PetsApi.Repo

  alias PetsApi.Pets.Pet

  def pet_api_object(pet) do
    pet
    |> Map.take([:id, :name, :inserted_at, :updated_at])
  end

  def default_per_page, do: "7"
  def default_page, do: "1"

  @doc """
  Returns a list of pets matching the given params.
  Example params:
  %{owner_id: owner_id, page: 2, per_page: 5},
  """
  def paginate_pets_by_owner(owner_id, %{page: page, per_page: per_page}) do
    pets_by_owner_query(Pet, owner_id)
    |> pets_pagination_query(%{page: page, per_page: per_page})
    |> Repo.all()
  end

  @doc """
  Returns a list of pets matching the given params.
  Example params:
  %{page: 2, per_page: 5},
  """
  def paginate_pets(%{page: _page, per_page: _per_page} = params) do
    Repo.all(pets_pagination_query(Pet, params))
  end

  @doc """
  Returns the list of pets.

  ## Examples

      iex> list_pets()
      [%Pet{}, ...]

  """
  def list_pets do
    Repo.all(Pet)
  end

  @doc """
  Gets a single pet.

  Raises `Ecto.NoResultsError` if the Pet does not exist.

  ## Examples

      iex> get_pet!(123)
      %Pet{}

      iex> get_pet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pet!(id), do: Repo.get!(Pet, id)

  @doc """
  Creates a pet.

  ## Examples

      iex> create_pet(%{field: value})
      {:ok, %Pet{}}

      iex> create_pet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pet(attrs \\ %{}) do
    %Pet{}
    |> Pet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pet.

  ## Examples

      iex> update_pet(pet, %{field: new_value})
      {:ok, %Pet{}}

      iex> update_pet(pet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pet(%Pet{} = pet, attrs) do
    pet
    |> Pet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pet.

  ## Examples

      iex> delete_pet(pet)
      {:ok, %Pet{}}

      iex> delete_pet(pet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pet(%Pet{} = pet) do
    Repo.delete(pet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pet changes.

  ## Examples

      iex> change_pet(pet)
      %Ecto.Changeset{data: %Pet{}}

  """
  def change_pet(%Pet{} = pet, attrs \\ %{}) do
    Pet.changeset(pet, attrs)
  end

  defp pets_by_owner_query(queryable, owner_id) do
    from p in queryable,
      where: p.owner_id == ^owner_id
  end

  defp pets_pagination_query(queryable, %{page: page, per_page: per_page}) do
    from p in queryable,
      offset: ^((page - 1) * per_page),
      limit: ^per_page,
      order_by: p.id
  end
end
