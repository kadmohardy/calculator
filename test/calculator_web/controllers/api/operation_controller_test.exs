defmodule CalculatorWeb.Api.OperationControllerTest do
  use CalculatorWeb.ConnCase

  alias Calculator.Operations.Entities.Operation
  alias Calculator.Operations.Repositories.OperationRepository

  @create_soma_attrs %{
    number_one: 120.5,
    number_two: 120.5,
    operation_type: "soma"
  }

  @create_subtracao_attrs %{
    number_one: 120.5,
    number_two: 11.5,
    operation_type: "subtracao"
  }

  @create_multiplicacao_attrs %{
    number_one: 12,
    number_two: 11.5,
    operation_type: "multiplicacao"
  }

  @create_divisao_attrs %{
    number_one: 12,
    number_two: 1.4,
    operation_type: "divisao"
  }

  @create_attrs_2 %{number_one: 120.5, number_two: 0, operation_type: "divisao"}

  @invalid_attrs %{number_one: "nil", number_two: "nil", operation_type: "nil"}

  def fixture(:operation) do
    {:ok, operation} = OperationRepository.create_operation(@create_attrs)
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
    test "renders operation soma when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_operation_path(conn, :create), operation: @create_soma_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders operation subtracao when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.api_operation_path(conn, :create), operation: @create_subtracao_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders operation mutiplicacao when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.api_operation_path(conn, :create),
          operation: @create_multiplicacao_attrs
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders operation division when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.api_operation_path(conn, :create), operation: @create_divisao_attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when division by zero", %{conn: conn} do
      conn = post(conn, Routes.api_operation_path(conn, :create), operation: @create_attrs_2)
      assert json_response(conn, 400)["error"] != %{}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_operation_path(conn, :create), operation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_operation(_) do
    operation = fixture(:operation)
    %{operation: operation}
  end
end
