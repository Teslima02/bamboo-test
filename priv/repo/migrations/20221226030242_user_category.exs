defmodule Bamboo.Repo.Migrations.UserCategory do
  use Ecto.Migration

  def change do
    create table(:user_category, primary_key: false) do
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
      add(:category_id, references(:categories, on_delete: :delete_all), primary_key: true)

      timestamps()
    end

    create index(:user_category, [:user_id])
    create index(:user_category, [:category_id])

    create unique_index(:user_category, [:user_id, :category_id])
  end
end
