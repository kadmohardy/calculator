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
    |> validate_required([:number_one, :number_two, :operation_type],
      message: "O parâmetro é obrigatório"
    )
    |> validate_inclusion(:operation_type, ["soma", "subtracao", "multiplicacao", "divisao"],
      message:
        "Por favor, escolha uma das seguintes operaçoes: soma, subtracao, multiplica, divisao"
    )
  end
end
