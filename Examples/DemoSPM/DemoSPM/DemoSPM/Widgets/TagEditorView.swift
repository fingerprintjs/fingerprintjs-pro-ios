//
//  TagEditorView.swift
//  DemoSPM
//
//  Created by Petr Palata on 06.09.2022.
//

import SwiftUI
import FingerprintPro

struct TagEditorView: View {
    @Binding var tags: [(key: String, value: JSONTypeConvertible)]
    @State private var isEditingNewTag = false
    @State private var editedTagKey = ""
    @State private var valueType = 0
    @State private var jsonValue: JSONTypeConvertible? = nil
    @State private var boolValue: Bool = false
    @State private var stringValue: String = ""
    @State private var integerValue: Int = 0
    @State private var doubleValue: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(zip(tags.indices, tags)), id: \.0) { index, tuple in
                HStack {
                    FormField(label: tuple.key) {
                        Text("\(tuple.value.asJSONType().description)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Button(action: {
                        tags.remove(at: index)
                    }, label: {
                        Image(systemName: "trash").tint(.fingerprintRed)
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            
            if isEditingNewTag {
                HStack {
                    VStack {
                        FormField(label: "Tag Key") {
                            UnformattedStringTextField("Tag Key", text: $editedTagKey)
                        }
                        
                        FormField(label: "Type") {
                            Picker("Value Type", selection: $valueType, content: {
                                Text("Boolean").tag(0)
                                Text("Int").tag(1)
                                Text("Double").tag(2)
                                Text("String").tag(3)
                            })
                            .pickerStyle(.segmented)
                            

                        }
                        
                        FormField(label: "Value") {
                            valueInputView
                        }
                    }
                     
                        
                    VStack(alignment: .center, spacing: 30) {
                            Button(action: {
                                tags.append((key: editedTagKey, value: jsonTypeValue))
                                stopEditing()
                            }, label: {
                                Image(systemName: "checkmark").imageScale(.large)
                            }).tint(.fingerprintRed)
                            
                            Button(action: {
                                stopEditing()
                            }, label: {
                                Image(systemName: "trash").imageScale(.large)
                            }).tint(.fingerprintRed)
                    }.padding(.leading, 16)
                }
                .padding()
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
            } else {
                Button(action: {
                    isEditingNewTag = true
                }, label: {
                    Text("Add tag")
                })
                .padding()
                .tint(.fingerprintRed)
            }
        }
    }
    
    private func stopEditing() {
        isEditingNewTag = false
        editedTagKey = ""
        boolValue = false
        stringValue = ""
        integerValue = 0
        doubleValue = 0
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

struct TagEditorView_Previews: PreviewProvider {
    struct Example: View {
        @State var tags: [TagTuple] = [
            (key: "Test", value: 10)
        ]
        
        var body: some View {
            TagEditorView(tags: $tags)
        }
    }
    
    static var previews: some View {
        TagEditorView_Previews.Example()
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
