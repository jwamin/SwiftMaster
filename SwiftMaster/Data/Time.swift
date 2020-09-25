//
//  Time.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/25/20.
//

import SwiftUI
import Combine

struct Time {
  
  let hours: Double
  let minutes: Double
  let seconds: Double
  let ms: Double
  let dayOfMonth: Int
  
  //DRY
  var hourAngle: Angle {
    let twelveHourDouble:Double = (hours > 12) ? hours - 12 : hours
    let minsDecimal = minutes / 60
    let renderingValue = twelveHourDouble + minsDecimal

    return Angle(degrees: (renderingValue / 12) * 360)
  }
  
  //DRY
  func minuteHandAngle() -> Angle {
    let secondsDecimal = seconds / 60
    let minutesDecimal = minutes + secondsDecimal
    
    return Angle(degrees: 360 * minutesDecimal / 60)
  }
  
  func secondHandAngle() -> Angle {
    let secondDblUnit = seconds
    let msDoubleUnit = ms
    
    let msDecimal = msDoubleUnit / 1000
    
    let secondRenderingValue = secondDblUnit + msDecimal
    
    return Angle(degrees: 360 * secondRenderingValue / 60)
    
  }
  
}
