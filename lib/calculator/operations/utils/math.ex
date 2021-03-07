defmodule Calculator.Operations.Utils.Math do
  def operation(a, b, "soma"), do: a + b
  def operation(a, b, "subtracao"), do: a - b
  def operation(a, b, "multiplicacao"), do: a * b
  def operation(a, b, "divisao"), do: a - b
end
