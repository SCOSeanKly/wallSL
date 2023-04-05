//
//  BackgroundView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 30/03/2023.
//

/** DARK BACKGROUND FROM ASSETS */

import SwiftUI

struct BackgroundView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    @Binding var appBackgroundColour: String
    
    var body: some View {
        
        let color = Color(hex: appBackgroundColour)
        
        ZStack {
            Rectangle()
                .foregroundColor(color)
                .ignoresSafeArea()
        }
        .frame(width: screenWidth)
    }
}


