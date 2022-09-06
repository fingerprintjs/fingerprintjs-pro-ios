//
//  ResponseDetailView.swift
//  DemoSPM
//
//  Created by Petr Palata on 14.07.2022.
//

import SwiftUI
import FingerprintPro
import MapKit

struct ResponseDetailView: View {
    @ObservedObject var viewModel: FingerprintViewModel
    
    var body: some View {
        VStack {
            content
            HStack {
                Button(action: {
                    Task.init {
                        await viewModel.fetchResponse()
                    }
                }, label: {
                    Text("Get Visitor ID").frame(maxWidth: .infinity, minHeight: 40)
                })
                .frame(maxWidth: .infinity, minHeight: 60)
                .tint(.fingerprintRed)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.loading ?? false)
                .padding(.top, 16)
                .padding(.horizontal)
            }
        }
        .navigationTitle("Identify")
    }
    
    @ViewBuilder var content: some View {
        Spacer()
        if let loading = viewModel.loading, loading {
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
