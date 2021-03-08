defmodule Calculator.Operations.Services.ListOperationsService do
  @moduledoc false

  alias Calculator.Operations.Repositories.OperationRepository
  alias Calculator.Shared.Cache.Ets.Implementations.OperationsCache

  @key "operations-list"
  def execute do
    OperationsCache.get(@key)
    |> case do
      {:ok, operations} ->
        IO.puts("CACHA CHACAH CAHS CHAS HC SHC HA H H AHC HC")
        operations

      {:not_found, []} ->
        IO.puts("CACHA CHACAH CAHS CHAS HC SHC HA H H AHC HC222222222222")

        operations = OperationRepository.list_operation()
        OperationsCache.save(@key, operations)
        operations
    end
  end
end
