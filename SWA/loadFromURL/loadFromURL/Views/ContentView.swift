//
//  ContentView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var images: [UIImage] = []
    @State private var selectedImageIndex: Int?
    @State private var isShowingFullScreenImage: Bool = false
    @State private var isShowingSettings: Bool = false
    @State  var title: String = "Loading..."
    @State  var titleColour: String = "f3f3f3"
    @State var creator: String = "Please be patient"
    @State var creatorColour: String = "c9c9c9"
    @State var socialMediaURL: String = "Social Media URL"
    @State var socialMediaPlatform: String = "Social Media Platform"
    @State var socialMediaUsername: String = "Social Media Username"
    @State var bioInformation: String = "Bio Information"
    @State var informationText: String = "Info Text"
    @State var informationHeader: String = "INFO HEADER"
    @State var bioURL1: String = ""
    @State var bioURL2: String = ""
    @State var creatorImage: UIImage? = nil
    @State var isShowingSettingsGear: Bool = true
    @State var outputImageFileSize: Double = 0.0
    @State private var imageSizeInPixels: CGSize = .zero
    @State private var showImageSavedNotification: Bool = false
    @State private var appBackgroundColour: String = "171B21"
    @AppStorage("fullScreenSavesCount") var fullScreenSavesCount = 0
    @State private var isAnimateGear = false
    
    var body: some View {
        
        ZStack {
            
            BackgroundView(appBackgroundColour: $appBackgroundColour)
                .overlay(isShowingSettings ?  Color.black.opacity(0.5) : Color.black.opacity(0.0))

            VStack {
                
                TopMenu(isShowingSettings: $isShowingSettings, creator: $creator, creatorColour: $creatorColour, creatorImage: $creatorImage, isShowingSettingsGear: $isShowingSettingsGear, showImageExportedNotification: $showImageSavedNotification, fullScreenSavesCount: $fullScreenSavesCount, title: $title, titleColour: $titleColour, isAnimateGear: $isAnimateGear)
                
                WallpaperView(title: $title, creator: $creator, titleColour: $titleColour, creatorColour: $creatorColour, socialMediaURL: $socialMediaURL, socialMediaPlatform: $socialMediaPlatform, socialMediaUsername: $socialMediaUsername, bioInformation: $bioInformation, bioURL1: $bioURL1, bioURL2: $bioURL2, creatorImage: $creatorImage, outputImageFileSize: $outputImageFileSize, imageSizeInPixels: $imageSizeInPixels, informationHeader: $informationHeader, informationText: $informationText, showImageExportedNotification: $showImageSavedNotification, appBackgroundColour: $appBackgroundColour, fullScreenSavesCount: $fullScreenSavesCount, isShowingSettings: $isShowingSettings, isAnimateGear: $isAnimateGear)
            }
            
            SettingsView(isShowingSettings: $isShowingSettings, isShowingSettingsGear: $isShowingSettingsGear, bioInformation: $bioInformation, socialMediaPlatform: $socialMediaPlatform, bioURL1: bioURL1, creator: creator, informationText: informationText, informationHeader: informationHeader, socialMediaUsername: $socialMediaUsername, appBackgroundColour: $appBackgroundColour, titleColour: titleColour, creatorColour: creatorColour )
            
            ImageExportedNotification(showImageExportedNotification: $showImageSavedNotification, outputImageFileSize: outputImageFileSize, imageSizeInPixels: imageSizeInPixels)
        }
    }
}

extension Int: Identifiable {
    public var id: Int { self }}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .small)
            .environment(\.colorScheme, .dark)
    }
}

