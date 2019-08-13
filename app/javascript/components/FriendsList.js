import React from "react"
import PropTypes from "prop-types"
import axios from "axios"

class FriendsList extends React.Component {
  _isMounted = false;

  constructor(props)
  {
    super(props)

    this.loadData = this.loadData.bind(this);
    this.state = {
      friends: []
    };
  }

  componentWillUnmount() {
    this._isMounted = false;
  }
  

  componentDidMount() {
    this._isMounted = true;
    this.loadData();
    setInterval(() => this.loadData(), 5000);
  }
  
  loadData()
  {
    axios({
      method: 'GET', 
      url: '/find_a_friend/get_friends_list',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      if (this._isMounted) {
        this.setState({
          friends: response.data.friends          
        });
      }
    });
  }

  render () {
    return (
      <React.Fragment>

      </React.Fragment>
    );
  }
}

export default FriendsList
