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
        VStack(spacing: 20) {
            FormField(label: "Region") {
                RegionPickerView(pickerState: viewModel.pickerState)
            }
            
            if viewModel.showsCustomDomainField {
                FormField(label: "URL") {
                    TextField("Insert custom domain URL", text: $viewModel.url)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.orange, lineWidth: 2))
                }
            }
            
            VStack(alignment: .leading) {
                FormField(label: "API Key") {
                    TextField("API Key", text: $viewModel.apiKey)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .background(RoundedRectangle(cornerRadius: 10).stroke(.orange, lineWidth: 2))
                }
            }
            NavigationLink("Get Visitor ID") {
                detailView
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.orange)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .disabled(!viewModel.hasValidConfiguration)
            .padding(.top, 16)
        }.padding()
    }
    
    var detailView: some View {
        ResponseDetailView(
            viewModel: FingerprintViewModel(
                FingerprintJSProFactory.getInstance(viewModel.apiKey, region: selectedRegion)
            )
        )
    }
    
    private var selectedRegion: Region {
        let pickerRegion = viewModel.pickerState.selectedRegion
        if case .custom = pickerRegion {
            return .custom(domain: viewModel.url)
        }
        return pickerRegion
    }
}

struct LibraryConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryConfigurationView()
    }
}

