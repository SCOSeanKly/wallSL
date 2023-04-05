//
//  SettingsManager.swift
//  loadFromURL
//
//  Created by Sean Kelly on 04/04/2023.
//

import SwiftUI

class SettingsManager {
    static func toggleSettingsGear(gearRotationAngle: inout Double, isShowingSettingsGear: inout Bool, isShowingSettings: inout Bool) {
        withAnimation(.linear(duration: 0.5)) {
            gearRotationAngle += isShowingSettingsGear ? 180 : -180
            isShowingSettingsGear.toggle()
            isShowingSettings.toggle()
        }
    }
}

