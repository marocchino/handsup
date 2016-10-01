defmodule Handsup.GroupController do
  use Handsup.Web, :controller

  alias Handsup.Group
  import Handsup.Session, only: [authenticate_user: 2]

  plug :authenticate_user when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    groups = Repo.all(Group)
    render conn, "index.html", groups: groups
  end

  def new(conn, _params) do
    changeset = Group.changeset(%Group{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"group" => group_params}) do
    changeset =
      conn.assigns.current_user
      |> build_assoc(:own_groups)
      |> Group.changeset(group_params)

    case Repo.insert(changeset) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: group_path(conn, :index))
        |> halt
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    group =
      conn.assigns.current_user
      |> user_own_groups
      |> Repo.get!(id)
    changeset = Group.changeset(group)
    render conn, "edit.html", changeset: changeset, group: group
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    user = conn.assigns.current_user
    group = Repo.get!(user_own_groups(user), id)
    changeset = Group.changeset(group, group_params)

    case Repo.update(changeset) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Group updated successfully.")
        |> redirect(to: group_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset)
    end
  end

  defp user_own_groups(user) do
    assoc(user, :own_groups)
  end
end
