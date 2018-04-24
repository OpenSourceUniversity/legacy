import React, { Component } from 'react'
import AddCourse from './AddCourse'

class Courses extends Component {
  constructor(props, { authData }) {
    super(props)
    authData = this.props
  }

  render() {
    return(
      <main className="container">
        <div className="pure-g">
          <div className="pure-u-1-1">
            <h1>Courses</h1>
            <AddCourse />
          </div>
        </div>
      </main>
    )
  }
}

export default Courses
