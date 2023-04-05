//
//  ImageSavedNotification.swift
//  loadFromURL
//
//  Created by Sean Kelly on 31/03/2023.
//

import SwiftUI

struct ImageExportedNotification: View {
    private let notificationSize = CGSize(width: UIScreen.main.bounds.width * 0.55, height: UIScreen.main.bounds.width * 0.15)
    private let notificationCornerRadius: CGFloat = 20
    static let notificationOffset: CGFloat = UIScreen.main.bounds.height * -0.41
    static let animationDuration = 0.5
    
    @Binding var showImageExportedNotification: Bool
    var outputImageFileSize: Double
    var imageSizeInPixels: CGSize
    
    private func getFileSizeColor(_ fileSize: Double) -> Color {
        switch fileSize {
        case 0..<2.5:
            return .green
        case 2..<5:
            return .orange
        default:
            return .red
        }
    }

    private var megapixelText: String {
        let megapixels = Int((imageSizeInPixels.width * imageSizeInPixels.height) / 1_000_000)
        return "\(megapixels) MP • "
    }
    
    private var imageSizeText: String {
        return "\(Int(imageSizeInPixels.width)) x \(Int(imageSizeInPixels.height)) •"
    }
    
    var body: some View {
        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: notificationCornerRadius)
                    .foregroundColor(.black)
                    .frame(width: notificationSize.width, height: notificationSize.height)
                    .overlay(RoundedRectangle(cornerRadius: notificationCornerRadius).stroke(Color.lightGray, lineWidth: 0.4))
                    .shadow(color: Color.black.opacity(0.6), radius: 6, y: 2)
                
                VStack (spacing: 8) {
                    HStack {
                        Text("SAVED IMAGE SIZE: ")
                            .font(.body)
                            .foregroundColor(.white)
                        
                        + Text(String(format: "%.1f", outputImageFileSize) + " MB")
                            .font(.body.weight(.heavy))
                            .foregroundColor(getFileSizeColor(outputImageFileSize))
                    }
                    HStack{
                        Text(megapixelText)
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "C9C9C9").opacity(1.0))
                        
                        + Text(imageSizeText)
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "C9C9C9").opacity(1.0))
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 5.0)
                                .frame(width: 36, height: 21)
                                .foregroundColor(.gray)
                            
                            Text("PNG")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .scaleEffect(0.8)
                        }
                    }
                }
                .scaleEffect(0.9)
            }
            .offset(y: showImageExportedNotification ? ImageExportedNotification.notificationOffset : -UIScreen.main.bounds.height)
            .animation(Animation.easeInOut(duration: ImageExportedNotification.animationDuration), value: showImageExportedNotification)
        }
    }
}


struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
