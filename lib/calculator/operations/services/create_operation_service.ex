defmodule Calculator.Services.CreateOperationService do
  alias Calculator.Operations.Repositories.OperationRepository
  alias Calculator.Operations.Utils.Math

  def execute(operation) do
    %{"number_one" => number_one, "number_two" => number_two, "operation_type" => type} =
      operation

    case type == "divisao" && number_two == 0 do
      true ->
        OperationRepository.create_operation(%{
          number_one: number_one,
          number_two: number_two,
          type: type,
          status: "falha"
        })

        {:error, "Operação inválida. Divisão por zero não permitida"}

      _ ->
        OperationRepository.create_operation(%{
          number_one: number_one,
          number_two: number_two,
          result: Math.operation(number_one, number_two, type),
          type: type,
          status: "sucesso"
        })
    end
  end
end
