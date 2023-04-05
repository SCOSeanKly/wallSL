//
//  loadFromURLApp.swift
//  loadFromURL
//
//  Created by Sean Kelly on 30/03/2023.
//

import SwiftUI

@main
struct loadFromURLApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .small)
                .environment(\.colorScheme, .dark) // or .light
        }
    }
}
