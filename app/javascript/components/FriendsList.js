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
    this.state = {
      friends: [],
      pending_friends: [],
      blocked_friends: []
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
          blocked_friends: response.data.blocked_friends    
        });
      }
    });
  }

  toggle_friends_list()
  {
    $('.collapse.friends_list_collapse').collapse('toggle')
  }

  render () {

    var friends_list = this.state.friends.map((friend, index) => {
      return (
        <div key={index}><a className="list-group-item list-group-item-action" id={friend.id} href="#">{friend.first_name}</a></div>
      );
    }); 

    var pending_friends = this.state.pending_friends.map((friend, index) => {
      return (
        <div key={index}><a className="list-group-item list-group-item-action" id={friend.id} href="#">{friend.first_name}</a></div>
      );
    });

    var blocked_friends = this.state.blocked_friends.map((friend, index) => {
      return (
        <div key={index}><a className="list-group-item list-group-item-action" id={friend.id} href="#">{friend.first_name}</a></div>
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
