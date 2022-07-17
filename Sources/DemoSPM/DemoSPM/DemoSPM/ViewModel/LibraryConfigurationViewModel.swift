//
//  LibraryConfigurationViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 14.07.2022.
//

import Foundation
import FingerprintJSPro
import SwiftUI
import Combine

class LibraryConfigurationViewModel: ObservableObject {
    @Published var customDomain: String? = nil
    @Published var apiKey: String = ""
    @Published var url: String = ""
    @Published var pickerState: RegionPickerState = RegionPickerState()
    
    var pickerStateCancellable: AnyCancellable? = nil
    
    init() {
        pickerStateCancellable = pickerState.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    var hasValidConfiguration: Bool {
        NSLog(apiKey)
        return apiKey.isEmpty
    }
    
    var showsCustomDomainField: Bool {
        if case .custom = pickerState.selectedRegion {
            return true
        }
        return false
    }
}
