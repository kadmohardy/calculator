defmodule CalculatorWeb.Api.OperationController do
  use CalculatorWeb, :controller

  alias Calculator.Operations.Services.CreateOperationService
  alias Calculator.Operations.Services.ListOperationsService
  alias CalculatorWeb.Api.Params.OperationParams
  action_fallback CalculatorWeb.FallbackController

  def index(conn, _params) do
    operation = ListOperationsService.execute()
    render(conn, "index.json", operation: operation)
  end

  def create(conn, %{"operation" => operation_params}) do
    changeset = OperationParams.from(operation_params, with: &OperationParams.child/2)

    if changeset.valid? do
      with {:ok, operation} <-
             CreateOperationService.execute(operation_params) do
        conn
        |> put_status(:created)
        |> render("show.json", operation: operation)
      end
    else
      conn
      |> put_status(:unprocessable_entity)
      |> put_view(CalculatorWeb.ChangesetView)
      |> render("error.json", changeset: changeset)
    end
  end
end
