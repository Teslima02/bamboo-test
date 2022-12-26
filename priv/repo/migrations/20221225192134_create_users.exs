defmodule Bamboo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :category_id, references(:categories, on_delete: :delete_all)

      timestamps()
    end

    create index(:users, [:category_id])
  end
end
