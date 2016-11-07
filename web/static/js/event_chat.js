class EventChat {
  constructor(socket, element) {
    socket.connect()
    this.socket = socket
    const el = document.getElementById(element)
    const msgInput = document.getElementById("message")
    const submitButton = document.getElementById("submit")

    const channel = socket.channel("event:1", {})

    submitButton.addEventListener("click", e => {
      if (msgInput.value === "") { return }
      const payload = { message: msgInput.value }
      channel.push("new_chat", payload)
             .receive("error", console.log)
      msgInput.value = ""
    })

    channel.on("new_chat", res => {
      this.renderChat(el, res)
    })

    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
  }

  renderChat(el, {user, message}) {
    const template = document.createElement("p")
    template.innerHTML = `<b>${user}</b>: ${message}`

    el.appendChild(template)
    el.scrollTop = el.scrollHeight
  }
}
export default EventChat
