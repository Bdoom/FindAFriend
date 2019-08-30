import React from "react"
import axios from "axios"
import PropTypes from "prop-types"
import "../stylesheets/findafriend.scss"
import consumer from "../channels/consumer"

class Conversation extends React.Component {
  _isMounted = false;
  chatConnection = null;

setup_chat_connection()
{
  var conversation_id = this.props.conversation_id

  this.chatConnection = consumer.subscriptions.create({ channel: "ConversationChannel", conversation_id: conversation_id }, {

    // can call any ruby channel method using: this.perform(method_name, {params})
    received(data)
    {
        var message_body = data.message_body;
        var first_name = data.first_name;

        var node = document.createElement("div");
        node.setAttribute('class', 'bg-light');

        var span_user_name = document.createElement("span");
        span_user_name.textContent = first_name + ':';
        span_user_name.setAttribute('class', 'text-primary');
        node.appendChild(span_user_name);

        var span_message_body = document.createElement("span");
        span_message_body.textContent = message_body;
        span_message_body.setAttribute('class', 'text-secondary');
        node.appendChild(span_message_body);

        var br = document.createElement('BR')
        node.appendChild(br);

        var element = document.getElementById("message_box");
        element.appendChild(node);
    }
  })
}

  constructor(props)
  {
    super(props)

    this.loadData = this.loadData.bind(this);
    this.send_message = this.send_message.bind(this);
    this.setup_chat_connection = this.setup_chat_connection.bind(this);
    this.handle_key_down = this.handle_key_down.bind(this);

    this.chatConnection = null;

    this.state = {
      messages: [],
      conversation_id: ""
    };
  }

  componentWillUnmount() {
    this._isMounted = false;
  }
  

  componentDidMount() {
    this._isMounted = true;
    this.loadData();
    this.setup_chat_connection();
  }
  
  loadData()
  {
  axios({
      method: 'GET', 
      url: '/conversations/get_recent_messages',
      params: { conversation_id: this.props.conversation_id },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      if (this._isMounted) {
        this.setState({
          messages: response.data.messages    
        });
      }
    });
  }

  handle_key_down(e)
  {
    if (e.key === 'Enter') {
      this.send_message();
    }
  }

  send_message()
  {
    //conversations/create_new_message
    var message_body = document.getElementById('message_body').value;
    var conversation_id = this.props.conversation_id;

    var first_name = this.props.first_name;

    axios({
      method: 'POST', 
      url: '/conversations/create_new_message',
      data: { conversation_id: conversation_id, message_body: message_body, first_name: first_name },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      if (this._isMounted) {
        if (response.data.status == "ok")
        {
          var first_name =  this.props.first_name;
          this.chatConnection.send({first_name: first_name, message_body: message_body, conversation_id: conversation_id})
          var body = document.getElementById('message_body');
          body.value = "";
        }
      }
    });
    
  }

  render () {
    var messages = this.state.messages.map((message, index) => {
      return (
        <div key={index} className="bg-light">
        <span className="text-primary">{message.first_name}:</span>
        <span className="text-secondary"> { message.message_body }</span>
        <br />
        </div>
      );
    });

    return (
      <React.Fragment>

<div className="text-center">
    <h1>Conversation</h1>
</div>

<div className="scrollbox border" id="message_box">
 { messages }
</div>

<div className="scrollbox border">
  <textarea name="message_body" id="message_body" className="width-100-percent" onKeyDown={this.handle_key_down}></textarea>
</div>

      </React.Fragment>
    );
  }
}

export default Conversation
