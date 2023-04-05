//
//  HexColour.swift
//  loadFromURL
//
//  Created by Sean Kelly on 30/03/2023.
//

/** Allows using a Hexidecimal code as a colour */
/** Use: .foregroundColor(Color(hex: "C9C9C9").opacity(1.0)) for example */

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

