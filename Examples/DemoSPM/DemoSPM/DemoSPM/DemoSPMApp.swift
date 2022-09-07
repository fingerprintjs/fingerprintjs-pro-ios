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
    @StateObject var metadataViewModel = MetadataViewModel()
    @State private var currentTab: Int = 0
    @State private var previousTab: Int = 0
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 0) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 40)
                    .padding(.top, 16)
                
                TabView(selection: $currentTab) {
                    LibraryConfigurationView(viewModel: configurationViewModel, onSave: {
                        currentTab = 1
                    }).tabItem {
                        VStack {
                            Image(systemName: "slider.vertical.3")
                            Text("Configure")
                        }
                    }
                    .tag(0)
                    
                    SendRequestView(
                        fingerprintClient: configurationViewModel.client,
                        metadataViewModel: metadataViewModel
                    ).tabItem() {
                        VStack {
                            Image(systemName: "message").tint(.black)
                            Text("Identify")
                        }
                    }
                    .tag(1)
                    
                    PrivacyPolicyView()
                    .tabItem() {
                        VStack {
                            Image(systemName: "paragraph").tint(.black)
                            Text("Policy")
                        }
                    }
                }
                .accentColor(.fingerprintRed)
                .onChange(of: currentTab) { _ in
                    if currentTab == 1 && configurationViewModel.client == nil {
                        currentTab = 0
                    }
                }
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
