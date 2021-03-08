defmodule Calculator.Operations.Services.ListOperationsService do
  @moduledoc false

  alias Calculator.Operations.Repositories.OperationRepository
  alias Calculator.Shared.Cache.Ets.Implementations.OperationsCache

  @key "operations-list"
  def execute do
    OperationsCache.get(@key)
    |> case do
      {:ok, operations} ->
        operations

      {:not_found, []} ->
        operations = OperationRepository.list_operation()
        OperationsCache.save(@key, operations)
        operations
    end
  end
end
