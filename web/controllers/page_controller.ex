defmodule Handsup.PageController do
  use Handsup.Web, :controller

  def index(conn, _params) do
    user = conn.assigns.current_user
    render conn, "index.html", user: user
  end
end
