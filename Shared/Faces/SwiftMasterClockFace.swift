//
//  ContentView.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/25/20.
//

import SwiftUI
import Combine

struct SwiftMasterClockFace: View {
  
  @State var show24Hour = false
  
  var time: Time {
    timeProvider.publishedTime
  }
  @ObservedObject var timeProvider = TimeProvider()
  
  fileprivate func createMinuteHand(_ reader: GeometryProxy, width: CGFloat, height: CGFloat? = nil, angle: Angle) -> some View {
    
    let usedHeight = height ?? reader.size.height/2 * 0.95
    //hands
    let offsetCenter:CGFloat = -(usedHeight/2)
    
    return MinuteHandFill().frame(width: width, height: usedHeight, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.width/2, y: reader.size.height/2).offset(y: offsetCenter)
  }
  
  fileprivate func createHourHand(_ reader: GeometryProxy, angle: Angle) -> some View {
    
    
    let height = reader.size.height/3
    let width = reader.size.width/8
    //hands
    let offsetCenter:CGFloat = -(height/2)
    
    return HourHandFill().frame(width: width, height: height, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.width/2, y: reader.size.height/2).offset(y: offsetCenter)
  }
  
  fileprivate func create24HourHand(_ reader: GeometryProxy, angle: Angle) -> some View {
    
    
    let height = reader.size.height/2
    let width = reader.size.width/8
    //hands
    let offsetCenter:CGFloat = -(height/2)
    
    return GMTHand().frame(width: width, height: height, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.width/2, y: reader.size.height/2).offset(y: offsetCenter)
  }
  
  fileprivate func createSecondHand(_ reader: GeometryProxy, angle: Angle) -> some View {
    
    
    let height = reader.size.height/2
    let width = reader.size.width/8
    //hands
    let offsetCenter:CGFloat = -(height/2)
    
    return SecondsHand().frame(width: width, height: height, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.width/2, y: reader.size.height/2).offset(y: offsetCenter)
  }
  
  fileprivate func renderDate(_ reader: GeometryProxy, color: Color) -> some View {
    
    let usedHeight = reader.size.height/2
    //hands
    #if os(watchOS)
    let font: Font = .body
    #else
    let font: Font = .title
    #endif
    
    return Text("\(time.dayOfMonth)")
      .font(font)
      .bold()
      .foregroundColor(color)
      .position(x: reader.size.width/2, y: reader.size.height).offset(y: -(usedHeight/4))
  }
  
  var face: some View {
    ZStack{
      GeometryReader { reader in
        
        Circle().stroke(style:StrokeStyle(lineWidth: 2)).foregroundColor(Color.red)
        
        renderDate(reader, color: .red)
        if show24Hour {
          create24HourHand(reader, angle: time.hourAngle24).transition(AnyTransition.opacity.combined(with: .scale))
        }
        
        createHourHand(reader, angle: time.hourAngle)

        createMinuteHand(reader, width: reader.size.width/7.5, angle: time.minuteHandAngle())
        
        //createHand(reader, width: 2, angle:time.secondHandAngle(),color:.red)
        createSecondHand(reader, angle: time.secondHandAngle())
        
        //notches
        
      }
    }.aspectRatio(1, contentMode: .fit)

  }
  
  var body: some View {
    VStack {
    #if os(watchOS)
    face
      .padding(1)
      .drawingGroup()
    #else
    face
      .padding()
      .drawingGroup()
    #endif
    }.onTapGesture {
      withAnimation(.spring()){
        show24Hour.toggle()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    Group {
      SwiftMasterClockFace(show24Hour: true)
    }
    
  }
}

