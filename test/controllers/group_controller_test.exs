defmodule Handsup.GroupControllerTest do
  use Handsup.ConnCase

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
    group = insert_group(name_eng: "group", name: "group1")

    conn = get conn, group_path(conn, :index)

    assert html_response(conn, 200) =~ ~r/Listing groups/
    assert String.contains?(conn.resp_body, group.name),
           "#{group.name} is not contained"
  end

  @tag login_as: "org"
  test "shows new form", %{conn: conn} do
    conn = get conn, group_path(conn, :new)
    assert html_response(conn, 200)
  end

  @valid_attr %{name_eng: "group_name", name: "Group Name"}

  @tag login_as: "org"
  test "creates new group and redirects", %{conn: conn, user: user} do
    conn = post(conn, group_path(conn, :create), group: @valid_attr)
    assert redirected_to(conn) == group_path(conn, :index)
    assert Repo.get_by!(Handsup.Group, @valid_attr).organizer_id == user.id
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
end
