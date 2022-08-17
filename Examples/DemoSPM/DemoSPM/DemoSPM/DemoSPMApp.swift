//
//  DemoSPMApp.swift
//  DemoSPM
//
//  Created by Petr Palata on 11.07.2022.
//

import SwiftUI
import FingerprintPro

@main
struct DemoSPMApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LibraryConfigurationView()
            }
        }
    }
}
