defmodule Calculator.OperationsTest do
  use Calculator.DataCase

  alias Calculator.Operations

  describe "operation" do
    alias Calculator.Operations.Operation

    @valid_attrs %{number_one: "120.5", number_two: "120.5", type: true}
    @update_attrs %{number_one: "456.7", number_two: "456.7", type: false}
    @invalid_attrs %{number_one: nil, number_two: nil, type: nil}

    def operation_fixture(attrs \\ %{}) do
      {:ok, operation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Operations.create_operation()

      operation
    end

    test "list_operation/0 returns all operation" do
      operation = operation_fixture()
      assert Operations.list_operation() == [operation]
    end

    test "get_operation!/1 returns the operation with given id" do
      operation = operation_fixture()
      assert Operations.get_operation!(operation.id) == operation
    end

    test "create_operation/1 with valid data creates a operation" do
      assert {:ok, %Operation{} = operation} = Operations.create_operation(@valid_attrs)
      assert operation.number_one == Decimal.new("120.5")
      assert operation.number_two == Decimal.new("120.5")
      assert operation.type == true
    end

    test "create_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Operations.create_operation(@invalid_attrs)
    end

    test "update_operation/2 with valid data updates the operation" do
      operation = operation_fixture()

      assert {:ok, %Operation{} = operation} =
               Operations.update_operation(operation, @update_attrs)

      assert operation.number_one == Decimal.new("456.7")
      assert operation.number_two == Decimal.new("456.7")
      assert operation.type == false
    end

    test "update_operation/2 with invalid data returns error changeset" do
      operation = operation_fixture()
      assert {:error, %Ecto.Changeset{}} = Operations.update_operation(operation, @invalid_attrs)
      assert operation == Operations.get_operation!(operation.id)
    end

    test "delete_operation/1 deletes the operation" do
      operation = operation_fixture()
      assert {:ok, %Operation{}} = Operations.delete_operation(operation)
      assert_raise Ecto.NoResultsError, fn -> Operations.get_operation!(operation.id) end
    end

    test "change_operation/1 returns a operation changeset" do
      operation = operation_fixture()
      assert %Ecto.Changeset{} = Operations.change_operation(operation)
    end
  end
end
