//
//  CloseButtonSettings.swift
//  loadFromURL
//
//  Created by Sean Kelly on 04/04/2023.
//

import SwiftUI

struct CloseButtonSettings: View {
    
    @Binding var isShowingSettings: Bool
    @Binding var isShowingSettingsGear: Bool
    @Binding var appBackgroundColour: String
    
    let cornerRadius: CGFloat = 50
    let frameSize: CGFloat = 35
    
    var body: some View {
        
        let color = Color(hex: appBackgroundColour)
        
        HStack {
            
            Button {
                isShowingSettings = false
                isShowingSettingsGear = true
                feedback()
            } label: {
                
                ZStack{
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundColor(color)
                        .frame(width: frameSize, height: frameSize)
                    
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(Color.lightGray, lineWidth: 2)
                        .frame(width: frameSize, height: frameSize)
                    
                    Image(systemName: "xmark")
                        .frame(width: frameSize, height: frameSize)
                }
            }
            .tint(.lightGray)
            
            Spacer()
        }
        .frame(height: 65)
    }
}
