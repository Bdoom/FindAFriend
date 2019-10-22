import React from "react"
import PropTypes from "prop-types"

class Post extends React.Component {
  render () {
    return (
      <React.Fragment>
        <article className="card">
            <span className="card-body">
              <div className="text-dark">{this.props.created_at}</div>
              <div className="text-dark">{this.props.post_body}</div>
            </span>
        </article>
      </React.Fragment>
    );
  }
}

export default Post
