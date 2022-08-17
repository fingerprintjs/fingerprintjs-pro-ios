//
//  ContentView.swift
//  DemoXCFramework
//
//  Created by Petr Palata on 03.08.2022.
//

import SwiftUI
import FingerprintPro

struct ContentView: View {
    @State var visitorId = "No visitor ID"
    
    var body: some View {
        Text(visitorId)
            .padding()
            .task {
                do {
#error("Insert API Key")
                    let apiKey = "<your-api-key>"
                    let client = FingerprintProFactory.getInstance(apiKey)
                    visitorId = try await client.getVisitorId()
                } catch {
                    // handle error
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
