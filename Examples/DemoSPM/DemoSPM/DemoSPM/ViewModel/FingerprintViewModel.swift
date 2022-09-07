//
//  FingerprintViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 17.07.2022.
//

import Foundation
import FingerprintPro
import MapKit

class FingerprintViewModel: ObservableObject {
    var client: FingerprintClientProviding
    var metadata: Metadata
    
    @Published var response: FingerprintResponse?
    @Published var error: FPJSError?
    @Published var loading: Bool? = nil
    
    var mapRegion = MKCoordinateRegion()
    
    init(_ client: FingerprintClientProviding, metadata: Metadata) {
        self.client = client
        self.metadata = metadata
    }
    
    func fetchResponse() async {
        loading = true
        do {
            let response = try await client.getVisitorIdResponse(metadata)
            await MainActor.run {
                self.response = response
                self.loading = false
            }
        } catch let fpjsError {
            await MainActor.run {
                self.error = fpjsError as? FPJSError
                self.loading = false
            }
        }
    }
}
