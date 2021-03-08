defmodule Calculator.OperationRepositoryTest do
  use Calculator.DataCase

  alias Calculator.Operations.Repositories.OperationRepository

  describe "operation" do
    alias Calculator.Operations.Entities.Operation

    @valid_attrs %{number_one: 120.5, number_two: 120.5, type: "soma", status: "sucesso"}
    @invalid_attrs %{number_one: nil, number_two: nil, type: nil, status: nil}

    def operation_fixture(attrs \\ %{}) do
      {:ok, operation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OperationRepository.create_operation()

      operation
    end

    test "list_operation/0 returns all operation" do
      operation = operation_fixture()
      assert OperationRepository.list_operation() == [operation]
    end

    test "get_operation!/1 returns the operation with given id" do
      operation = operation_fixture()
      assert OperationRepository.get_operation!(operation.id) == operation
    end

    test "create_operation/1 with valid data creates a operation" do
      assert {:ok, %Operation{} = operation} = OperationRepository.create_operation(@valid_attrs)
      assert operation.number_one == Decimal.new("120.5")
      assert operation.number_two == Decimal.new("120.5")
      assert operation.type == "soma"
    end

    test "create_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OperationRepository.create_operation(@invalid_attrs)
    end
  end
end
