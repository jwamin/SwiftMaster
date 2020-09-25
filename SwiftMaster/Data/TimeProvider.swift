//
//  TimeProvider.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/25/20.
//

import SwiftUI
import Combine

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
      
      let hour = Double(Calendar.current.component(.hour, from: date))
      let minute = Double(Calendar.current.component(.minute, from: date))
      let seconds = Double(Calendar.current.component(.second, from: date))
      let milli = Double(Calendar.current.component(.nanosecond, from: date)) / 1_000_000
      let day = Calendar.current.component(.day, from: date)
      let time = Time(hours: hour, minutes: minute, seconds: seconds, ms: milli, dayOfMonth: day)
      
      //print(time)
      
      return time
      
    }.assign(to: &$publishedTime)
    print("setup")
  }
  
  
}
