//
//  TagEditorView.swift
//  DemoSPM
//
//  Created by Petr Palata on 06.09.2022.
//

import SwiftUI
import FingerprintPro

struct TagEditorView: View {
    @Binding var tags: [TagTuple]
    @State private var tag: TagTuple?
    @State private var editing = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if editing {
                    TagEditorCardView(tag: $tag, editing: $editing)
                } else {
                    Button(action: {
                        editing = true
                    }, label: {
                        Text("Add Tag")
                            .frame(maxWidth: .infinity, minHeight: 40)
                    })
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(.fingerprintRed)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical, 16)
                }
                
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
                    .padding(.bottom, 8)
                }
            }
            .frame(maxWidth: .infinity)
            .onChange(of: editing, perform: { newState in
                if let tag = self.tag {
                    tags.append(tag)
                    self.tag = nil
                }
            })
            .padding()
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
