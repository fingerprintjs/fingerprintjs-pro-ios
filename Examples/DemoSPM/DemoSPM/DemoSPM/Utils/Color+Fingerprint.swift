//
//  Color+Fingerprint.swift
//  DemoSPM
//
//  Created by Petr Palata on 05.09.2022.
//

import SwiftUI

extension Color {

    static var fingerprintRed: Color {
        .init("FingerprintRed")
    }
}

extension ShapeStyle where Self == Color {

    static var fingerprintRed: Color {
        Color.fingerprintRed
    }
}
