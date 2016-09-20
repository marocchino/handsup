defmodule Handsup.User do
  @moduledoc """
    OAuth user
  """

  use Handsup.Web, :model

  schema "users" do
    field :uid, :string
    field :provider, :string
    field :nickname, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:uid, :provider, :nickname])
    |> validate_required([:uid, :provider])
    |> unique_constraint(:uid)
  end
end
