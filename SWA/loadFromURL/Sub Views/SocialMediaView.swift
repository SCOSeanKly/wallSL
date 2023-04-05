//
//  SocialMediaView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 03/04/2023.
//

import SwiftUI

import SwiftUI

enum SocialMediaPlatform: String {
    case twitter
    case telegram
    case instagram
    case none
}

struct SocialMediaPlatformImage: View {
    let imageName: String
    
    var body: some View {
        
        ZStack {
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
        }
    }
}

struct SocialMedia: View {
    
    @Binding var socialMediaPlatform: String
    @Binding var bioInformation: String
    var titleColour: String
    var creatorColour: String
       
    
    var socialMediaPlatformImage: Image {
        switch SocialMediaPlatform(rawValue: socialMediaPlatform.lowercased()) {
        case .twitter:
            return Image("twitter")
        case .telegram:
            return Image("telegram")
        case .instagram:
            return Image("instagram")
        default:
            return Image("none")
        }
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                SocialMediaPlatformImage(imageName: socialMediaPlatform.lowercased())
                
                Text(socialMediaPlatform)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: titleColour))
                
                Spacer()
            }
            .padding(.top)
            .padding(.bottom, 5)
            
            HStack {
                Text(bioInformation)
                    .font(.footnote)
                    .foregroundColor(Color(hex: creatorColour))
                
                Spacer()
            }
        }
    }
}
