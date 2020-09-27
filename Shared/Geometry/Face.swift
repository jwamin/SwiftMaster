//
//  Face.swift
//  SwiftMaster
//
//  Created by Joss Manger on 9/26/20.
//

import SwiftUI

struct Face: View {
  
  let one = 360 / 12
  
  var body: some View {
    
    ZStack {
      ForEach(1..<13){ num in
        Text("\(num)")
          .foregroundColor(.black)
          .bold()
          .rotationEffect(.degrees(-Double(one * num)))
          .transformEffect(.init(translationX: 0, y: -100))
          .rotationEffect(.degrees(Double(one * num)))
      }
    }.frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
  }
}

struct Face_Previews: PreviewProvider {
  static var previews: some View {
    Face().previewLayout(.sizeThatFits)
  }
}
