defmodule Handsup.GroupControllerTest do
  use Handsup.ConnCase

  alias Handsup.Group
  @valid_attr %{name_eng: "group_name", name: "Group Name"}
  @invalid_attr %{name_eng: "", name: "Group Name"}

  setup %{conn: conn} = config do
    if name = config[:login_as] do
      user = insert_user(nickname: name)
      conn = assign(build_conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "lists all groups", %{conn: conn} do
    user = insert_user
    group = insert_group(user, name_eng: "group", name: "group1")

    conn = get conn, group_path(conn, :index)

    assert html_response(conn, 200) =~ ~r/Listing groups/
    assert String.contains?(conn.resp_body, group.name),
           "#{group.name} is not contained"
  end

  test "show group", %{conn: conn} do
    user = insert_user
    group = insert_group(user, name_eng: "group", name: "group1")

    conn = get conn, group_path(conn, :show, group.id)

    assert html_response(conn, 200) =~ ~r/Show group/
    assert String.contains?(conn.resp_body, group.name),
           "#{group.name} is not contained"
  end

  @tag login_as: "org"
  test "shows new form", %{conn: conn} do
    conn = get conn, group_path(conn, :new)
    assert html_response(conn, 200)
  end

  @tag login_as: "org"
  test "creates new group and redirects", %{conn: conn, user: user} do
    conn = post(conn, group_path(conn, :create), group: @valid_attr)
    assert redirected_to(conn) == group_path(conn, :index)
    assert Repo.get_by!(Group, @valid_attr).organizer_id == user.id
  end

  @tag login_as: "org"
  test "shows edit form", %{conn: conn, user: user} do
    group = insert_group(user, name_eng: "group", name: "group1")
    conn = get conn, group_path(conn, :edit, group.id)
    assert html_response(conn, 200)
  end

  @tag login_as: "org"
  test "updates group and redirects", %{conn: conn, user: user} do
    group = insert_group(user, name_eng: "group", name: "group1")
    conn = put(conn, group_path(conn, :update, group.id), group: @valid_attr)
    assert redirected_to(conn) == group_path(conn, :index)
  end

  @tag login_as: "org"
  test "fails to update group and renders", %{conn: conn, user: user} do
    group = insert_group(user, name_eng: "group", name: "group1")
    conn = put(conn, group_path(conn, :update, group.id), group: @invalid_attr)
    assert html_response(conn, 200)
  end

  @tag login_as: "org"
  test "destroys group and redirects", %{conn: conn, user: user} do
    group = insert_group(user, name_eng: "group", name: "group1")
    conn = delete(conn, group_path(conn, :delete, group.id))
    assert redirected_to(conn) == group_path(conn, :index)
    refute Repo.get(Group, group.id)
  end

  @tag login_as: "org"
  test "fails to destroy group and redirects", %{conn: conn, user: _user} do
    conn = delete(conn, group_path(conn, :delete, "42"))
    assert redirected_to(conn) == group_path(conn, :index)
  end

  test "requires user authentication on 'new' action", %{conn: conn} do
    conn = get(conn, group_path(conn, :new))
    assert redirected_to(conn) == page_path(conn, :index)
    assert conn.halted
  end
  
  test "requires user authentication on 'create' action", %{conn: conn} do
    conn = post(conn, group_path(conn, :create, %{}))
    assert redirected_to(conn) == page_path(conn, :index)
    assert conn.halted
  end

  test "requires user authentication on 'edit' action", %{conn: conn} do
    conn = get(conn, group_path(conn, :edit, "42"))
    assert redirected_to(conn) == page_path(conn, :index)
    assert conn.halted
  end

  test "requires user authentication on 'update' action", %{conn: conn} do
    conn = put(conn, group_path(conn, :update, "42"), %{})
    assert redirected_to(conn) == page_path(conn, :index)
    assert conn.halted
  end

  test "requires user authentication on 'delete' action", %{conn: conn} do
    conn = delete(conn, group_path(conn, :delete, "42"), %{})
    assert redirected_to(conn) == page_path(conn, :index)
    assert conn.halted
  end
end
