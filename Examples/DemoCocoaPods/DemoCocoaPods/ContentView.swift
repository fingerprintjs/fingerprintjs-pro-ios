//
//  ContentView.swift
//  DemoCocoaPods
//
//  Created by Petr Palata on 19.08.2022.
//

import SwiftUI
import FingerprintPro

struct ContentView: View {
    @State var message: String? = "Fetching..."
    var body: some View {
        Text(message ?? "").task {
            Task {
                do {
#error("Insert your public API Key")
                    let client = FingerprintProFactory.getInstance("<api-key>")
                    message = try await client.getVisitorId()
                } catch FPJSError.apiError(let apiError)  {
                    message = apiError.error?.message
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
