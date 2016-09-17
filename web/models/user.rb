defmodule Handsup.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :uid, :string
    field :provider, :string
    field :nickname, :string
    timestamps
  end

  @required_fields ~w(uid provider nickname)
  @optional_fields ~w()

  def changeset(user, params \\ :empty) do
    user
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:uid)
  end
end
