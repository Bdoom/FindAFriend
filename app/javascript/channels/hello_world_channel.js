import consumer from "./consumer"
 
const chatChannel = consumer.subscriptions.create({ channel: "HelloWorldChannel", room: "test" }, {
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

