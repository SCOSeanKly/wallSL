//
//  BundleInfo.swift
//  loadFromURL
//
//  Created by Sean Kelly on 03/04/2023.
//


import Foundation

extension Bundle {
    var appName: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    
    var appVersion: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    var buildNumber: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
