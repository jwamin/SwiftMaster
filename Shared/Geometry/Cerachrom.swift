//
//  Cerachrom.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/26/20.
//

import SwiftUI

struct Cerachrom: View {
  
  let strokeStyle = StrokeStyle(lineWidth: 35, lineCap: .square, lineJoin: .bevel, miterLimit: 2, dash: [],dashPhase: 10)
  
  let one = 360 / 24
  
    var body: some View {
      ZStack{
        Circle().stroke(style: strokeStyle).foregroundColor(.red)
          .overlay(Circle().stroke(style: strokeStyle).foregroundColor(.blue))
        ForEach(1..<25){ num in
          if num % 2 == 0 && num < 24 {
          Text("\(num)").bold().transformEffect(.init(translationX: 0, y: -190)).foregroundColor(.white).rotationEffect(.degrees(Double(one * num)))
          }
          if num == 24 {
            Triangle().fill().frame(width: 30, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).rotationEffect(.degrees(180)).transformEffect(.init(translationX: 0, y: -190)).foregroundColor(.white).rotationEffect(.degrees(Double(one * num)))
          }
        }
      }.padding()
    }
}

struct Cerachrom_Previews: PreviewProvider {
    static var previews: some View {
      Cerachrom().previewLayout(.sizeThatFits)
    }
}
