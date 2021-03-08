defmodule Calculator.Operations.Services.CreateOperationService do
  @moduledoc false

  alias Calculator.Operations.Repositories.OperationRepository
  alias Calculator.Operations.Utils.Math
  alias Calculator.Shared.Cache.Ets.Implementations.OperationsCache

  @key "operations-list"
  def execute(operation) do
    %{"number_one" => number_one, "number_two" => number_two, "operation_type" => type} =
      operation

    current_operation = %{
      number_one: number_one,
      number_two: number_two,
      type: type,
      status: "falha",
      result: nil
    }

    case type == "divisao" && number_two == 0 do
      true ->
        current_operation = %{current_operation | status: "falha"}
        current_operation |> create_operation()

        {:error, "Operação inválida. Divisão por zero não permitida"}

      _ ->
        current_operation = %{
          current_operation
          | result: Math.operation(number_one, number_two, type),
            status: "sucesso"
        }

        current_operation |> create_operation()
    end
  end

  defp create_operation(operation) do
    with {:ok, operation} <- OperationRepository.create_operation(operation) do
      OperationsCache.save(@key, OperationRepository.list_operation())
      {:ok, operation}
    end
  end
end
