import React from "react"
import PropTypes from "prop-types"
import axios from "axios"

class FindAFriendSearch extends React.Component {
  _isMounted = false;

  constructor(props)
  {
    super(props)

    this.loadData = this.loadData.bind(this);
    this.add_friend = this.add_friend.bind(this);

    this.state = {
      potential_friends: []
    };
  }

  componentWillUnmount() {
    this._isMounted = false;
  }
  
  add_friend(e)
  {
   var id = e.target.id;
    
   axios({
    method: 'PUT', 
    url: '/find_a_friend/send_friend_request',
    data: { id: id },
    headers: {
      'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
    }
  })
  .then((response) => {
    this.loadData();
  });
  }

  componentDidMount() {
    this._isMounted = true;
    this.loadData();
  }

  loadData()
  {
    axios({
      method: 'get',
      url: '/find_a_friend/find_friends',
    }).then((response) => {
      if (this._isMounted) {
        this.setState({
          potential_friends: response.data.potential_friends
        });
      }
      setup_datatable();
    });
  }

  render () {
    var potential_friends_jsonArray = this.state.potential_friends;

    var potential_friends_list = potential_friends_jsonArray.map((friendo, index) => {
      return (
        <tr key={index}>
          <td><a href={"/users/" + friendo.id}>{friendo.first_name + ' ' + friendo.last_name}</a></td>
          <td>{friendo.gender}</td>
          <td>{friendo.sexuality}</td>
          <td>{friendo.religion}</td>
          <td>{friendo.race}</td>
          <td>{friendo.birthdate}</td>
          <td><button className="btn btn-primary" onClick={this.add_friend} id={friendo.id}>Add Friend</button></td>
        </tr>
      );
    }); 

    

    return (
      <React.Fragment>
<table id="friendo-datatable" className="table table-striped table-bordered table-sm" cellSpacing="0" width="100%">
<thead>
<tr>
<th className="th-sm">Name</th>
<th className="th-sm">About Me</th>
<th className="th-sm">Gender</th>
<th className="th-sm">Sexuality</th>
<th className="th-sm">Religion</th>
<th className="th-sm">Race</th>
<th className="th-sm">Birthdate</th>
<th className="th-sm">Friend Link</th>
</tr>
</thead>
<tbody>
    { potential_friends_list }        
</tbody>
</table>

      <button className="btn btn-primary" onClick={this.loadData}>Refresh</button>
      </React.Fragment>
    );
  }
}

export default FindAFriendSearch
