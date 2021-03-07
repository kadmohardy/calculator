defmodule CalculatorWeb.Api.Params.OperationParams do
  use Params.Schema, %{
    number_one: :decimal,
    number_two: :decimal,
    operation_type: :string
  }

  # only: [cast: 3, validate_inclusion: 3]
  import Ecto.Changeset

  def child(ch, params) do
    ch
    |> cast(params, [:number_one, :number_two, :operation_type])
    |> validate_required([:number_one, :number_two, :operation_type])
    |> validate_inclusion(:operation_type, ["som", "subtracao", "multiplicacao", "divisao"])
  end
end
