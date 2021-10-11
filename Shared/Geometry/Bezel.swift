//
//  Bezel.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/26/20.
//

import SwiftUI
let colaTop = Color(#colorLiteral(red: 0.2484996319, green: 0.3134403527, blue: 0.4062224627, alpha: 1))
let colaBottom = Color(#colorLiteral(red: 0.6232631803, green: 0.08479057997, blue: 0.1134851053, alpha: 1))
let colaStops:[Gradient.Stop] = [
  .init(color: colaTop, location: 0),
  .init(color: colaTop, location: 0.5),
  .init(color: colaBottom, location: 0.5),
  .init(color: colaBottom, location: 1)
]

let manBatStops:[Gradient.Stop] = [
  .init(color: .black, location: 0),
  .init(color:.black, location: 0.4),
  .init(color: .blue, location: 0.6),
  .init(color:.blue, location: 1)
]

let one = 360 / 24

let cola = LinearGradient(gradient: Gradient(stops: colaStops), startPoint: .top, endPoint: .bottom)

let manBat = LinearGradient(gradient: Gradient(stops: manBatStops), startPoint: .top, endPoint: .bottom)

struct Bezel: View {

  var font: Font {
    #if os(watchOS)
    return .body
    #else
    return .title
    #endif
  }

//  func numberTransformer(reader:GeometryProxy, view: View, transformIteration:Int) -> some View {
//    return view
//  }
//
  let inset:CGFloat = 10 / 2
  
    var body: some View {
      ZStack{
        GeometryReader { reader in
          Circle().inset(by: reader.size.height / 10 / 2).stroke(style: StrokeStyle(lineWidth: reader.size.height / 10)).fill(cola)
        ForEach(1..<25){ num in
          if num % 2 == 0 && num < 24 {
            Text("\(num)").font(font).foregroundColor(.white).bold().modifier(BezelTextModifier(reader:reader,transformIteration:num))
          } else if num % 2 != 0 {
            Text(".").font(font).foregroundColor(.white).bold().modifier(BezelTextModifier(reader:reader,transformIteration:num))
        } else if num == 24 {
          Triangle().fill().frame(width: reader.size.width/10, height: reader.size.height/15, alignment: .center).position(x: reader.size.width/2, y: reader.size.height/2).rotationEffect(.degrees(180)).transformEffect(.init(translationX: 0, y: -reader.size.height/2.23)).foregroundColor(.white).rotationEffect(.degrees(Double(one * num)))
          }
        }
        }
      }
    }
}

struct Bezel_Previews: PreviewProvider {
    static var previews: some View {
      Bezel().frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).previewLayout(.sizeThatFits)
    }
}

struct BezelTextModifier: ViewModifier {
  
  let reader:GeometryProxy
  let transformIteration:Int

    func body(content: Content) -> some View {
        content
          .position(x: reader.size.width/2, y: reader.size.height / 2 ).transformEffect(.init(translationX: 0, y: -reader.size.height/2.23)).foregroundColor(.white).rotationEffect(.degrees(Double(one * transformIteration)))
    }
}
