//
//  TagRow.swift
//  DemoSPM
//
//  Created by Petr Palata on 07.09.2022.
//

import SwiftUI
import FingerprintPro

struct TagRow: View {

    let tag: TagTuple
    let deleteAction: () -> Void

    var body: some View {
        HStack {
            FormField(
                label: tag.key,
                font: .system(size: 15, weight: .bold, design: .default)
            ) {
                Text("\(tag.value.asJSONType().description)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))

            Button(
                action: deleteAction,
                label: {
                    Image(systemName: "trash")
                        .tint(.fingerprintRed)
                }
            )
        }
        .frame(maxWidth: .infinity)
    }
}

struct TagRow_Previews: PreviewProvider {

    static var previews: some View {
        VStack(spacing: 10) {
            TagRow(tag: (key: "Test", value: false), deleteAction: {})
            TagRow(tag: (key: "Lama", value: false), deleteAction: {})
            TagRow(tag: (key: "Very very very long text that is supposed to test truncation", value: false), deleteAction: {})
            TagRow(tag: (key: "Test", value: false), deleteAction: {})
        }
    }
}

extension JSONType: CustomStringConvertible {

    public var description: String {
        switch self {
        case .array(let array):
            return "\(array)"
        case .int(let int):
            return "\(int)"
        case .double(let double):
            return "\(double)"
        case .string(let string):
            return string
        case .bool(let bool):
            return "\(bool)"
        case .null:
            return "null"
        case .object(let object):
            return "\(object.description)"
        @unknown default:
            return "<type not found>"
        }
    }
}
