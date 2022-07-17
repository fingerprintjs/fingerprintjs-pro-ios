//
//  FingerprintViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 17.07.2022.
//

import Foundation
import FingerprintJSPro
import MapKit

class FingerprintViewModel: ObservableObject {
    let client: FingerprintJSClientProviding
    
    @Published var response: FingerprintResponse?
    @Published var error: FPJSError?
    @Published var loading: Bool = true
    
    var mapRegion = MKCoordinateRegion()
    
    init(_ client: FingerprintJSClientProviding) {
        self.client = client
    }
    
    func fetchResponse() async {
        loading = true
        do {
            let response = try await client.getVisitorIdResponse(true)
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
