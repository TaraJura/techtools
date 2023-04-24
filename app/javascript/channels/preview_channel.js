import consumer from "./consumer"

consumer.subscriptions.create("PreviewChannel", {
  connected() {
    console.log("Preview will be send to the iframe once you import the file.")
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
      iframe = document.getElementById('invoice-preview')
      iframe.style.display = 'block'
      iframe.src = 'isdoc/' + data.path
    }
  }
});
