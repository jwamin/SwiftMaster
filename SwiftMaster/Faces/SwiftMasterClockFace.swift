//
//  ContentView.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/25/20.
//

import SwiftUI
import Combine

struct SwiftMasterClockFace: View {
  
  var time: Time {
    timeProvider.publishedTime
  }
  @ObservedObject var timeProvider = TimeProvider()
  
  fileprivate func createMinuteHand(_ reader: GeometryProxy, width: CGFloat, height: CGFloat? = nil, angle: Angle) -> some View {
    
    
    let usedHeight = height ?? reader.size.height/2
    //hands
    let offsetCenter:CGFloat = -(usedHeight/2)
    
    return MinuteHandFill().frame(width: width, height: usedHeight, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.width/2, y: reader.size.height/2).offset(y: offsetCenter)
  }
  
  fileprivate func createHourHand(_ reader: GeometryProxy, angle: Angle) -> some View {
    
    
    let height = reader.size.height/3
    let width = reader.size.height/6
    //hands
    let offsetCenter:CGFloat = -(height/2)
    
    return HourHandFill().frame(width: width, height: height, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.width/2, y: reader.size.height/2).offset(y: offsetCenter)
  }
  
  fileprivate func renderDate(_ reader: GeometryProxy, color: Color) -> some View {
    
    let usedHeight = reader.size.height/2
    //hands
    
    return Text("\(time.dayOfMonth)").font(.title).bold().foregroundColor(color).position(x: reader.size.width/2, y: reader.size.height).offset(y: -(usedHeight/4))
  }
  
  var body: some View {
    ZStack{
      GeometryReader { reader in
        
        Circle().stroke().foregroundColor(Color.red)
        
        renderDate(reader, color: .red)
        
        createHourHand(reader, angle: time.hourAngle)

        createMinuteHand(reader, width: reader.size.width/6.5, angle: time.minuteHandAngle())
        
        createHand(reader, width: 2, angle:time.secondHandAngle(),color:.red)
        
        //notches
        
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .padding()
    .drawingGroup()
  }
}

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    Group {
      SwiftMasterClockFace()
    }
    
  }
}

