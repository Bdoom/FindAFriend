import React from "react"
import PropTypes from "prop-types"

class Post extends React.Component {
  render () {
    return (
      <React.Fragment>
        <article className="card">
            <span className="card-body">
              <div>{this.props.created_at}</div>
              {this.props.post_body}
            </span>
        </article>
      </React.Fragment>
    );
  }
}

export default Post
