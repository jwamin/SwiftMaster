//
//  Hands.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/25/20.
//

import SwiftUI

struct MinuteHandFill: View {
    var body: some View {
      ZStack{
        GeometryReader { reader in
        DiverHand(topSegmentOffset: 4)
          .fill().foregroundColor(.blue)
          Triangle().fill().frame(width: reader.size.width, height: reader.size.height / 4, alignment: .center).scaleEffect(0.7, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(y: reader.size.height/30)
          Rectangle().fill().frame(width: reader.size.width/24, height: reader.size.height/8, alignment: .center).position(x: reader.size.width/2, y: reader.size.height-reader.size.height/16)
          Circle().fill().frame(width: reader.size.width/6, height: reader.size.width/6, alignment: .center).position(x: reader.size.width/2, y: reader.size.height)
        }
      }
    }
}

struct HourHandFill: View {
    var body: some View {
      ZStack{
        GeometryReader { reader in
        DiverHand(topSegmentOffset: 6)
          .fill().foregroundColor(.blue)
          Circle().fill().frame(width: reader.size.width, height: reader.size.height / 3, alignment: .center).scaleEffect(0.7, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(y: reader.size.height/25)
          Rectangle().fill().frame(width: reader.size.width/24, height: reader.size.height/8, alignment: .center).position(x: reader.size.width/2, y: reader.size.height-reader.size.height/16)
          Circle().fill().frame(width: reader.size.width/6, height: reader.size.width/6, alignment: .center).position(x: reader.size.width/2, y: reader.size.height)
        }
      }
    }
}

//struct MinuteHandStroke: View {
//    var body: some View {
//      ZStack{
//        GeometryReader { reader in
//        DiverHand(topSegmentOffset: <#T##CGFloat#>)
//          .stroke().foregroundColor(.blue)
//          Triangle().fill().frame(width: reader.size.width, height: reader.size.height / 4, alignment: .center).scaleEffect(0.7, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(y: 10)
//          Rectangle().stroke().frame(width: reader.size.width/24, height: reader.size.height/8, alignment: .center).position(x: reader.size.width/2, y: reader.size.height-reader.size.height/16)
//          Circle().stroke().frame(width: reader.size.width/6, height: reader.size.width/6, alignment: .center).position(x: reader.size.width/2, y: reader.size.height-reader.size.width/12)
//        }
//      }
//    }
//}

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    let widthQuarter = rect.size.width / 4
    var path = Path()
    
    let topMiddle = CGPoint(x: widthQuarter * 2, y: 0)
    let bottomRight = CGPoint(x: rect.size.width, y: rect.size.height)
    let bottomLeft = CGPoint(x: 0, y: rect.size.height)
    
    path.move(to: topMiddle)
    path.addLine(to: bottomRight)
    path.addLine(to: bottomLeft)
    path.closeSubpath()
    
    return path
    
    
  }
}

struct DiverHand: Shape {
  
  let topSegmentOffset: CGFloat
  
  func path(in rect: CGRect) -> Path {
    
    var path = Path()
    
    let widthQuarter = rect.size.width / 4
    let height34 = rect.size.height / 8
    
    let distance:CGFloat = 7
    
    let topMiddle = CGPoint(x: widthQuarter * 2, y: 0)
    //let bottomMiddle = CGPoint(x: rect.size.width / 2, y: rect.size.height)
    
    
    let rightSegment = CGPoint(x: rect.size.width, y: rect.size.height / topSegmentOffset)
    let bottomMiddle1 = CGPoint(x: widthQuarter * 3, y:  height34 * distance)
    let bottomMiddle2 = CGPoint(x: widthQuarter, y:  height34 * distance)
    let leftSegment = CGPoint(x: 0, y: rect.size.height / topSegmentOffset)
    
    //let bottomMiddle3 = CGPoint(x: widthQuarter * 2, y:  height34 * distance)
    
    path.move(to: topMiddle)
    path.addLine(to: rightSegment)
    path.addLine(to: bottomMiddle1)
    path.addLine(to: bottomMiddle2)
    path.addLine(to: leftSegment)
    path.closeSubpath()
    
//    path.move(to: bottomMiddle3)
//    path.addLine(to: bottomMiddle)
//    path.closeSubpath()
    
    return path
    
  }
  
}


struct Hands_Previews: PreviewProvider {
    static var previews: some View {
      Group{
        MinuteHandFill().previewLayout(.sizeThatFits)
        //MinuteHandStroke().previewLayout(.sizeThatFits)
        HourHandFill().previewLayout(.sizeThatFits)
      }
    }
}
