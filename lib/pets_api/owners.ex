defmodule PetsApi.Owners do
  @moduledoc """
  The Owners context.
  """

  import Ecto.Query, warn: false
  alias PetsApi.Repo

  alias PetsApi.Owners.Owner

  @doc """
  Returns an owner object for API responses.
  """
  def owner_api_object(owner) do
    owner
    |> Map.take([:id, :name, :inserted_at, :updated_at])
  end

  def default_per_page, do: "5"
  def default_page, do: "1"

  @doc """
  Returns a list of owners matching the given params.
  Example params:
  %{page: 2, per_page: 5},
  """
  def paginate_owners(%{page: page, per_page: per_page}) do
    query =
      from o in Owner,
        offset: ^((page - 1) * per_page),
        limit: ^per_page,
        order_by: o.id

    Repo.all(query)
  end

  @doc """
  Returns the list of owners.

  ## Examples

      iex> list_owners()
      [%Owner{}, ...]

  """
  def list_owners do
    Repo.all(Owner)
  end

  @doc """
  Gets a single owner.

  Raises `Ecto.NoResultsError` if the Owner does not exist.

  ## Examples

      iex> get_owner!(123)
      %Owner{}

      iex> get_owner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_owner!(id), do: Repo.get!(Owner, id)
  def get_owner(id), do: Repo.get(Owner, id)

  @doc """
  Creates a owner.

  ## Examples

      iex> create_owner(%{field: value})
      {:ok, %Owner{}}

      iex> create_owner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_owner(attrs \\ %{}) do
    %Owner{}
    |> Owner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a owner.

  ## Examples

      iex> update_owner(owner, %{field: new_value})
      {:ok, %Owner{}}

      iex> update_owner(owner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_owner(%Owner{} = owner, attrs) do
    owner
    |> Owner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a owner.

  ## Examples

      iex> delete_owner(owner)
      {:ok, %Owner{}}

      iex> delete_owner(owner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_owner(%Owner{} = owner) do
    Repo.delete(owner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking owner changes.

  ## Examples

      iex> change_owner(owner)
      %Ecto.Changeset{data: %Owner{}}

  """
  def change_owner(%Owner{} = owner, attrs \\ %{}) do
    Owner.changeset(owner, attrs)
  end
end
