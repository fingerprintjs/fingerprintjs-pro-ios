//
//  RegionPickerView.swift
//  DemoSPM
//
//  Created by Petr Palata on 12.07.2022.
//

import SwiftUI
import FingerprintPro

struct RegionPickerView: View {
    @StateObject var pickerState: RegionPickerViewModel
    @State var selecting: Bool = false
    
    var body: some View {
        HStack {
            Text(currentRegionString)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.init(red: 0.8, green: 0.8, blue: 0.8)))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.orange, lineWidth: 2))
            
            Button("Change") {
                selecting = !selecting
            }
            .foregroundColor(.orange)
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
