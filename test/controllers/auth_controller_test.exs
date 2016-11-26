defmodule Handsup.AuthControllerTest do
  alias Handsup.AuthController
  use Handsup.ConnCase

  test "successfully granted user and login" do
    user = insert_user()
    auth = %{uid: user.uid, provider: String.to_atom(user.provider)}

    conn =
      build_conn()
      |> assign(:ueberauth_auth, auth)
      |> get_callback

    assert html_response(conn, 302)
    assert get_flash(conn, :info) 
  end

  test "successfully granted user but fail to login" do
    conn = build_conn()
    conn = get(conn, auth_path(conn, :callback, :google))

    assert html_response(conn, 302)
    assert get_flash(conn, :error) 
  end

  test "fail to grant user" do
    conn =
      build_conn()
      |> assign(:ueberauth_auth, %{uid: "undefined", provider: :gooogle})
      |> get_callback

    assert html_response(conn, 302)
    assert get_flash(conn, :error) 
  end

  defp get_callback(conn) do
    conn
    |> put_private(:phoenix_flash, %{})
    |> put_private(:plug_session, %{})
    |> AuthController.callback(%{})
  end
end

