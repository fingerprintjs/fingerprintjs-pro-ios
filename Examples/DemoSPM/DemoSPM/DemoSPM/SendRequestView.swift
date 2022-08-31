//
//  SendRequestView.swift
//  DemoSPM
//
//  Created by Petr Palata on 31.08.2022.
//

import SwiftUI
import FingerprintPro

struct SendRequestView: View {
    let fingerprintClient: FingerprintClientProviding?
    @State var visitorId: String = ""
    @State var visitorIdResponse: String = ""
    
    var body: some View {
        VStack {
            if let client = fingerprintClient {
                Button("Test") {
                    Task.init {
                        do {
                            self.visitorId = try await client.getVisitorId()
                            self.visitorIdResponse = try await client.getVisitorIdResponse().asJSON()
                        } catch {
                            self.visitorId = error.localizedDescription
                        }
                    }
                }
                if !visitorId.isEmpty {
                    VStack {
                        Text("Result").bold()
                        Text(visitorId)
                        Text(visitorIdResponse)
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
