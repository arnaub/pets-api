defmodule PetsApi.Pets.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  alias PetsApi.Owners.Owner

  schema "pets" do
    field :name, :string

    belongs_to :owner, Owner

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :owner_id])
    |> validate_required([:name, :owner_id])
  end
end
