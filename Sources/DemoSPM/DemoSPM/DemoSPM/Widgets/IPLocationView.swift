//
//  IPLocationView.swift
//  DemoSPM
//
//  Created by Petr Palata on 14.07.2022.
//

import SwiftUI
import FingerprintJSPro

struct IPLocationView: View {
    @State var ipLocation: IPLocation
    
    var body: some View {
        Text(ipLocation.country?.name ?? "No IP location")
    }
}

/*
struct IPLocationView_Previews: PreviewProvider {
    static var previews: some View {
    }
}
*/
