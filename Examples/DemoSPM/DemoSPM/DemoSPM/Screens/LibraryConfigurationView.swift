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
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                VStack {
                    FormField(label: "Region") {
                        RegionPickerView(pickerState: viewModel.pickerState)
                    }.padding(.bottom, 10)
                    
                    customDomainField.padding(.bottom, 10)
                    
                    FormField(label: "Extended Response") {
                        HStack(alignment: .center) {
                            Toggle(isOn: $viewModel.extendedResponse) {
                                
                            }
                            .toggleStyle(.switch)
                            .tint(.fingerprintRed)
                            
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
                            .tint(.fingerprintRed)
                        }
                    }
                    
                    FormField(label: "API Key") {
                        UnformattedStringTextField("API Key", text: $viewModel.apiKey)
                    }
                    .padding(.top, 20)
                    
                    
                    Button(action: {
                        let configuration = Configuration(
                            apiKey: viewModel.apiKey,
                            region: selectedRegion,
                            extendedResponseFormat: viewModel.extendedResponse
                        )
                        
                        let client = FingerprintProFactory.getInstance(configuration)
                        viewModel.client = client
                    }, label: {
                        Text("Save")
                            .frame(maxWidth: .infinity, minHeight: 40)
                    })
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(.fingerprintRed)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 16)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Configure")
        }
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
            UnformattedStringTextField("URL", text: $viewModel.url)
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

