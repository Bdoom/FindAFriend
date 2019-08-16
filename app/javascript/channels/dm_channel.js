import consumer from "./consumer"
 
window.chatChannel = consumer.subscriptions.create({ channel: "DmChannel", room: "test" }, {
    received(data) {
      console.log(data);

    },

    connected()
    {
    }
})


window.sendData = function sendData(data)
{
    // example data: { sent_by: "Paul", body: "This is a cool chat app." }
    chatChannel.send(data);
}

