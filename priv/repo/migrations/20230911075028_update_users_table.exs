defmodule Pento.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, null: false, size: 15
    end

    create unique_index(:users, [:username])
  end
end
