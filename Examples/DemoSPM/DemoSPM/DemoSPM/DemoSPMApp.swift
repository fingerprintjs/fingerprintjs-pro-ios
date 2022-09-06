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
            VStack(spacing: 0) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 40)
                    .padding(.top, 16)
                TabView {
                    LibraryConfigurationView(viewModel: configurationViewModel).tabItem {
                        VStack {
                            Image(systemName: "slider.vertical.3")
                            Text("Configure")
                        }
                    }.tint(.fingerprintRed)
                    SendRequestView(fingerprintClient: configurationViewModel.client).tabItem {
                        VStack {
                            Image(systemName: "message")
                            Text("Identify")
                        }
                    }
                }
                .accentColor(.fingerprintRed)
            }
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundColor = .white
                
                // Use this appearance when scrolling behind the TabView:
                UITabBar.appearance().standardAppearance = appearance
                // Use this appearance when scrolled all the way up:
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}
