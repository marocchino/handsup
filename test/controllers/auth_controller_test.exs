defmodule Handsup.AuthControllerTest do
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

  @tag :pending
  test "successfully granted user and login", %{conn: conn} do
  end

  @tag :pending
  test "successfully granted user but fail to login", %{conn: conn} do
  end

  @tag login_as: "user", pending: true
  test "fail to grant user", %{conn: conn, user: user} do
  end
end

