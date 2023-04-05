//
//  ShowCreativeView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 03/04/2023.
//

import SwiftUI

struct ShowCreative: View {
    @Environment(\.openURL) var openURL
    
    let showCreativeURL = URL(string: "https://twitter.com/SeanKly")!
    var creatorColour: String
    
    
    var body: some View {
        ZStack {
            
            /*  RoundedRectangle(cornerRadius: 20)
             .strokeBorder(.gray, lineWidth: 0.5)
             .frame(width: 160, height: 65)
             .foregroundColor(.clear) */
            
            
            VStack {
                Text("App created by:")
                    .foregroundColor(Color(hex: creatorColour))
                
                Link("© ShowCreative 2023", destination: showCreativeURL)
                
                HStack {
                    Text("Ver. \(Bundle.main.appVersion!)")
                    Text("Build. \(Bundle.main.buildNumber!)")
                }
                .foregroundColor(Color(hex: creatorColour))
            }
            .font(.footnote)
            .frame(maxWidth: .infinity)
        }
        .padding(.top, 30)
    }
}

