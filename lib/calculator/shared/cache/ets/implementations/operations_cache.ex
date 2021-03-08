defmodule Calculator.Shared.Cache.Ets.Implementations.OperationsCache do
  @moduledoc false

  def get(key), do: GenServer.call(CacheEts, {:get, key})
  def save(key, value), do: GenServer.cast(CacheEts, {:put, key, value})
end
