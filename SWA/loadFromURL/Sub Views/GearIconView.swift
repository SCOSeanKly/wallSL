//
//  GearIconView.swift
//  loadFromURL
//
//  Created by Sean Kelly on 31/03/2023.
//

import SwiftUI

struct GearIconView: View {
    
    @Binding var isShowingSettingsGear: Bool
    @Binding var isShowingSettings: Bool
    @Binding var showImageExportedNotification: Bool
    @State private var iconName = "gearshape.fill"
    @Binding var creatorImage: UIImage?
    var titleColour: String
    @Binding var isAnimateGear: Bool
    
    private var gearOffset: CGSize {
        isShowingSettingsGear ? CGSize(width: 22, height: -22) : .zero
    }
    
    
    private let gearAnimation = Animation.easeInOut(duration: 0.5)
    @State private var gearRotationAngle = 0.0
    
    private let gearAnimation2 = Animation.easeInOut(duration: 2.0)
    @State private var gearRotationAngle2 = 0.0
    
    var body: some View {
        ZStack {
            gearIcon
            avatar
        }
    }
    
    private var gearIcon: some View {
        Image(systemName: iconName)
            .font(.largeTitle)
            .rotationEffect(.degrees(gearRotationAngle))
            .rotationEffect(isAnimateGear ? .degrees(0) : .degrees(-360))
            .animation(gearAnimation2, value: isAnimateGear)
            .offset(gearOffset)
            .animation(gearAnimation, value: isShowingSettingsGear)
            .foregroundColor(Color(hex: "C9C9C9").opacity(1.0))
    }
    
    private var avatar: some View {
        ZStack {
            Circle()
                .frame(width: 55, height: 55)
                .background(.ultraThinMaterial)
                .clipShape(Circle())

        Circle()
            .frame(width: 60, height: 60)
            .foregroundColor(Color(hex: titleColour).opacity(0.5))
            .shadow(color: .black, radius: 4)
            .overlay(
                Group {
                    if let image = creatorImage {
                        Image(uiImage: image)
                            .resizable()
                            .cornerRadius(100)
                            .frame(width: 55, height: 55)
                    } else {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 55)
                            .foregroundColor(.black)
                            .opacity(0.5)
                    }
                }
            )
    }
        .onTapGesture {
            
            SettingsManager.toggleSettingsGear(gearRotationAngle: &gearRotationAngle, isShowingSettingsGear: &isShowingSettingsGear, isShowingSettings: &isShowingSettings)
            
            feedback()
        }
    }
}

func feedback() {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
}

struct GearIconView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environment(\.sizeCategory, .small)
            .environment(\.colorScheme, .dark)
    }
}

