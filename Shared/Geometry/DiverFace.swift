//
//  Face.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/26/20.
//

import SwiftUI

struct DiverFace: View {
  
  let date: Int
  let one = 360 / 12
  let sixty = 360 / 60
  let thickness:CGFloat = 2
  let show24:Bool
  
  fileprivate func renderDate(_ reader: GeometryProxy, color: Color) -> some View {
    
    let usedHeight = reader.size.height/2
    //hands
    
    return Text("\(date)").font(.body).foregroundColor(color).transformEffect(.init(scaleX: 1, y: 1.5)).position(x: reader.size.width/2, y: reader.size.height / 2)
      
      .transformEffect(.init(translationX: 0, y: reader.size.width/3.2))
  }
  
  func getDecoration(reader: GeometryProxy, index:Int) -> AnyView {
    switch index {
    case 1,2,4,5,7,8,10,11:
      return AnyView(makeCircle(reader: reader, size: 10)
                      .transformEffect(.init(translationX: 0, y: -reader.size.width/2.5)).rotationEffect(.degrees(Double(one * index))).position(x: reader.size.width/2, y: reader.size.height/2))
    case 3, 9:
      return AnyView(Rectangle().fill().foregroundColor(.gray)
                                .overlay(Rectangle().fill().scaleEffect(CGSize(width: 0.7, height: 0.9)).foregroundColor(.white))
                      .frame(width: reader.size.width / 20,height: reader.size.width / 9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).transformEffect(.init(translationX: 0, y: -reader.size.width/2.5))
                      .rotationEffect(.degrees(Double(one * index)))
                      .position(x: reader.size.width/2, y: reader.size.height/2).position(x: reader.size.width/2, y: reader.size.height/2))
    case 6:
      return AnyView(Rectangle().fill().foregroundColor(.gray)
                            .overlay(Rectangle().fill().scaleEffect(0.7).foregroundColor(.white)).frame(width: reader.size.width / 20,height: reader.size.width / 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).position(x: reader.size.width/2, y: reader.size.height/2).transformEffect(.init(translationX: 0, y: -reader.size.width/2.5)).rotationEffect(.degrees(Double(one * index))))
    case 12:
      
      if show24 {
        
        return AnyView(
          Triangle().fill()
            .foregroundColor(.gray)
            .overlay(Triangle().fill().foregroundColor(.white).scaleEffect(0.6).offset(y: reader.size.height / 220))
            .frame(width: reader.size.width / 8,height: reader.size.width / 7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .position(x: reader.size.width/2, y: reader.size.height/2 ).rotationEffect(.init(degrees: 180)).transformEffect(.init(translationX: 0, y: -reader.size.width/2.6)))
        
      } else {
        
        return AnyView(HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: reader.size.width/50, content: {
          ForEach(0..<2){ num in
            Rectangle().fill().foregroundColor(.gray)
              .overlay(Rectangle().fill().scaleEffect(CGSize(width: 0.7, height: 0.9)).foregroundColor(.white))
              .frame(width: reader.size.width / 20,height: reader.size.width / 9, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          }
        }).position(x: reader.size.width/2, y: reader.size.height/2).transformEffect(.init(translationX: 0, y: -reader.size.width/2.5)))
        
      }
      

    default:
      return AnyView(EmptyView())
    }
  }
  
  func isLongTooth(_ tooth:Int) -> Bool {
    tooth % 5 == 0
  }
  
  var body: some View {
    
    ZStack {
      GeometryReader { reader in
        
        ForEach(1..<61){ tooth in Rectangle().fill().foregroundColor(.gray).frame(width: 2, height: reader.size.height / (isLongTooth(tooth) ? 40 : 80), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).position(x: reader.size.width/2, y: reader.size.height/2).transformEffect(.init(translationX: 0, y: -reader.size.width/2)).rotationEffect(.degrees(Double(sixty * tooth)))
          }
        
        
        ForEach(1..<13){ num in
          
          getDecoration(reader: reader, index: num)
          
          
        }
        #if os(watchOS)
        renderDate(reader, color: colaTop).offset(y: -8)
        #else
        renderDate(reader, color: colaTop)
        #endif
      }.mask(Circle())
    }
  }
}

struct DiverFace_Previews: PreviewProvider {
  static var previews: some View {
    DiverFace(date:26,show24:true).previewLayout(.sizeThatFits)
    DiverFace(date:26,show24:false).previewLayout(.sizeThatFits)
  }
}
