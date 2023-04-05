//
//  LoadingImageView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 04/04/2023.
//

import SwiftUI

struct LoadingImageView: View {
    
    let titleColor = Color(hex: "f3f3f3").opacity(1.0)
    let width = UIScreen.main.bounds.width * 0.15
    @Binding var appBackgroundColour: String
    
    var body: some View {
        ZStack {
            
            BackgroundView(appBackgroundColour: $appBackgroundColour)
            
            VStack {
                
                ProgressView()
                    .scaleEffect(1.5)
                    .foregroundColor(titleColor)
                    .padding()
            }
        }
    }
}
