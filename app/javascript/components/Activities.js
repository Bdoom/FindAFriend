import React from "react"
import PropTypes from "prop-types"
import axios from "axios"

class Activities extends React.Component {
  _isMounted = false;

  constructor(props)
  {
    super(props)
    this.handleClick_add_to_user = this.handleClick_add_to_user.bind(this);
    this.handleClick_remove_from_user = this.handleClick_remove_from_user.bind(this);

    this.loadData = this.loadData.bind(this);
    this.state = {
      our_activities: [],
      all_activities: []
    };
  }

  componentWillUnmount() {
    this._isMounted = false;
  }
  

  componentDidMount() {
    this._isMounted = true;
    this.loadData();
  }
  
  handleClick_remove_from_user(e)
  {
    var id = e.target.id;
    axios({
      method: 'PATCH', 
      url: '/activities/remove_activity_from_user',
      data: { id: id },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      this.loadData();
    });

  }

  handleClick_add_to_user(e)
  {
    var id = e.target.id;

    axios({
      method: 'PATCH', 
      url: '/activities/add_activity_to_user',
      data: { id: id },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      this.loadData();
    });

  }

  loadData()
  {
    axios({
      method: 'GET', 
      url: '/activities/get_activity_list',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      if (this._isMounted) {
        this.setState({
          our_activities: response.data.our_activities,
          all_activities: response.data.all_activities
        });
      }
      
    });

  }

  render () {
    var our_activities_jsonArray = this.state.our_activities;
    var all_activities_jsonArray = this.state.all_activities;

    var our_activity_nodes = our_activities_jsonArray.map((activity, index) => {
      return (
        <div key={index}><a className="list-group-item list-group-item-action" onClick={this.handleClick_remove_from_user} id={activity.id} href="#">{activity.name}</a></div>
      );
    }); 

    var all_activity_nodes = all_activities_jsonArray.map((activity, index) => {
        return (
          <div key={index}><a className="list-group-item list-group-item-action" onClick={this.handleClick_add_to_user} id={activity.id} href="#">{activity.name}</a></div>
        );
    });

    return (
      <React.Fragment>
        <h1>Purpose of activities</h1>
        <p>The activities you select below will determine who you are matched with.</p>

        <h3>Current liked activities (click to remove):</h3>
        <div className="list-group">
          { our_activity_nodes }
        </div>
        < br/><hr />
        <h3>All activities (click to add):</h3>    
        <div className="list-group">    
          { all_activity_nodes }
        </div>
      </React.Fragment>
    );
  }
}

export default Activities
