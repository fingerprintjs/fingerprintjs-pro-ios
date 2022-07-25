//
//  IPLocationView.swift
//  DemoSPM
//
//  Created by Petr Palata on 14.07.2022.
//

import SwiftUI
import FingerprintJSPro
import MapKit

struct IPLocationView: View {
    @State private var internalMapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    private var ipLocation: IPLocation
    private var userCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    init(_ ipLocation: IPLocation) {
        self.ipLocation = ipLocation
        
        if let latitude = ipLocation.latitude, let longitude = ipLocation.longitude {
            let userLocation = CLLocationCoordinate2D(
                latitude: CLLocationDegrees(latitude),
                longitude: CLLocationDegrees(longitude)
            )
            
            self.userCoordinates = userLocation

            let region = MKCoordinateRegion(
                center: userLocation,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.3,
                    longitudeDelta: 0.3
                )
            )
            
            self._internalMapRegion = State(initialValue: region)
        }
    }
    
    var body: some View {
        FormField(label: "Visitor Location") {
            Map(
                coordinateRegion: $internalMapRegion,
                annotationItems: [
                    ipLocation
                ],
                annotationContent: { _ in
                    MapPin(coordinate: self.userCoordinates, tint: .red)
                }
            )
            .frame(maxHeight: 400)
            .cornerRadius(10)
            .allowsHitTesting(false)
        }
        .padding(.horizontal)
    }
}
