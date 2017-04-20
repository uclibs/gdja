App.status = App.cable.subscriptions.create("StatusChannel", {
  connected: function() {
    alert("connected")
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    alert("received data: " + data)
  }
});
