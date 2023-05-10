import consumer from "./consumer"

consumer.subscriptions.create("PdfPreviewChannel", {
  connected() {
    console.log("Pdf Preview channel is ready")
  },

  received(data) {
    if (data.path == null) {
      console.log(data)
    }
    console.log(data)
    const cookies = document.cookie.split('; ');
    const myCookie = cookies.find(cookie => cookie.startsWith('current_user='));
    const myCookieValue = myCookie ? myCookie.split('=')[1] : null;

    if (myCookieValue == String(data.user)) {
      iframe2 = document.getElementById('invoice-preview2')
      iframe2.style.display = 'block'
      iframe2.src = data.path
      window.location.hash = '';
      window.location.hash = 'invoice-preview2';
    }
  }
});
