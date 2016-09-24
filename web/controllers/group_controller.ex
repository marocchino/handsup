defmodule Handsup.GroupController do
  use Handsup.Web, :controller

  alias Handsup.Group
  import Handsup.Session, only: [authenticate_user: 2]

  plug :authenticate_user when action in [:new, :create]

  def index(conn, _params) do
    groups = Repo.all(Group)

    render conn, "index.html", groups: groups
  end

  def new(conn, _params) do
    group = %Group{}
    render conn, "new.html", group: group
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
end
