//
//  SettingsView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 30/03/2023.
//

import SwiftUI

struct SocialMediaLinkView: View {
    
    var bioURL: String?
    var creator: String
    var socialMediaUsername: String
    var socialMediaPlatform: String
    var titleColour: String
    var creatorColour: String
    
    var body: some View {
        if let unwrappedBioURL = bioURL, let url = URL(string: unwrappedBioURL) {
            HStack {
                Text("Visit \(creator) (\(socialMediaUsername)) on")
                    .font(.footnote)
                    .foregroundColor(Color(hex: creatorColour))
                
                Link("\(socialMediaPlatform.capitalized)", destination: url)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .offset(x: -5)
                
                Spacer()
            }
            .padding(.top, 5)
        } else {
            HStack{
                Text("Invalid URL")
                    .font(.footnote)
                    .foregroundColor(.lightGray)
                    .padding(.top, 5)
                
                Spacer ()
            }
        }
    }
}

struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    
    @Binding var isShowingSettings: Bool
    @Binding var isShowingSettingsGear: Bool
    @Binding var bioInformation: String
    @Binding var socialMediaPlatform: String
    var bioURL1: String?
    var creator: String
    var informationText: String
    var informationHeader: String
    @Binding var socialMediaUsername: String
    @Binding var appBackgroundColour: String
    var titleColour: String
    var creatorColour: String
    
    var socialMediaPlatformImage: Image {
        switch socialMediaPlatform.lowercased() {
        case "twitter":
            return Image("twitter")
        case "telegram":
            return Image("telegram")
        case "instagram":
            return Image("instagram")
        default:
            return Image("none")
        }
    }
    
    var body: some View {
        
        ZStack {
            
            BackgroundView(appBackgroundColour: $appBackgroundColour)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.5), radius: 6)

            VStack {
             
           //     CloseButtonSettings(isShowingSettings: $isShowingSettings, isShowingSettingsGear: $isShowingSettingsGear, appBackgroundColour: $appBackgroundColour)
                
                InformationView(informationText: informationText, informationHeader: informationHeader, titleColour: titleColour, creatorColour: creatorColour)
                
                SocialMedia(socialMediaPlatform: $socialMediaPlatform, bioInformation: $bioInformation, titleColour: titleColour, creatorColour: creatorColour)
                
                SocialMediaLinkView(bioURL: bioURL1, creator: creator, socialMediaUsername: socialMediaUsername, socialMediaPlatform: socialMediaPlatform, titleColour: titleColour, creatorColour: creatorColour)
                
                ShowCreative(creatorColour: creatorColour)
                
                Spacer()
                
            }
            .padding()
        }
        .offset(y: isShowingSettings ? UIScreen.main.bounds.height * 0.35 : UIScreen.main.bounds.height)
        .animation(Animation.easeInOut(duration: 0.3), value: isShowingSettings)
        .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .global)
            .onEnded { value in
                if value.translation.height > 0 {
                    isShowingSettings = false
                    isShowingSettingsGear = true
                }
            })
    }
}
