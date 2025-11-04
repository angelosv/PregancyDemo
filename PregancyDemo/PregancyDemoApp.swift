//
//  PregancyDemoApp.swift
//  PregancyDemo
//
//  Created by Angelo Sepulveda on 04/11/2025.
//

import SwiftUI
import ReachuCore
import ReachuUI

@main
struct PregancyDemoApp: App {
    init() {
        // Load Reachu SDK configuration from reachu-config.json
        // This reads the config file with API key, theme colors, and settings
        
        // For testing: Force Germany (DE) instead of using device locale
        // Change this to test different countries
        let userCountry = "DE" // Force Germany for testing
        // let userCountry = Locale.current.region?.identifier ?? "US" // Use device locale
        
        print("🚀 [PregnancyDemo] Loading Reachu SDK configuration...")
        print("🌍 [PregnancyDemo] User country: \(userCountry)")
        ConfigurationLoader.loadConfiguration(userCountryCode: userCountry)
        print("✅ [PregnancyDemo] Reachu SDK configured successfully")
        print("🎨 [PregnancyDemo] Theme: \(ReachuConfiguration.shared.theme.name)")
        print("🔑 [PregnancyDemo] API Key: \(ReachuConfiguration.shared.apiKey.isEmpty ? "Not set" : "\(ReachuConfiguration.shared.apiKey.prefix(8))...")")
        print("🌍 [PregnancyDemo] Environment: \(ReachuConfiguration.shared.environment)")
        print("📊 [PregnancyDemo] SDK Enabled: \(ReachuConfiguration.shared.shouldUseSDK)")
        print("🌍 [PregnancyDemo] Current Language: \(ReachuLocalization.shared.language)")
        print("🌍 [PregnancyDemo] Available languages: \(ReachuConfiguration.shared.localizationConfiguration.translations.keys.joined(separator: ", "))")
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
