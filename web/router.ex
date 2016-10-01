defmodule Handsup.Router do
  use Handsup.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Handsup.Session, repo: Handsup.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Handsup do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/groups", GroupController
    resources "/events", EventController
  end

  scope "/auth", Handsup do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Handsup do
  #   pipe_through :api
  # end
end
