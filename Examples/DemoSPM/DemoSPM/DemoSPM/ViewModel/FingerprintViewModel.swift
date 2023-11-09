//
//  FingerprintViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 17.07.2022.
//

import Combine
import FingerprintPro

final class FingerprintViewModel: ObservableObject {

    var client: FingerprintClientProviding
    var metadata: Metadata

    @Published private(set) var response: FingerprintResponse?
    @Published private(set) var error: FPJSError?
    @Published private(set) var loading: Bool?

    init(_ client: FingerprintClientProviding, metadata: Metadata) {
        self.client = client
        self.metadata = metadata
    }

    func fetchResponse() async {
        await MainActor.run {
            loading = true
        }
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
