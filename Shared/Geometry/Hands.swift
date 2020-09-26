//
//  Hands.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/25/20.
//

import SwiftUI

func createHand(_ reader: GeometryProxy, width: CGFloat, height: CGFloat? = nil, angle: Angle, color:Color) -> some View {
  
  let usedHeight = height ?? reader.size.height/2
  //hands
  
  return Rectangle().fill().foregroundColor(color).frame(width: width, height: usedHeight, alignment: .bottom).rotationEffect(angle, anchor: .bottom).position(x: reader.size.width/2, y: reader.size.height/2).offset(y: -(usedHeight/2))
}

struct MinuteHandFill: View {
    var body: some View {
      ZStack{
        GeometryReader { reader in
          DiverHand(topSegmentOffset: 4,cutoutOffset: 1.2, squareOffset: false)
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
          DiverHand(topSegmentOffset: 6,cutoutOffset:2.2, squareOffset: true)
          .fill().foregroundColor(.blue)
          Circle().fill().frame(width: reader.size.width, height: reader.size.height / 3, alignment: .center).scaleEffect(0.7, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(y: reader.size.height/25)
          Rectangle().fill().frame(width: reader.size.width/24, height: reader.size.height/8, alignment: .center).position(x: reader.size.width/2, y: reader.size.height-reader.size.height/16)
          Circle().fill().frame(width: reader.size.width/7, height: reader.size.height/7, alignment: .center).position(x: reader.size.width/2, y: reader.size.height)
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
  
  let split: CGFloat?
  
  init(splitInset: CGFloat? = nil) {
  
    self.split = splitInset
  }
  
  func path(in rect: CGRect) -> Path {
    let widthQuarter = rect.size.width / 4
    var path = Path()
    
    let topMiddle = CGPoint(x: widthQuarter * 2, y: 0)
    
    let bottomRight = CGPoint(x: rect.size.width, y: rect.size.height)
    let bottomLeft = CGPoint(x: 0, y: rect.size.height)
    
    path.move(to: topMiddle)
    path.addLine(to: bottomRight)
    if let inset = split {
      precondition(inset >= 0 && inset <= 1)
      let insetCoordinate = CGPoint(x: rect.size.width / 2, y: rect.size.height * inset)
      path.addLine(to: insetCoordinate)
    }
    path.addLine(to: bottomLeft)
    path.closeSubpath()
    
    return path
    
    
  }
}

struct GMTHand: View {
  var body: some View{
    ZStack{
      GeometryReader { reader in
        Rectangle().fill().foregroundColor(.gray).frame(width: reader.size.width / 8, height: reader.size.height * 0.9, alignment: .center).position(x: reader.size.width/2, y:reader.size.height / 2).offset(y: reader.size.height * 0.05)
    Triangle(splitInset: 0.7).fill().foregroundColor(.orange)
      .frame(width: reader.size.width, height: reader.size.height / 4, alignment: .center).overlay(Triangle(splitInset: 0.7).fill().foregroundColor(.white).scaleEffect(0.6))
                                                                    
      }
    }
  }
}

struct DiverHand: Shape {
  
  let topSegmentOffset: CGFloat
  let cutoutOffset: CGFloat
  let squareOffset: Bool
  
  func path(in rect: CGRect) -> Path {
    
    var path = Path()
    
    let widthQuarter = rect.size.width / 4
    let height34 = rect.size.height / 8
    
    let _ = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
    
    let distance:CGFloat = 7
    
    let topMiddle = CGPoint(x: widthQuarter * 2, y: 0)
    
    let rightSegment = CGPoint(x: rect.size.width, y: rect.size.height / topSegmentOffset)
    let bottomMiddle1 = CGPoint(x: widthQuarter * 3, y:  height34 * distance)
    let bottomMiddle2 = CGPoint(x: widthQuarter, y:  height34 * distance)
    let leftSegment = CGPoint(x: 0, y: rect.size.height / topSegmentOffset)
    
    path.move(to: topMiddle)
    path.addLine(to: rightSegment)
    path.addLine(to: bottomMiddle1)
    path.addLine(to: bottomMiddle2)
    path.addLine(to: leftSegment)
    path.closeSubpath()
    
    let rightSegmentOffset = CGPoint(x: widthQuarter * 3, y: rect.size.height / topSegmentOffset * cutoutOffset)
    
    let leftSegmentOffset = CGPoint(x: widthQuarter, y: rect.size.height / topSegmentOffset * cutoutOffset)
    
    let bottomMiddleOffset = CGPoint(x: widthQuarter * 2, y: height34 * 6.5)
    
    path.move(to: rightSegmentOffset)
    path.addLine(to: leftSegmentOffset)
    if squareOffset {
      let bottomMiddleOffset1 = CGPoint(x: widthQuarter * 1.5 , y: height34 * 6.5)
      let bottomMiddleOffset2 = CGPoint(x: widthQuarter * 2.5, y: height34 * 6.5)
      path.addLine(to: bottomMiddleOffset1)
      path.addLine(to: bottomMiddleOffset2)
    } else {
      path.addLine(to: bottomMiddleOffset)
    }
    
    path.closeSubpath()

    
    return path
    
  }
  
}

struct SecondsHand: View {
  
  let tipHeight:CGFloat = 4
  let handWidth: CGFloat = 20
  var body: some View {
    
    ZStack{
      GeometryReader { reader in
        
        //main hand
        Rectangle().fill().foregroundColor(.gray).frame(width: reader.size.width / handWidth, height: reader.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).position(x: reader.size.width/2,y:reader.size.height / 2)
        
        //tip
        Rectangle().fill().foregroundColor(.red).frame(width: reader.size.width / handWidth, height: reader.size.height / tipHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).position(x: reader.size.width/2, y: reader.size.height / tipHeight / 2)
        
        //circle
        Circle().fill().foregroundColor(.gray).frame(width: reader.size.width / 2, height: reader.size.width / 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).overlay(Circle().fill().foregroundColor(.white).scaleEffect(0.8)).position(x: reader.size.width/2, y: reader.size.height / 3)
      }
    }
    
    
  }
  
}


struct Hands_Previews: PreviewProvider {
    static var previews: some View {
      Group{
        MinuteHandFill().previewLayout(.sizeThatFits)
        SecondsHand().previewLayout(.sizeThatFits)
        HourHandFill().previewLayout(.sizeThatFits)
        GMTHand().previewLayout(.sizeThatFits)
      }
    }
}
