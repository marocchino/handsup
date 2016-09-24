defmodule Handsup.PageController do
  use Handsup.Web, :controller

  def index(conn, _params) do
    user = get_session(conn, :current_user)
    render conn, "index.html", user: user
  end
end
