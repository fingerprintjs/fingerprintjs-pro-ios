//
//  ContentView.swift
//  DemoSPM
//
//  Created by Petr Palata on 11.07.2022.
//

import SwiftUI
import FingerprintJSPro

struct LibraryConfigurationView: View {
    @StateObject var viewModel = LibraryConfigurationViewModel()
    
    var body: some View {
        VStack {
            RegionPickerView(pickerState: $viewModel.pickerState)
            
            if viewModel.showsCustomDomainField {
                TextField("Insert custom domain URL", text: $viewModel.url)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
            }
            
            Text(viewModel.pickerState.selectedRegion.humanReadable)
            TextField("API Key", text: $viewModel.apiKey)
                .disableAutocorrection(true)
            NavigationLink("Get Visitor ID") {
                ResponseDetailView()
            }.disabled(viewModel.hasValidConfiguration)
        }.padding()
    }
}

struct LibraryConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryConfigurationView()
    }
}

