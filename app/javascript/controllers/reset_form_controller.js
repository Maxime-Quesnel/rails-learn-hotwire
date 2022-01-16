import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
  reset() {
    const input = document.getElementById("chat-text")
    input.value = ""
  }
}
