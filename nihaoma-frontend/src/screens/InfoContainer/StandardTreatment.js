import React, { Component } from 'react'

class StandardTreatment extends Component {

  render() {
    return (
      <div className="iphone-container" onClick={() => this.props.getRandomCondition({chloe: [], eric: "2"})}>
        <div className="iphone">
          <div className="top-bar">
            <div className="speaker"></div> 
            <div className="camera"></div> 
            <div className="camera-2"></div> 
          </div>
          
          <div className="screen">
            <h2>Standard treatment for this condition: </h2>

          </div>

          <div className="button"></div>
        </div>
      </div>
    ) 
  }
}

export default StandardTreatment

