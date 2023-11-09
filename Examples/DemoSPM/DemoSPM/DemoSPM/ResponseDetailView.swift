//
//  ResponseDetailView.swift
//  DemoSPM
//
//  Created by Petr Palata on 14.07.2022.
//

import FingerprintPro
import SwiftUI

struct ResponseDetailView: View {

    @ObservedObject var viewModel: FingerprintViewModel

    var body: some View {
        VStack {
            content
            HStack {
                Button(
                    action: {
                        Task {
                            await viewModel.fetchResponse()
                        }
                    },
                    label: {
                        Text("Get Visitor ID")
                            .frame(maxWidth: .infinity, minHeight: 40)
                    }
                )
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

    @ViewBuilder private var content: some View {
        Spacer()
        if let loading = viewModel.loading, loading {
            ProgressView()
        } else if let response = viewModel.response {
            ResponseItemsView(response: response)
        } else if let error = viewModel.error {
            Text(error.description)
                .padding()
        }
        Spacer()
    }
}

extension IPLocation: Identifiable {

    public var id: String {
        self.postalCode!
    }
}
