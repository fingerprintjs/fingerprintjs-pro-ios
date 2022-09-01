//
//  SendRequestView.swift
//  DemoSPM
//
//  Created by Petr Palata on 31.08.2022.
//

import SwiftUI
import FingerprintPro

struct SendRequestView: View {
    @State var fingerprintClient: FingerprintClientProviding?
    
    var body: some View {
        VStack {
            if let client = fingerprintClient {
                ResponseDetailView(viewModel: FingerprintViewModel(client))
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
