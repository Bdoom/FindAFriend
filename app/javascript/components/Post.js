import React from "react"
import PropTypes from "prop-types"

class Post extends React.Component {
  render () {
    if (this.props.board_thread_id > 0)
    {
      return (
        <React.Fragment>
          <article className="card">
              <span className="card-body">
                <div className="text-dark">
                      {this.props.created_at}
                      {this.props}
                      <a href={"/board_threads/" + this.props.board_thread_id}> thread</a>
                </div>
                <div className="text-dark">{this.props.post_body}</div>
              </span>
          </article>
        </React.Fragment>
      );
    }
    else
    {
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
}

export default Post
