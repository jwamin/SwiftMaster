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
  let dayOfMonth: Int
}

let testTime = Time(hours: 10, minutes: 9, seconds: 25, dayOfMonth: 25)

struct SimpleClockFace: View {
  
  let time: Time
  let timeProvider = TimeProvider()
  
  
  fileprivate func createHand(_ reader: GeometryProxy, width: CGFloat, height: CGFloat? = nil, angle: Angle, color:Color) -> some View {
    
    
    let usedHeight = height ?? reader.size.height/2
    //hands
    
    return Rectangle().fill().foregroundColor(color).frame(width: width, height: usedHeight, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.height/2, y: reader.size.width/2).offset(y: -(usedHeight/2))
  }
  
  var body: some View {
    ZStack{
      GeometryReader { reader in
        Circle().stroke().foregroundColor(Color.red)
        
        createHand(reader, width: 25,height:100, angle:.degrees(45),color:.black)
        
        createHand(reader, width: 10, angle:.degrees(290),color:.black)
        
        createHand(reader, width: 2, angle:.degrees(180),color:.red)
        
        //teeth
      }
    }
    .aspectRatio(1, contentMode: .fit)
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    SimpleClockFace(time: testTime)
  }
}


class TimeProvider: ObservableObject {
  
  @Published var publishedTime: Time = Time(hours: 0, minutes: 0, seconds: 0, dayOfMonth: 0)
  
  private var reciever: PassthroughSubject = PassthroughSubject<Date,Never>()
  private var set = Set<AnyCancellable>()
  
  init(){
    
    Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
      .sink { [weak self] (_) in
        self?.reciever.send(Date())
      }.store(in: &set)
    
    reciever.map { date in
      
      let hour = Calendar.current.component(.hour, from: date)
      let minute = Calendar.current.component(.minute, from: date)
      let seconds = Calendar.current.component(.second, from: date)
      
      let day = Calendar.current.component(.day, from: date)
      let time = Time(hours: hour, minutes: minute, seconds: seconds, dayOfMonth: day)
      
      print(time)
      
      return time
      
    }.assign(to: &$publishedTime)
    print("setup")
  }
  
  
}
