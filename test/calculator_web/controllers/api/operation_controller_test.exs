defmodule CalculatorWeb.Api.OperationControllerTest do
  use CalculatorWeb.ConnCase

  alias Calculator.Operations
  alias Calculator.Operations.Operation

  @create_attrs %{
    number_one: "120.5",
    number_two: "120.5",
    type: true
  }
  @update_attrs %{
    number_one: "456.7",
    number_two: "456.7",
    type: false
  }
  @invalid_attrs %{number_one: nil, number_two: nil, type: nil}

  def fixture(:operation) do
    {:ok, operation} = Operations.create_operation(@create_attrs)
    operation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all operation", %{conn: conn} do
      conn = get(conn, Routes.api_operation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create operation" do
    test "renders operation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_operation_path(conn, :create), operation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_operation_path(conn, :show, id))

      assert %{
               "id" => id,
               "number_one" => "120.5",
               "number_two" => "120.5",
               "type" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_operation_path(conn, :create), operation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update operation" do
    setup [:create_operation]

    test "renders operation when data is valid", %{
      conn: conn,
      operation: %Operation{id: id} = operation
    } do
      conn =
        put(conn, Routes.api_operation_path(conn, :update, operation), operation: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_operation_path(conn, :show, id))

      assert %{
               "id" => id,
               "number_one" => "456.7",
               "number_two" => "456.7",
               "type" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, operation: operation} do
      conn =
        put(conn, Routes.api_operation_path(conn, :update, operation), operation: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete operation" do
    setup [:create_operation]

    test "deletes chosen operation", %{conn: conn, operation: operation} do
      conn = delete(conn, Routes.api_operation_path(conn, :delete, operation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_operation_path(conn, :show, operation))
      end
    end
  end

  defp create_operation(_) do
    operation = fixture(:operation)
    %{operation: operation}
  end
end
