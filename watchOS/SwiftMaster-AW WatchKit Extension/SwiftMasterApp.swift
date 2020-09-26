//
//  SwiftMasterApp.swift
//  SwiftMaster-AW WatchKit Extension
//
//  Created by Joss Manger on 9/26/20.
//

import SwiftUI

@main
struct SwiftMasterApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SwiftMasterClockFace()
            }
        }
    }
}
