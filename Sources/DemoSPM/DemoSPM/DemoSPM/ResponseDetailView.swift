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
            
            HStack {
                Button("Get Visitor ID") {
                    Task.init {
                        await viewModel.fetchResponse()
                    }
                }
                .disabled(viewModel.loading)
                
                if viewModel.loading {
                    ProgressView()
                }
            }
        }
    }
    
    @ViewBuilder var content: some View {
        if let response = viewModel.response {
            Text(response.visitorId)
            if let ipLocation = response.ipLocation {
                IPLocationView(ipLocation)
            }
        } else if let error = viewModel.error {
            Text(error.description)
        } else {
            ProgressView()
        }
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
