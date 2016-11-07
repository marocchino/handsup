defmodule Handsup.EventChannel do
  @moduledoc """
  EventChannel
  """
  use Handsup.Web, :channel

  def join("event:" <> event_id, _params, socket) do
    {:ok, assign(socket, :event_id, String.to_integer(event_id))}
  end

  def handle_in("new_chat", params, socket) do
    broadcast! socket, "new_chat", %{
      user: socket.assigns.user_id,
      message: params["message"]
    }
    {:reply, :ok, socket}
  end
end
