//
//  WallpaperView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 31/03/2023.
//

import SwiftUI
import PhotosUI

struct WallpaperView: View {
    
    @State private var imageUrls: [String] = []
    @State private var imageUrlsLowRes: [String] = []
    
    @State private var images: [UIImage?] = []
    @State private var lowResImages: [UIImage?] = []
    
    @Binding var title: String
    @Binding var creator: String
    @Binding var titleColour: String
    @Binding var creatorColour: String
    @Binding var socialMediaURL: String
    @Binding var socialMediaPlatform: String
    @Binding var socialMediaUsername: String
    @Binding var bioInformation: String
    @Binding var bioURL1: String
    @Binding var bioURL2: String
    @Binding var creatorImage: UIImage?
    @State private var isShowingFullScreenImage = false
    @State private var selectedImageIndex: Int?
    @Binding var outputImageFileSize: Double
    @Binding var imageSizeInPixels: CGSize
    @Binding var informationHeader: String
    @Binding var informationText: String
    @Binding var showImageExportedNotification: Bool
    let width = UIScreen.main.bounds.width * 0.28
    let height = UIScreen.main.bounds.width * 0.60
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    @Binding var appBackgroundColour: String
    @Binding var fullScreenSavesCount: Int
    @Binding var isShowingSettings: Bool
    @State private var isShowingDoubleTaptoSave: Int = 0
    @Binding var isAnimateGear: Bool
    

    
    var body: some View {
        
        VStack(spacing: 0){
            
            ScrollView(.vertical, showsIndicators: false) {
                // Images show as they load
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 16) {
                    ForEach(lowResImages.compactMap { $0 }, id: \.self) { image in
                        Button(action: {
                            // Only set the selectedImageIndex and isShowingFullScreenImage when the user taps on the thumbnail
                            selectedImageIndex = lowResImages.firstIndex(of: image)!
                            isShowingFullScreenImage = true
                        }, label: {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.6), radius: 6, x: 0, y: 0)
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(hex: "C9C9C9").opacity(0.4), lineWidth: 1))
                                .frame(width: width, height: height, alignment: .center)
                        })
                    }
                }
            }
            .refreshable {
                loadDataFromUrl()
                feedback()
            }
        }
        .disabled(isShowingSettings)
        .opacity(isShowingSettings ? 0.3 : 1.0)
        .padding(.horizontal)
        
        .fullScreenCover(item: $selectedImageIndex, onDismiss: {
            selectedImageIndex = nil
        }, content: { index in
            
            if let image = images[index] {
                ZStack {
                    
                    VStack {
                        
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: screenWidth, height: screenHeight)
                            .gesture(createDragGesture())
                            .ignoresSafeArea(.all)
                            .onTapGesture(count: 2){
                                feedback()
                                saveImageTap(image: image)
                                fullScreenSavesCount += 1
                                isShowingDoubleTaptoSave += 1
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                    isAnimateGear.toggle()
                                    
                                }
                            }
                    }
                 
                    if isShowingDoubleTaptoSave == 0 {
                       // Some view here to show how to save
                    }
                   /* CloseButtonWallpaper(selectedImageIndex: $selectedImageIndex, appBackgroundColour: $appBackgroundColour) */
                }
        
            } else {
               LoadingImageView(appBackgroundColour: $appBackgroundColour)
                    .gesture(createDragGesture())
            }
        })

        .onAppear {
            loadDataFromUrl()
        }
    }
    
    private func loadDataFromUrl() {
        // MARK: URL of JSON
        let urlStringJSON = "https://raw.githubusercontent.com/SCOSeanKly/wallSL/main/SWA/json/swaData.json"
        // MARK: Abbreviated URL of Wallpaper images
        let urlStringImages = "https://raw.githubusercontent.com/SCOSeanKly/wallSL/main/"
        
        guard let url = URL(string: urlStringJSON) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let dict = json as? [String: Any] {
                    
                    // Requires full url in the JSON
                    /*    if let imageUrlStrings = dict["imageUrls"] as? [String] {
                     imageUrls = imageUrlStrings
                     images = Array(repeating: nil, count: imageUrls.count)
                     for (index, imageUrlString) in imageUrlStrings.enumerated() {
                     if let imageUrl = URL(string: imageUrlString) {
                     URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                     guard let data = data else {
                     return
                     }
                     if let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                     images[index] = image
                     }
                     }
                     }.resume()
                     }
                     }
                     }
                     
                     if let imageUrlsLowResStrings = dict["imageUrlsLowRes"] as? [String] {
                     imageUrlsLowRes = imageUrlsLowResStrings
                     lowResImages = Array(repeating: nil, count: imageUrlsLowRes.count)
                     for (index, imageUrlString) in imageUrlsLowResStrings.enumerated() {
                     if let imageUrl = URL(string: imageUrlString) {
                     URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                     guard let data = data else {
                     return
                     }
                     if let lowResImage = UIImage(data: data) {
                     DispatchQueue.main.async {
                     lowResImages[index] = lowResImage
                     }
                     }
                     }.resume()
                     }
                     }
                     }
                     */
                    
                    // Only requires part of the url in the JSON
                    if let dict = json as? [String: Any] {
                        if let imageUrlStrings = dict["imageUrls"] as? [String] {
                            imageUrls = imageUrlStrings
                            images = Array(repeating: nil, count: imageUrls.count)
                            for (index, imageUrlString) in imageUrlStrings.enumerated() {
                                let fullImageUrlString = urlStringImages + imageUrlString
                                if let imageUrl = URL(string: fullImageUrlString) {
                                    URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                                        guard let data = data else {
                                            return
                                        }
                                        if let image = UIImage(data: data) {
                                            DispatchQueue.main.async {
                                                images[index] = image
                                            }
                                        }
                                    }.resume()
                                }
                            }
                        }
                    }
                    
                    // Only requires part of the url in the JSON
                    if let imageUrlsLowResStrings = dict["imageUrlsLowRes"] as? [String] {
                        imageUrlsLowRes = imageUrlsLowResStrings
                        lowResImages = Array(repeating: nil, count: imageUrlsLowRes.count)
                        for (index, imageUrlString) in imageUrlsLowResStrings.enumerated() {
                            let fullImageUrlString = urlStringImages + imageUrlString
                            if let imageUrl = URL(string: fullImageUrlString) {
                                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                                    guard let data = data else {
                                        return
                                    }
                                    if let lowResImage = UIImage(data: data) {
                                        DispatchQueue.main.async {
                                            lowResImages[index] = lowResImage
                                        }
                                    }
                                }.resume()
                            }
                        }
                    }
                    if let title = dict["title"] as? String {
                        self.title = title
                    }
                    
                    if let titleColour = dict["titleColour"] as? String {
                        self.titleColour = titleColour
                    }
                    
                    if let creator = dict["creator"] as? String {
                        self.creator = creator
                    }
                    
                    if let creatorColour = dict["creatorColour"] as? String {
                        self.creatorColour = creatorColour
                    }
                    
                    if let informationText = dict["informationText"] as? String {
                        self.informationText = informationText
                    }
                    
                    if let informationHeader = dict["informationHeader"] as? String {
                        self.informationHeader = informationHeader
                    }
                    
                    if let socialMediaDict = dict["socialmedia"] as? [String: Any] {
                        if let socialMediaURL = socialMediaDict["url"] as? String {
                            self.socialMediaURL = socialMediaURL
                        }
                        
                        if let socialMediaPlatform = socialMediaDict["platformHeader"] as? String {
                            self.socialMediaPlatform = socialMediaPlatform
                        }
                        
                        if let socialMediaUsername = socialMediaDict["username"] as? String {
                            self.socialMediaUsername = socialMediaUsername
                        }
                        
                        if let bioInformation = socialMediaDict["bioInfo"] as? String {
                            self.bioInformation = bioInformation
                        }
                        
                        if let bioURL1 = socialMediaDict["bioURL1"] as? String {
                            self.bioURL1 = bioURL1
                        }
                        
                        if let bioURL2 = socialMediaDict["bioURL2"] as? String {
                            self.bioURL2 = bioURL2
                        }
                    }
                    
                    if let creatorImageUrlString = dict["creatorImageUrl"] as? String,
                       let creatorImageUrl = URL(string: creatorImageUrlString) {
                        URLSession.shared.dataTask(with: creatorImageUrl) { data, response, error in
                            guard let data = data else {
                                return
                            }
                            if let creatorImage = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.creatorImage = creatorImage
                                }
                            }
                        }.resume()
                    }
                    
                    if let appBackgroundColour = dict["appBackgroundColour"] as? String {
                        self.appBackgroundColour = appBackgroundColour
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func saveImageTap(image: UIImage) {
        feedback()
        
        guard let pngData = image.pngData() else {
            // Handle error
            return
        }
        
        guard let transparentImage = UIImage(data: pngData, scale: image.scale)?.withRenderingMode(.alwaysOriginal) else {
            // Handle error
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(transparentImage, nil, nil, nil)
        
        let imageSizeInPoints = transparentImage.size
        
        imageSizeInPixels = CGSize(width: imageSizeInPoints.width * transparentImage.scale,
                                   height: imageSizeInPoints.height * transparentImage.scale)
        
        print("Image size in pixels: \(imageSizeInPixels)")
        
        outputImageFileSize = Double(pngData.count) / 1_000_000.0 // Get file size in megabytes
        
        print("File size: \(String(format: "%.1f", outputImageFileSize))MB")
        
        selectedImageIndex = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showImageExportedNotification.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            isAnimateGear.toggle()
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            showImageExportedNotification.toggle()
            
        }
    }
    
    func createDragGesture() -> some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .global)
            .onEnded { value in
                if value.translation.height > 0 {
                    selectedImageIndex = nil
                }
            }
    }
}

struct WallpaperView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .small)
            .environment(\.colorScheme, .dark)
    }
}





