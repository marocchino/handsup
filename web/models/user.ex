defmodule Handsup.User do
  use Handsup.Web, :model

  alias Handsup.Repo
  alias Handsup.User

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

  @doc """
  Find or Create user with passed oauth information.
  """
  def find_or_create(auth) do
    %{uid: uid, provider: provider} = auth
    provider_str = to_string(provider)

    query = from user in User,
      where: user.uid == ^uid and user.provider == ^provider_str
    user = Repo.one(query)

    if user do
      {:ok, user}
    else
      user_attrs = %{uid: uid, provider: provider_str}
      changeset = User.changeset(%User{}, user_attrs)
      Repo.insert(changeset)
    end
  end
end
