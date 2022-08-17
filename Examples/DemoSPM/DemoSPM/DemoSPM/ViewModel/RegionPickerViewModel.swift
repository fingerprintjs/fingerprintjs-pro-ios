//
//  RegionPickerViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 17.07.2022.
//

import Foundation
import FingerprintPro

class RegionPickerViewModel: ObservableObject {
    @Published public var selectedRegion: Region
    
    init(_ selectedRegion: Region = .global) {
        self.selectedRegion = selectedRegion
    }
}

