import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { message: String, type: String, title: String }

  connect() {
    if (this.messageValue) {
      Swal.fire({
        icon: this.typeValue,
        title: this.titleValue,
        text: this.messageValue,
        showConfirmButton: this.typeValue === 'error' ? true : false,
        timer: this.typeValue === 'error' ? null : 1500
      });
    }
  }
}
