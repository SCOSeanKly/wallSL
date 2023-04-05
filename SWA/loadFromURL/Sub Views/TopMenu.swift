//
//  TopMenu.swift
//  loadFromURL
//
//  Created by Sean Kelly on 30/03/2023.
//

import SwiftUI

struct TopMenu: View {
    
    @Binding var isShowingSettings: Bool
    @Binding var creator: String
    @Binding var creatorColour: String
    @Binding var creatorImage: UIImage?
    @Binding var isShowingSettingsGear: Bool
    @Binding var showImageExportedNotification: Bool
    @Binding var fullScreenSavesCount: Int
    @Binding var title: String
    @Binding var titleColour: String
    @Binding var isAnimateGear: Bool
   
    var body: some View {
        
        VStack {
            HStack(alignment: .center) {
                
                GearIconView(isShowingSettingsGear: $isShowingSettingsGear, isShowingSettings: $isShowingSettings, showImageExportedNotification: $showImageExportedNotification, creatorImage: $creatorImage, titleColour: titleColour, isAnimateGear: $isAnimateGear)
                
                VStack(alignment: .leading) {
                         Text(title)
                             .font(.title)
                             .fontWeight(.bold)
                             .foregroundColor(Color(hex: titleColour))
                             .lineLimit(1)
                             .minimumScaleFactor(0.5)
                             .padding(.trailing)
                         
                         Text(creator)
                             .font(.body)
                             .fontWeight(.medium)
                             .foregroundColor(Color(hex: creatorColour))
                             .lineLimit(1)
                             .minimumScaleFactor(0.5)
                             .padding(.trailing)
                     }
                     .padding(.leading)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke((Color(hex: titleColour)).opacity(1.0), lineWidth: 1)
                        .frame(width: 60, height: 60)
                        .foregroundColor(.clear)
                        .overlay(
                            Group {
                                VStack {
                                    Text("\(fullScreenSavesCount)")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                    
                                    Text("SAVED")
                                        .font(.system(size: 12))
                                }
                                .foregroundColor(Color(hex: titleColour))
                                .onTapGesture(count: 2) {
                                    fullScreenSavesCount = 0
                                    feedback()
                                }
                                .scaleEffect(0.8)
                                .frame(width: 40, height: 40)
                            })
                }
                .opacity(0.5)
                
                
            }
            .padding()
            
            Spacer()
            
        }
        .frame(height: UIScreen.main.bounds.height * 0.1)
    }
}




