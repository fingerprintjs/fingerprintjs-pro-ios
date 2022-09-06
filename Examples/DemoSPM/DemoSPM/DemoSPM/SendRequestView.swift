//
//  SendRequestView.swift
//  DemoSPM
//
//  Created by Petr Palata on 31.08.2022.
//

import SwiftUI
import FingerprintPro

struct SendRequestView: View {
    var fingerprintClient: FingerprintClientProviding?
    
    var body: some View {
        NavigationView {
            VStack {
                if let client = fingerprintClient {
                    ResponseDetailView(viewModel: FingerprintViewModel(client))
                    NavigationLink(destination: MetadataView(MetadataViewModel())) {
                        HStack {
                            Text("Edit Metadata").accentColor(.fingerprintRed)
                            Image(systemName: "chevron.right").imageScale(.small)
                        }
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .padding(.bottom, 8)
                    }
                }
            }
        }
    }
}

/*
 struct SendRequestView_Previews: PreviewProvider {
 static var previews: some View {
 }
 }
 */
