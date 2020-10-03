//
//  OutlineShape.swift
//  SwiftMaster
//
//  Created by Joss Manger on 10/3/20.
//

import SwiftUI

//Debugging shape scaling

struct OutlineShape <SH:Shape>: View {
  
  init(shape: SH){
    self.shape = shape
  }
  
  let shape: SH
  
  var body: some View {
    shape.fill().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
      .overlay(shape.fill().foregroundColor(.red).scaleEffect(0.9))
  }
  
}

struct OutlineShape_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        OutlineShape(shape:Circle()).frame(width: 100, height: 100, alignment: .center)
        OutlineShape(shape:Rectangle()).frame(width: 100, height: 200, alignment: .center)
        OutlineShape(shape:Capsule()).frame(width: 200, height: 100, alignment: .center)
      }
    }
}
