const ActionCable = require('actioncable-modules');
const dotenv = require('dotenv')
dotenv.config()

const actionCable = ActionCable.createConsumer("/cable")

actionCable.subscriptions.create("NotificationsChannel", {
  received: function(data) {
    console.log(data)
  }
})