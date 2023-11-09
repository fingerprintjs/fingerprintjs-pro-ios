//
//  RegionPickerView.swift
//  DemoSPM
//
//  Created by Petr Palata on 12.07.2022.
//

import FingerprintPro
import SwiftUI

struct RegionPickerView: View {

    @StateObject var pickerState: RegionPickerViewModel
    @State var selecting: Bool = false

    var body: some View {
        HStack {
            Text(currentRegionString)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical, 13)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.fingerprintRed, lineWidth: 2)
                )
                .foregroundColor(.fingerprintRed)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    content: {
                        HStack {
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.fingerprintRed)
                                .padding()
                        }
                    }
                )
                .onTapGesture {
                    selecting = true
                }
        }.confirmationDialog("Select Region", isPresented: $selecting) {
            ForEach(Region.allCases) { region in
                Button(
                    action: {
                        self.pickerState.selectedRegion = region
                    },
                    label: {
                        Text(region.humanReadable)
                            .foregroundColor(.fingerprintRed)
                    }
                ).tint(.fingerprintRed)
            }
        }
    }

    private var currentRegionString: String {
        return pickerState.selectedRegion.humanReadable
    }
}

struct RegionPickerView_Previews: PreviewProvider {

    static var previews: some View {
        RegionPickerView(pickerState: RegionPickerViewModel())
    }
}

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
