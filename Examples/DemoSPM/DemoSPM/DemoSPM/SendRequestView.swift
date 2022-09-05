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
                    NavigationLink("Edit Metadata") {
                        MetadataView(MetadataViewModel())
                    }
                    ResponseDetailView(viewModel: FingerprintViewModel(client))
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
