//
//  UnformattedStringTextField.swift
//  DemoSPM
//
//  Created by Petr Palata on 06.09.2022.
//

import SwiftUI

struct UnformattedStringTextField: View {

    private let leftRightPadding = 12.0

    private var label: String
    private var text: Binding<String>

    init(_ label: String, text: Binding<String>) {
        self.label = label
        self.text = text
    }

    var body: some View {
        TextField(label, text: self.text)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding(.horizontal)
            .padding(.vertical, leftRightPadding)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.fingerprintRed, lineWidth: 2)
            )
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
    }
}

struct UnformattedStringTextField_Previews: PreviewProvider {

    struct Example: View {

        @State private var text: String = ""

        var body: some View {
            UnformattedStringTextField("TestLabel", text: $text)
        }
    }

    static var previews: some View {
        Example()
    }
}
