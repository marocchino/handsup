defmodule Handsup.UserSocket do
  use Phoenix.Socket
  alias Phoenix.Token
  @max_age 7 * 24 * 60 * 60

  ## Channels
  channel "event:*", Handsup.EventChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket, timeout: 45_000
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(params, socket) do
    with(
      %{"token" => token} <- params,
      {:ok, user_id} <- Phoenix.Token.verify(socket, "user socket", token,
                                             max_age: @max_age),
      result <- assign(socket, :user_id, user_id)
    ) do
      {:ok, result}
    else
      _ -> :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given
  # user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Handsup.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end
