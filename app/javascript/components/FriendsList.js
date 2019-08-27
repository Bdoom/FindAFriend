import React from "react"
import PropTypes from "prop-types"
import axios from "axios"

class FriendsList extends React.Component {
  _isMounted = false;

  constructor(props)
  {
    super(props)

    this.loadData = this.loadData.bind(this);
    this.toggle_friends_list = this.toggle_friends_list.bind(this);
    this.remove_pending_friend = this.remove_pending_friend.bind(this);
    this.block_friend = this.block_friend.bind(this);
    this.unblock_friend = this.unblock_friend.bind(this);
    this.remove_friend = this.remove_friend.bind(this);
    this.accept_friend_request = this.accept_friend_request.bind(this);
    this.open_chat = this.open_chat.bind(this);

    this.state = {
      friends: [],
      pending_friends: [],
      blocked_friends: [],
      requested_friends: []
    };
  }

  componentWillUnmount() {
    this._isMounted = false;
  }
  

  componentDidMount() {
    this._isMounted = true;
    this.loadData();
    //setInterval(() => this.loadData(), 5000);
  }
  
  loadData()
  {
  axios({
      method: 'GET', 
      url: '/find_a_friend/get_entire_friends_list',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      if (this._isMounted) {
        this.setState({
          friends: response.data.friends,
          pending_friends: response.data.pending_friends,
          blocked_friends: response.data.blocked_friends,
          requested_friends: response.data.requested_friends    
        });
      }
    });
  }

  toggle_friends_list()
  {
    $('.collapse.friends_list_collapse').collapse('toggle')
    this.loadData();
  }

  remove_pending_friend(e)
  {
    var id = e.target.id;
    id = id.replace('remove_pending_friend_id_', '');

    axios({
      method: 'PATCH', 
      url: '/find_a_friend/remove_friend',
      data: { id: id },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      this.loadData();
    });
  }

  remove_friend(e)
  {
    var id = e.target.id;
    id = id.replace('remove_friend_id_', '');

    axios({
      method: 'PATCH', 
      url: '/find_a_friend/remove_friend',
      data: { id: id },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      this.loadData();
    });
  }

  block_friend(e)
  {
    var id = e.target.id;
    id = id.replace('block_friend_id_', '');

    axios({
      method: 'PATCH', 
      url: '/find_a_friend/block_friend',
      data: { id: id },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      this.loadData();
    });
  }

  unblock_friend(e)
  {
    var id = e.target.id;
    id = id.replace('unblock_friend_id_', '');

    axios({
      method: 'PATCH', 
      url: '/find_a_friend/unblock_friend',
      data: { id: id },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      this.loadData();
    });
  }

  accept_friend_request(e)
  {
    var id = e.target.id;
    id = id.replace('requested_friend_id_', '');

    axios({
      method: 'PATCH', 
      url: '/find_a_friend/accept_friend_request',
      data: { id: id },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      this.loadData();
    });
  }

  open_chat(e)
  {
    var recipient_id = e.target.id;
    recipient_id = recipient_id.replace('current_friend_', '');

    // chat room code, still need to be developed. 
    //chatChannel.send({test: 'test'});

    window.location = "/conversations/open_conversation?recipient=" + recipient_id;
  }

  render () {

    $('.right-click-menu').on('contextmenu', function(e) {
      var top = e.pageY - 10;
      var left = e.pageX - 90;
      $("#context-menu").css({
        display: "block",
        top: top,
        left: left
      }).addClass("show");
      return false; //blocks default Webbrowser right click menu
    }).on("click", function() {
      $("#context-menu").removeClass("show").hide();
    });
    
    $("#context-menu a").on("click", function() {
      $(this).parent().removeClass("show").hide();
    });
    

    var friends_list = this.state.friends.map((friend, index) => {
      return (

        <div key={index} className="right-click-menu">
          <div className="dropdown-menu dropdown-menu-sm" id="context-menu">
            <button className="dropdown-item" onClick={this.remove_friend} id={"remove_friend_id_" + friend.id}>Remove Friend</button>
            <button className="dropdown-item" onClick={this.block_friend} id={"block_friend_id_" + friend.id}>Block Friend</button>
          </div>

          <button className="list-group-item list-group-item-action" onClick={this.open_chat} id={"current_friend_" + friend.id}>{friend.first_name}</button>
        </div>

      );
    }); 

    var pending_friends = this.state.pending_friends.map((friend, index) => {
      return (
        <button key={index} className="list-group-item list-group-item-action" onClick={this.remove_pending_friend} id={"remove_pending_friend_id_" + friend.id} >{friend.first_name}</button>
      );
    });

    var blocked_friends = this.state.blocked_friends.map((friend, index) => {
      return (
        <button key={index} className="list-group-item list-group-item-action" id={"unblock_friend_id_" + friend.id} onClick={this.unblock_friend}>{friend.first_name}</button>
      );
    });

    var incoming_requests = this.state.requested_friends.map((friend, index) => {
      return (
        <button key={index} className="list-group-item list-group-item-action" id={"requested_friend_id_" + friend.id} onClick={this.accept_friend_request}>{friend.first_name}</button>
      );
    });

    if (friends_list.length <= 0) 
    {
      friends_list = "No friends currently.";
    }

    if (pending_friends.length <= 0)
    {
      pending_friends = "No pending friend requests currently.";
    }

    if (blocked_friends.length <= 0)
    {
      blocked_friends = "No blocked friends currently!";
    }

    return (
      <React.Fragment>
      <button className="btn btn-success" onClick={this.toggle_friends_list}>Show/Hide Friends List</button>
        <div className="collapse friends_list_collapse">
          <h2>Incoming Friend Requests (click to accept): </h2>
            {incoming_requests}
          <h2>Current Friends: </h2>
          { friends_list }
          <h2>Pending Friends: </h2>
          { pending_friends }
          <h2>Blocked Friends: </h2>
          { blocked_friends }
        </div>
      </React.Fragment>
    );
  }
}

export default FriendsList
