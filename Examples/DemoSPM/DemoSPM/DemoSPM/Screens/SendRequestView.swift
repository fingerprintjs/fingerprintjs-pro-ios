//
//  SendRequestView.swift
//  DemoSPM
//
//  Created by Petr Palata on 31.08.2022.
//

import FingerprintPro
import SwiftUI

struct SendRequestView: View {

    var fingerprintClient: FingerprintClientProviding?
    @ObservedObject var metadataViewModel: MetadataViewModel

    var body: some View {
        NavigationView {
            VStack {
                if let client = fingerprintClient {
                    ResponseDetailView(
                        viewModel: FingerprintViewModel(
                            client,
                            metadata: metadataViewModel.metadata
                        )
                    )
                    NavigationLink(destination: MetadataView(metadataViewModel)) {
                        HStack {
                            Text("Edit Metadata").tint(.fingerprintRed)
                            Image(systemName: "chevron.right").imageScale(.small)
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .padding(.bottom, 8)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
