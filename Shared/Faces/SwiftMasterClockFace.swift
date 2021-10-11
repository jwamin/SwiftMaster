//
//  ContentView.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/25/20.
//

import SwiftUI
import Combine

struct SwiftMasterClockFace: View {
  
  @State var show24Hour = true
  
  #if os(watchOS)
  
  @State var rotationAngleProvider = 0.0
  
  var rotationAngle: Angle {
    print(rotationAngleProvider)
    let one:Double = 360 / 24
    return .degrees(one * rotationAngleProvider)
  }
  
  #else
  @State var startRotation:Angle?
  @State var rotationAngle: Angle = .init(degrees: 0)
  #endif
  
  let transition: AnyTransition = .asymmetric(insertion: AnyTransition.opacity.combined(with: .scale), removal: .opacity) 
  
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
    
      GeometryReader { reader in
        if show24Hour {
          Bezel()
            .rotationEffect(rotationAngle).frame(width: reader.size.width, height: reader.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .transition(transition)
        }
        DiverFace(date: time.dayOfMonth,show24: show24Hour)
          .frame(width: reader.size.width, height: reader.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .scaleEffect(show24Hour ? 0.8 : 1)
        ZStack {
          if show24Hour {
            create24HourHand(reader, angle: time.hourAngle24).transition(transition)
          }
          
          createHourHand(reader, angle: time.hourAngle)
          
          createMinuteHand(reader, width: reader.size.width/7.5, angle: time.minuteHandAngle())
          
          createSecondHand(reader, angle: time.secondHandAngle())
        }.scaleEffect(show24Hour ? 0.75 : 1)
        
      }
      .aspectRatio(1, contentMode: .fit)
      
  }
  
  var body: some View {
    VStack {
      #if os(watchOS)
      face
        .focusable(true)
        .digitalCrownRotation($rotationAngleProvider,from:0,through:24, by: 1, sensitivity: .low, isContinuous: true, isHapticFeedbackEnabled: true)
        .drawingGroup()
      #else
      face
        .gesture(
          RotationGesture()
            .onChanged({ (angle) in
              var angleTo = angle
              if let isRotating = self.startRotation {
                angleTo = angleTo + isRotating
                self.rotationAngle = angleTo
              } else {
                self.startRotation = self.rotationAngle
                print("starting rotation, will skip first iteration")
              }
            })
            .onEnded({ (angle) in
              if let isRotating = self.startRotation {
                let one:Double = 360 / 24
                let degrees = round((angle.degrees + isRotating.degrees) / one) * one
                self.startRotation = nil
                withAnimation(.easeInOut) {
                  self.rotationAngle = .degrees(degrees)
                }
              }
            })
        )
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

