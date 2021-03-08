defmodule Calculator.Operations.Entities.Operation do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "operations" do
    field :number_one, :decimal
    field :number_two, :decimal
    field :result, :decimal
    field :type, :string
    field :status, :string, default: false

    timestamps()
  end

  @doc false
  def changeset(operation, attrs) do
    operation
    |> cast(attrs, [:number_one, :number_two, :type, :status, :result])
    |> validate_required([:number_one, :number_two, :type, :status])
    |> validate_required([:number_one, :number_two, :type], message: "O parâmetro é obrigatório")
    |> validate_inclusion(:type, ["soma", "subtracao", "multiplicacao", "divisao"],
      message:
        "Por favor, escolha uma das seguintes operaçoes: soma, subtracao, multiplica, divisao"
    )
    |> validate_inclusion(:status, ["sucesso", "falha"])
  end
end
