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
    @ObservedObject var configurationViewModel = LibraryConfigurationViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                LibraryConfigurationView(viewModel: configurationViewModel).tabItem {
                    VStack {
                        Image(systemName: "slider.vertical.3")
                        Text("Config")
                    }
                }
                SendRequestView(fingerprintClient: configurationViewModel.client).tabItem {
                    VStack {
                        Image(systemName: "message")
                        Text("Identify")
                    }
                }
            }
        }
    }
}
