//
//  GearAnimationManager.swift
//  loadFromURL
//
//  Created by Sean Kelly on 05/04/2023.
//

import SwiftUI

class GearAnimationManager {
    static func toggleSettingsGear(gearRotationAngle: inout Double, gearSavingAnimation: inout Bool) {
        withAnimation(.linear(duration: 0.5)) {
            gearRotationAngle += gearSavingAnimation ? 180 : -180
          
        }
    }
}
