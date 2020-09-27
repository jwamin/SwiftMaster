//
//  Cerachrom.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/26/20.
//

import SwiftUI

let colaStops:[Gradient.Stop] = [
  .init(color: .red, location: 0),
  .init(color:.red, location: 0.4),
  .init(color: .blue, location: 0.6),
  .init(color:.blue, location: 1)
]

let manBatStops:[Gradient.Stop] = [
  .init(color: .black, location: 0),
  .init(color:.black, location: 0.4),
  .init(color: .blue, location: 0.6),
  .init(color:.blue, location: 1)
]

let cola = LinearGradient(gradient: Gradient(stops: colaStops), startPoint: .top, endPoint: .bottom)

let manBat = LinearGradient(gradient: Gradient(stops: manBatStops), startPoint: .top, endPoint: .bottom)

struct Cerachrom: View {

  var font: Font {
    #if os(watchOS)
    return .body
    #else
    return .title
    #endif
  }

  let one = 360 / 24
  
    var body: some View {
      ZStack{
        GeometryReader { reader in
          Circle().stroke(style: StrokeStyle(lineWidth: reader.size.height / 10)).fill(cola)
        ForEach(1..<25){ num in
          if num % 2 == 0 && num < 24 {
            Text("\(num)").font(font).foregroundColor(.black).bold().position(x: reader.size.width/2, y: reader.size.height/2).transformEffect(.init(translationX: 0, y: -reader.size.height/2)).foregroundColor(.white).rotationEffect(.degrees(Double(one * num)))
          } else if num == 24 {
            Triangle().fill().frame(width: reader.size.width/10, height: reader.size.height/15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).position(x: reader.size.width/2, y: reader.size.height/2).rotationEffect(.degrees(180)).transformEffect(.init(translationX: 0, y: -reader.size.height/2)).foregroundColor(.white).rotationEffect(.degrees(Double(one * num)))
          }
        }
        }
      }.padding()
    }
}

struct Cerachrom_Previews: PreviewProvider {
    static var previews: some View {
      Cerachrom().frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).previewLayout(.sizeThatFits)
    }
}
