//
//  ResponseDetailView.swift
//  DemoSPM
//
//  Created by Petr Palata on 14.07.2022.
//

import SwiftUI
import FingerprintJSPro
import MapKit

struct ResponseDetailView: View {
    @StateObject var viewModel: FingerprintViewModel
    
    var body: some View {
        VStack {
            content.task {
                await viewModel.fetchResponse()
            }
            
            Spacer()
            HStack {
                Button("Get Visitor ID") {
                    Task.init {
                        await viewModel.fetchResponse()
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .disabled(viewModel.loading)
                .padding()
                .padding(.top, 16)
                
                if viewModel.loading {
                    ProgressView()
                }
            }
        }.navigationTitle("Response")
    }
    
    @ViewBuilder var content: some View {
        Spacer()
        if viewModel.loading {
            ProgressView()
        } else if let response = viewModel.response {
            ResponseItemsView(response: response)
        } else if let error = viewModel.error {
            Text(error.description)
        }
        Spacer()
    }
}

extension IPLocation: Identifiable {
    public var id: String {
        self.postalCode!
    }
}

/*
struct ResponseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseDetailView(response: )
    }
}
 */
