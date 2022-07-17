//
//  RegionPickerView.swift
//  DemoSPM
//
//  Created by Petr Palata on 12.07.2022.
//

import SwiftUI
import FingerprintJSPro

struct RegionPickerView: View {
    @Binding var pickerState: RegionPickerViewModel
    @State var selecting: Bool = false
    
    var body: some View {
        HStack {
            Text(currentRegionString)
            Button("Change Region") {
                selecting = !selecting
            }
        }.confirmationDialog("Select Region", isPresented: $selecting) {
            ForEach(Region.allCases) { region in
                Button(region.humanReadable) {
                    self.pickerState.selectedRegion = region
                }
            }
        }
    }
    
    private var currentRegionString: String {
        return pickerState.selectedRegion.humanReadable
    }
}

/*
struct RegionPickerView_Previews: PreviewProvider {
    static var previews: some View {
        RegionPickerView(pickerState: RegionPickerState())
    }
}
 */

// MARK: - Region Extensions
extension Region: CaseIterable, Identifiable {
    public static var allCases: [Region] {
        return [.global, .ap, .eu, .custom(domain: "")]
    }
    
    public var id: String { self.humanReadable }
    
    var humanReadable: String {
        switch self {
        case .global: return "Global"
        case .ap: return "Asia/Pacific"
        case .eu: return "Europe"
        case .custom(_): return "Custom Domain"
        @unknown default:
            return "Unknown"
        }
    }
}
