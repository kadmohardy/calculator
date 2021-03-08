defmodule Calculator.Shared.Cache.Ets.Implementations.OperationsCache do
  @moduledoc false
  @db :operations

  def get(key), do: GenServer.call(@db, {:get, key})
  def save(key, value), do: GenServer.cast(@db, {:put, key, value})
  def delete(key), do: GenServer.cast(@db, {:delete, key})
end
