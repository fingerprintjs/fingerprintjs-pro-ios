//
//  ContentView.swift
//  DemoSPM
//
//  Created by Petr Palata on 11.07.2022.
//

import SwiftUI
import FingerprintPro

struct LibraryConfigurationView: View {
    @ObservedObject var viewModel: LibraryConfigurationViewModel
    @State var showHelp: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Configuration").font(.system(.largeTitle))
            FormField(label: "Region") {
                RegionPickerView(pickerState: viewModel.pickerState)
            }
            
            FormField(label: "Extended Response") {
                HStack(alignment: .center) {
                    Toggle("", isOn: $viewModel.extendedResponse)
                        .tint(.orange)
                        .toggleStyle(.switch)
                        .frame(alignment: .leading)
                    
                    Button(action: {
                        showHelp = true
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    .alert("Extended response determines whether Fingerprint Pro requests additional metadata that shows the device's location.", isPresented: $showHelp) {
                        Button("Close") {
                            showHelp = false
                        }
                    }
                    .tint(.orange)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            customDomainField
            
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
            
            Button("Save") {
                let configuration = Configuration(
                    apiKey: viewModel.apiKey,
                    region: selectedRegion,
                    extendedResponseFormat: viewModel.extendedResponse
                )
                
                let client = FingerprintProFactory.getInstance(configuration)
                viewModel.client = client
            }
        }.padding().frame(alignment: .top)
    }
    
    var detailView: some View {
        let configuration = Configuration(
            apiKey: viewModel.apiKey,
            region: selectedRegion,
            extendedResponseFormat: true
        )
        
        let client = FingerprintProFactory.getInstance(configuration)
        return ResponseDetailView(viewModel: FingerprintViewModel(client))
    }
    
    private var selectedRegion: Region {
        let pickerRegion = viewModel.pickerState.selectedRegion
        if case .custom = pickerRegion {
            return .custom(domain: viewModel.url)
        }
        return pickerRegion
    }
    
    @ViewBuilder private var customDomainField: some View {
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
        
    }
}

/*
 struct LibraryConfigurationView_Previews: PreviewProvider {
 static var previews: some View {
 LibraryConfigurationView()
 }
 }
 */

