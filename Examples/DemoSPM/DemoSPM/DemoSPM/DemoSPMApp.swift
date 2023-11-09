//
//  DemoSPMApp.swift
//  DemoSPM
//
//  Created by Petr Palata on 11.07.2022.
//

import SwiftUI

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
                    .padding(.vertical, 16)

                TabView(selection: $currentTab) {
                    LibraryConfigurationView(
                        viewModel: configurationViewModel,
                        onSave: {
                            currentTab = 1
                        }
                    )
                    .tabItem {
                        Label("Configure", systemImage: "slider.vertical.3")
                    }
                    .tag(0)

                    if configurationViewModel.client != nil {
                        SendRequestView(
                            fingerprintClient: configurationViewModel.client,
                            metadataViewModel: metadataViewModel
                        )
                        .tabItem {
                            Label("Identify", systemImage: "message")
                        }
                        .tag(1)
                    }

                    PrivacyPolicyView()
                        .tabItem {
                            Label("Policy", systemImage: "paragraph")
                        }
                        .tag(2)
                }
                .tint(.fingerprintRed)
            }
        }
    }
}
