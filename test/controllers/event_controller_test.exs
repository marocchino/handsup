defmodule Handsup.EventControllerTest do
  use Handsup.ConnCase

  alias Handsup.Event
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} = config do
    if name = config[:login_as] do
      user = insert_user(nickname: name)
      conn = assign(build_conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, event_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing events"
  end

  @tag login_as: Ffaker.En.Name.name
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, event_path(conn, :new)
    assert html_response(conn, 200) =~ "New event"
  end

  @tag login_as: Ffaker.En.Name.name
  test "creates resource and redirects when data is valid",
       %{conn: conn, user: user} do
    group = insert_group(user)
    valid_attrs = Map.merge(@valid_attrs, %{group_id: group.id})
    conn = post conn, event_path(conn, :create), event: valid_attrs
    assert redirected_to(conn) == event_path(conn, :index)
    assert Repo.get_by(Event, @valid_attrs)
  end

  @tag login_as: Ffaker.En.Name.name
  test "does not create resource and renders errors when not group owner",
       %{conn: conn} do
    user = insert_user
    group = insert_group(user)
    valid_attrs = Map.merge(@valid_attrs, %{group_id: group.id})
    conn = post conn, event_path(conn, :create), event: valid_attrs
    assert html_response(conn, 200) =~ "New event"
  end

  @tag login_as: Ffaker.En.Name.name
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, event_path(conn, :create), event: @invalid_attrs
    assert html_response(conn, 200) =~ "New event"
  end

  @tag login_as: Ffaker.En.Name.name
  test "shows chosen resource", %{conn: conn, user: user} do
    group = insert_group(user)
    event = insert_event(user, group)
    conn = get conn, event_path(conn, :show, event)
    assert html_response(conn, 200) =~ "Show event"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, event_path(conn, :show, -1)
    end
  end

  @tag login_as: Ffaker.En.Name.name
  test "renders form for editing chosen resource", %{conn: conn, user: user} do
    group = insert_group(user)
    event = insert_event(user, group)
    conn = get conn, event_path(conn, :edit, event)
    assert html_response(conn, 200) =~ "Edit event"
  end

  @tag login_as: Ffaker.En.Name.name
  test "updates chosen resource and redirects when data is valid",
       %{conn: conn, user: user} do
    group = insert_group(user)
    event = insert_event(user, group)
    valid_attrs = Map.merge(@valid_attrs, %{group_id: group.id})
    conn = put conn, event_path(conn, :update, event), event: valid_attrs
    assert redirected_to(conn) == event_path(conn, :show, event)
    assert Repo.get_by(Event, valid_attrs)
  end

  @tag login_as: Ffaker.En.Name.name
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, user: user} do
    group = insert_group(user)
    event = insert_event(user, group)
    conn = put conn, event_path(conn, :update, event), event: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit event"
  end

  @tag login_as: Ffaker.En.Name.name
  test "deletes chosen resource", %{conn: conn, user: user} do
    group = insert_group(user)
    event = insert_event(user, group)
    conn = delete conn, event_path(conn, :delete, event)
    assert redirected_to(conn) == event_path(conn, :index)
    refute Repo.get(Event, event.id)
  end
end
