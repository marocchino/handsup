defmodule Handsup.PageController do
  use Handsup.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
