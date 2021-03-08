defmodule Calculator.Operations.Repositories.OperationRepository do
  @moduledoc """
  The Operations context.
  """

  import Ecto.Query, warn: false
  alias Calculator.Repo

  alias Calculator.Operations.Entities.Operation

  @doc """
  Returns the list of operation.

  ## Examples

      iex> list_operation()
      [%Operation{}, ...]

  """
  def list_operation do
    Repo.all(Operation)
  end

  @doc """
  Gets a single operation.

  Raises `Ecto.NoResultsError` if the Operation does not exist.

  ## Examples

      iex> get_operation!(123)
      %Operation{}

      iex> get_operation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operation!(id), do: Repo.get!(Operation, id)

  @doc """
  Creates a operation.

  ## Examples

      iex> create_operation(%{field: value})
      {:ok, %Operation{}}

      iex> create_operation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_operation(attrs \\ %{}) do
    %Operation{}
    |> Operation.changeset(attrs)
    |> Repo.insert()
  end
end
