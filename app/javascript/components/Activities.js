import React from "react"
import PropTypes from "prop-types"
import axios from "axios"

class Activities extends React.Component {

  constructor(props)
  {
    super(props)
    this.handleClick = this.handleClick.bind(this);
    this.loadData = this.loadData.bind(this)
    this.state = {
      our_activities: [],
      all_activities: []
    };
  }

  componentWillUnmount() {
  }
  

  componentDidMount() {
    this.loadData();
  }
  

  handleClick(e)
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
    console.log('5555 tet')
    axios({
      method: 'GET', 
      url: '/activities/get_activity_list',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
        this.setState({
          our_activities: response.data.our_activities,
          all_activities: response.data.all_activities
        });
    });

  }

  render () {
    var our_activities_jsonArray = this.state.our_activities;
    var all_activities_jsonArray = this.state.all_activities;

    var our_activity_nodes = our_activities_jsonArray.map(function (activity, index) {
      return (
        <div name={activity.name} key={index}> {activity.name} </div>
      );
    }); 

    var all_activity_nodes = all_activities_jsonArray.map((activity, index) => {
        return (
          <div key={index}><a onClick={this.handleClick} id={activity.id} href="#">{activity.name}</a></div>
        );
    });

    return (
      <React.Fragment>
        <h3>Current liked activities:</h3>
        { our_activity_nodes }
        < br/><hr />
        <h3>All activities:</h3>
        { all_activity_nodes }
        
      </React.Fragment>
    );
  }
}

export default Activities
