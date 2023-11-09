//
//  RegionPickerViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 17.07.2022.
//

import Combine
import FingerprintPro

final class RegionPickerViewModel: ObservableObject {

    @Published var selectedRegion: Region

    init(_ selectedRegion: Region = .global) {
        self.selectedRegion = selectedRegion
    }
}
