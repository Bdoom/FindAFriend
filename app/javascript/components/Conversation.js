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
  var user_id = this.props.user_id
  var user_profile_path = this.props.user_profile_path

  this.chatConnection = consumer.subscriptions.create({ channel: "ConversationChannel", conversation_id: conversation_id, user_id: user_id}, {

    // can call any ruby channel method using: this.perform(method_name, {params})
    received(data)
    {
            var message_body = data.message_body;
            var first_name = data.first_name;
            var user_id = data.user_id;

            var node = document.createElement("div");
            node.setAttribute('class', 'bg-light');

            var user_name_link = document.createElement("a");
            user_name_link.textContent = first_name + ': ';
            user_name_link.setAttribute('class', 'text-primary');
            user_name_link.setAttribute('href', user_profile_path + user_id);
            node.appendChild(user_name_link);

            var span_message_body = document.createElement("span");
            span_message_body.textContent = message_body;
            span_message_body.setAttribute('class', 'text-secondary');
            node.appendChild(span_message_body);

            var br = document.createElement('BR')
            node.appendChild(br);

            var element = document.getElementById("message_box");

            var scrollElement = document.getElementById("scroll_element");
            scrollElement.scrollTop = element.scrollHeight;
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
      conversation_id: "",
      users: []
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

    axios.get('/conversations/get_users_in_conversation', {
      params: {
        conversation_id: this.props.conversation_id
      }
    })
    .then((response) => {
      if (this._isMounted)
      {
        this.setState({ users: response.data.users });
      }
    })

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
          var first_name = this.props.first_name;
          var user_id = this.props.user_id;
          this.chatConnection.send({user_id: user_id, first_name: first_name, message_body: message_body, conversation_id: conversation_id})
          var body = document.getElementById('message_body');
          body.value = "";
        }
      }
    });
    
  }

  render () {
    if (this.state.messages != null) 
    {
      var messages = this.state.messages.map((message, index) => {
        return (
          <div key={index} className="bg-light">
          <a className="text-primary" href={this.props.user_profile_path + message.user_id}>{message.first_name}: </a>
          <span className="text-secondary"> { message.message_body }</span>
          <br />
          </div>
        );
      });
    }

  if (this.state.users != null)
  {
    var users = this.state.users.map((user, index) => {
      return (
        <li key={index} className="list-group-item">{user.first_name}</li>
      );
    });

  }
    return (
      <React.Fragment>

<div className="row">
    <div className=".col-12 .col-md-8">
    Users
    <div className="card scrolling scrollbar-black">
        <ul className="list-group">
          { users }
        </ul>
      </div>
    </div>

    <div className="col">
      <div className="card scrolling scrollbar-black" id="scroll_element">
        <div className="card-body" id="message_box">
          { messages }
        </div>
      </div>    
    </div>
</div>


  <div className="scrollbox border">
    <textarea name="message_body" id="message_body" className="width-100-percent" onKeyDown={this.handle_key_down}></textarea>
  </div>


      </React.Fragment>
    );
  }
}

export default Conversation
