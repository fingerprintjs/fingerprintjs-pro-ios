//
//  ContentView.swift
//  DemoSPM
//
//  Created by Petr Palata on 11.07.2022.
//

import SwiftUI
import FingerprintJSPro

struct LibraryConfigurationView: View {
    var body: some View {
        RegionPickerView()
    }
}

struct RegionPickerView: View {
    @State var selectedRegion: Region = .global
    @State var selecting: Bool = false
    var body: some View {
        HStack {
            Text(selectedRegion.humanReadable)
            Button("Change Region") {
                selecting = !selecting
            }
        }.confirmationDialog("Select Region", isPresented: $selecting) {
            ForEach(Region.allCases) { region in
                Button(region.humanReadable) { self.selectedRegion = region }
            }
        }
    }
}

struct LibraryConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryConfigurationView()
    }
}


extension Region: CaseIterable, Identifiable {
    public static var allCases: [Region] {
        return [.global, .ap, .eu, .custom(domain: "custom domain")]
    }
    
    public var id: String { self.humanReadable }
    
    var humanReadable: String {
        switch self {
        case .global: return "Global"
        case .ap: return "Asia/Pacific"
        case .eu: return "Europe"
        case .custom(let domain): return "Domain: \(domain)"
        @unknown default:
            return "Unknown"
        }
    }
}
