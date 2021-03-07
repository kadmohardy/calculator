defmodule Calculator.Repo.Migrations.CreateOperation do
  use Ecto.Migration

  def change do
    create table(:operations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :number_one, :decimal
      add :number_two, :decimal
      add :result, :decimal
      add :type, :string
      add :status, :string

      timestamps()
    end
  end
end
