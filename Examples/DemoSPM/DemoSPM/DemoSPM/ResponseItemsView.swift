//
//  ResponseItemsView.swift
//  DemoSPM
//
//  Created by Petr Palata on 19.07.2022.
//

import FingerprintPro
import SwiftUI

struct ResponseItemsView: View {

    var response: FingerprintResponse

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                FormField(label: "Your Visitor ID", font: .system(size: 25)) {
                    Text(response.visitorId)
                        .font(.system(size: 18).monospaced())
                        .foregroundStyle(colorScheme == .light ? .black : .white)
                }
                .padding(.horizontal)
                .padding(.bottom)
                .foregroundColor(.fingerprintRed)

                FormField(label: "Confidence") {
                    confidencePercentageText
                }
                .padding(.horizontal)
                .padding(.bottom)

                timestampFields
                    .padding(.horizontal)
                    .padding(.bottom)

                if let ipAddress = response.ipAddress {
                    FormField(label: "IP Address") {
                        Text(ipAddress)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                }

                if let ipLocation = response.ipLocation {
                    IPLocationView(ipLocation)
                        .frame(minHeight: 450)
                }
            }
        }
    }

    @ViewBuilder private var timestampFields: some View {
        HStack {
            if let firstSeen = response.firstSeenAt?.global {
                FormField(label: "First seen") {
                    formattedTimestamp(firstSeen)
                }
            }
            Spacer()
            if let lastSeen = response.lastSeenAt?.global {
                FormField(label: "Last seen") {
                    formattedTimestamp(lastSeen)
                }
            }
        }
    }

    private var confidencePercentageText: Text {
        let percentConfidence = response.confidence
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.numberStyle = .percent
        guard let percentage = numberFormatter.string(from: percentConfidence as NSNumber) else {
            return Text("N/A").foregroundColor(.gray).font(.system(size: 12))
        }
        return Text(percentage).foregroundColor(.gray).font(.system(size: 12))
    }

    private func formattedTimestamp(_ timestamp: Date) -> Text {
        let formattedTimestamp = timestamp.formatted(date: .abbreviated, time: .shortened)
        return Text(formattedTimestamp)
            .font(.system(size: 13))
            .foregroundColor(.gray)
    }
}
