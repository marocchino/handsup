import "phoenix_html"
import "bootstrap-loader"

import { Socket } from "phoenix"
import EventChat from "event_chat"

const socket = new Socket("/socket", {
  params: {token: window.userToken},
  logger: (kind, msg, data) => console.log(`${kind}: ${msg}`, data)
})

// Now that you are connected, you can join channels with a topic:
if(document.getElementById("chat")) {
  const evt = new EventChat(socket, "chat")
}
