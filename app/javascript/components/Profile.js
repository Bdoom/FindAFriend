import React from "react"
import PropTypes from "prop-types"
import axios from "axios"
import Post from './Post'

class Profile extends React.Component {
  _isMounted = false;
  page = 0;

  constructor(props)
  {
    super(props)

    this.loadData = this.loadData.bind(this);
    this.trackScrolling = this.trackScrolling.bind(this);

    this.state =
    {
      posts: []
    };
  }

  componentDidMount()
  {
    this._isMounted = true;
    document.addEventListener('scroll', this.trackScrolling);
    this.loadData();
  }

  componentWillUnmount()
  {
    this._isMounted = false;
    document.removeEventListener('scroll', this.trackScrolling);
  }

  trackScrolling()
  {
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
      this.loadNextPage();
    }
  }

  loadNextPage()
  {
    this.page++;

    axios({
      method: 'GET', 
      url: '/posts/get_recent_posts',
      params: { user_id: this.props.user_id, page: this.page },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      if (this._isMounted) {
        this.setState({ posts: [...this.state.posts, ...response.data.posts ] });
      }
    });

  }

  loadData()
  {
    axios({
      method: 'GET', 
      url: '/posts/get_recent_posts',
      params: { user_id: this.props.user_id, page: this.page },
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then((response) => {
      if (this._isMounted) {
        this.setState({
          posts: response.data.posts
        });
      }
    });
  }
  
  render ()
  {
    if (this.state.posts != null)
    {
      var posts = this.state.posts.map((post, index) => {
        var date = new Date(post.created_at);
        var date = "Posted: " + Number(date.getMonth() + 1) + "/" + date.getDate() + "/" + date.getFullYear()

        return (
          <li key={index} className="list-group-item">
            <Post created_at={date} post_body={post.body} />
          </li>
        );
      });
    }

    return (
      <React.Fragment>

      <ul id="profile_posts_list" className="list-group list-group-flush">
        { posts }        
      </ul>

      </React.Fragment>
    );
  }
}

export default Profile
