defmodule Calculator.Repo.Migrations.CreateOperation do
  use Ecto.Migration

  def change do
    create table(:operation, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :number_one, :decimal
      add :number_two, :decimal
      add :type, :boolean, default: false, null: false
      add :status, :boolean, default: false, null: false

      timestamps()
    end
  end
end
