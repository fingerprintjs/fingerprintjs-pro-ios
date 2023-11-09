//
//  TagEditorCardView.swift
//  DemoSPM
//
//  Created by Petr Palata on 07.09.2022.
//

import SwiftUI
import FingerprintPro

struct TagEditorCardView: View {

    @Binding var tag: TagTuple?
    @Binding var editing: Bool

    @State private var editedTagKey = ""
    @State private var valueType = 0
    @State private var boolValue: Bool = false
    @State private var stringValue: String = ""
    @State private var integerValue: Int = 0
    @State private var doubleValue: Double = 0.0

    var body: some View {
        HStack {
            VStack {
                FormField(label: "Tag Key") {
                    UnformattedStringTextField("Tag Key", text: $editedTagKey)
                }

                FormField(label: "Type") {
                    Picker("Value Type", selection: $valueType) {
                        Text("Boolean").tag(0)
                        Text("Int").tag(1)
                        Text("Double").tag(2)
                        Text("String").tag(3)
                    }
                    .pickerStyle(.segmented)
                }

                FormField(label: "Value") {
                    valueInputView
                }
            }

            VStack(alignment: .center, spacing: 70) {
                Button(
                    action: {
                        tag = (key: editedTagKey, value: jsonTypeValue)
                        stopEditing()
                    },
                    label: {
                        Image(systemName: "checkmark").imageScale(.large)
                    }
                )
                .tint(.fingerprintRed)
                .disabled(editedTagKey.isEmpty)

                Button(
                    action: {
                        stopEditing()
                    },
                    label: {
                        Image(systemName: "trash").imageScale(.large)
                    }
                )
                .tint(.fingerprintRed)
            }
            .padding(.leading, 16)
        }
        .padding()
        .background(.background)
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    private func stopEditing() {
        editedTagKey = ""
        boolValue = false
        stringValue = ""
        integerValue = 0
        doubleValue = 0
        valueType = 0
        editing = false
    }

    private var jsonTypeValue: JSONTypeConvertible {
        if valueType == 0 {
            return boolValue
        } else if valueType == 1 {
            return integerValue
        } else if valueType == 2 {
            return doubleValue
        } else if valueType == 3 {
            return stringValue
        } else {
            return stringValue
        }
    }

    @ViewBuilder private var valueInputView: some View {
        if valueType == 0 {
            HStack {
                Toggle("", isOn: $boolValue)
                    .tint(.fingerprintRed)
                    .labelsHidden()
                    .frame(height: 46)
                Spacer()
            }
            .frame(maxWidth: .infinity)
        } else if valueType == 1 {
            TextField(
                "Enter Integer Value",
                value: $integerValue,
                format: .number
            )
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.fingerprintRed, lineWidth: 2)
            )
        } else if valueType == 2 {
            TextField(
                "Enter Double/Float Value",
                value: $doubleValue,
                format: .number
            )
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.fingerprintRed, lineWidth: 2)
            )
        } else if valueType == 3 {
            UnformattedStringTextField("Insert String Value", text: $stringValue)
        }
    }
}

struct TagEditorCardView_Previews: PreviewProvider {

    struct Example: View {

        @State private var tag: TagTuple? = nil
        @State private var editing: Bool = true

        var body: some View {
            TagEditorCardView(tag: $tag, editing: $editing)
        }
    }

    static var previews: some View {
        TagEditorCardView_Previews.Example()
    }
}
