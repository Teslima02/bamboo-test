defmodule Bamboo.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :name, :string
      add :symbol, :string
      add :currency, :string
      add :country, :string
      add :address, :string
      add :category_id, references(:categories, on_delete: :delete_all)

      timestamps()
    end

    create index(:stocks, [:category_id])
  end
end
