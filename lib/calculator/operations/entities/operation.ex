defmodule Calculator.Operations.Entities.Operation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "operation" do
    field :number_one, :decimal
    field :number_two, :decimal
    field :result, :decimal
    field :type, :boolean, default: false
    field :status, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(operation, attrs) do
    operation
    |> cast(attrs, [:number_one, :number_two, :type])
    |> validate_required([:number_one, :number_two, :type])
  end
end
