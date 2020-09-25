//
//  ContentView.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/25/20.
//

import SwiftUI
import Combine

struct Time {
  let hours: Int
  let minutes: Int
  let seconds: Int
  let ms: Int
  let dayOfMonth: Int
  
  var hourAngle: Angle {
    
    let twelveHours:Double = (hours > 12) ? Double(hours - 12) : Double(hours)
    let angle:Double = Double(twelveHours / 12) * Double(360)

    return Angle(degrees: angle)
  }
  
  var sixtyAngle:(Int) -> Angle = { unit in
    let dblUnit = Double(unit)
    return Angle(degrees: 360 * Double(dblUnit / 60))
    
  }
  
  func secondHandAngle() -> Angle {
    let secondDblUnit = Double(seconds)
    let msDoubleUnit = Double(ms)
    
    let msDecimal = Double(msDoubleUnit / 1000)
    
    let secondRenderingValue = secondDblUnit + msDecimal
    
    return Angle(degrees: 360 * Double(secondRenderingValue / 60))
    
  }
  
}



struct SimpleClockFace: View {
  
  var time: Time {
    timeProvider.publishedTime
  }
  @ObservedObject var timeProvider = TimeProvider()
  
  
  fileprivate func createHand(_ reader: GeometryProxy, width: CGFloat, height: CGFloat? = nil, angle: Angle, color:Color) -> some View {
    
    
    let usedHeight = height ?? reader.size.height/2
    //hands
    
    return Rectangle().fill().foregroundColor(color).frame(width: width, height: usedHeight, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.width/2, y: reader.size.height/2).offset(y: -(usedHeight/2))
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
        
        createHand(reader, width: 25,height:100, angle:time.hourAngle,color:.black)
        
        createHand(reader, width: 10, angle:time.sixtyAngle(time.minutes),color:.black)
        
        createHand(reader, width: 2, angle:time.secondHandAngle(),color:.red)
        
        renderDate(reader, color: .red)
        
        //teeth
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .padding()
    .drawingGroup()
  }
}

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    SimpleClockFace()
  }
}



class TimeProvider: ObservableObject {
  
  @Published var publishedTime: Time = Time(hours: 10, minutes: 9, seconds: 25, ms: 999, dayOfMonth: 25)
  
  private var reciever: PassthroughSubject = PassthroughSubject<Date,Never>()
  private var set = Set<AnyCancellable>()
  
  init(){
    
    Timer.publish(every: 0.15, on: .main, in: .common).autoconnect()
      .sink { [weak self] (_) in
        self?.reciever.send(Date())
      }.store(in: &set)
    
    reciever.map { date in
      
      let hour = Calendar.current.component(.hour, from: date)
      let minute = Calendar.current.component(.minute, from: date)
      let seconds = Calendar.current.component(.second, from: date)
      let milli = Calendar.current.component(.nanosecond, from: date) / 1_000_000
      let day = Calendar.current.component(.day, from: date)
      let time = Time(hours: hour, minutes: minute, seconds: seconds, ms: milli, dayOfMonth: day)
      
      print(time)
      
      return time
      
    }.assign(to: &$publishedTime)
    print("setup")
  }
  
  
}
