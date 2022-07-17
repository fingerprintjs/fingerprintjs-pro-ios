//
//  ResponseDetailView.swift
//  DemoSPM
//
//  Created by Petr Palata on 14.07.2022.
//

import SwiftUI
import FingerprintJSPro

struct ResponseDetailView: View {
    // @StateObject var ResponseDetailViewModel
    var response: FingerprintResponse?
    
    
    var body: some View {
        if let ipLocation = response?.ipLocation {
            IPLocationView(ipLocation: ipLocation)
        }
    }
}

/*
struct ResponseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseDetailView(response: )
    }
}
 */
