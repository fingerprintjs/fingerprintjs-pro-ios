//
//  LibraryConfigurationViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 14.07.2022.
//

import Combine
import FingerprintPro
import Foundation

final class LibraryConfigurationViewModel: ObservableObject {

    @Published var customDomain: String? = nil
    @Published var apiKey: String = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
    @Published var url: String = ""
    @Published var pickerState: RegionPickerViewModel = RegionPickerViewModel()
    @Published var client: FingerprintClientProviding? = nil
    @Published var extendedResponse: Bool = false

    private var cancellable = Set<AnyCancellable>()

    init() {
        pickerState
            .objectWillChange
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellable)
    }

    var hasValidConfiguration: Bool {
        return !apiKey.isEmpty
    }

    var showsCustomDomainField: Bool {
        if case .custom = pickerState.selectedRegion {
            return true
        }
        return false
    }
}
