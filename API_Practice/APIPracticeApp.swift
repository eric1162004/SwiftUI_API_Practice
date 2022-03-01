//
//  API_PracticeApp.swift
//  API_Practice
//
//  Created by eric on 2022-03-01.
//

import SwiftUI

@main
struct APIPracticeApp: App {
    
    let network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
