defmodule Handsup.EventController do
  use Handsup.Web, :controller

  alias Handsup.Event
  alias Handsup.Group
  import Handsup.Session, only: [authenticate_user: 2]

  plug :authenticate_user when action in [:new, :create, :edit, :update,
                                          :delete]

  def index(conn, _params) do
    events = Repo.all(Event)
    render(conn, "index.html", events: events)
  end

  def new(conn, %{"group_name_eng" => group_name_eng}) do
    changeset = Event.changeset(%Event{}, conn.assigns.current_user)
    render(conn, "new.html",
           changeset: changeset, group_name_eng: group_name_eng)
  end

  def create(conn, %{"group_name_eng" => group_name_eng,
                     "event" => event_params}) do
    current_user = conn.assigns.current_user
    group = Repo.get_by!(Group, name_eng: group_name_eng)
    changeset =
      Event.changeset(%Event{group_id: group.id}, current_user, event_params)

    case Repo.insert(changeset) do
      {:ok, _event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: event_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html",
               changeset: changeset, group_name_eng: group_name_eng)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)
    render(conn, "show.html", event: event)
  end

  def edit(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)
    changeset = Event.changeset(event, conn.assigns.current_user)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Repo.get!(Event, id)
    changeset = Event.changeset(event, conn.assigns.current_user, event_params)

    case Repo.update(changeset) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: event_path(conn, :show, event))
      {:error, changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: event_path(conn, :index))
  end
end
