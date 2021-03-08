defmodule CalculatorWeb.Api.OperationView do
  use CalculatorWeb, :view
  alias CalculatorWeb.Api.OperationView

  def render("index.json", %{operation: operation}) do
    %{data: render_many(operation, OperationView, "operation.json")}
  end

  def render("show.json", %{operation: operation}) do
    %{data: render_one(operation, OperationView, "operation.json")}
  end

  def render("operation.json", %{operation: operation}) do
    %{
      id: operation.id,
      number_one: operation.number_one,
      number_two: operation.number_two,
      result: operation.result,
      type: operation.type,
      status: operation.status
    }
  end
end
