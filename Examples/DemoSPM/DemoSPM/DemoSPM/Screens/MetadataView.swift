//
//  MetadataView.swift
//  DemoSPM
//
//  Created by Petr Palata on 01.09.2022.
//

import SwiftUI

struct MetadataView: View {
    @ObservedObject private var viewModel: MetadataViewModel
    @State private var showLinkedIdHelp = false
    
    init(_ viewModel: MetadataViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            FormField(label: Strings.linkedId) {
                HStack {
                    UnformattedStringTextField("Insert Linked ID value", text: $viewModel.linkedId)
                    Button(action: {
                        showLinkedIdHelp = true
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                    .alert(
                        Strings.linkedId,
                        isPresented: $showLinkedIdHelp,
                        actions: {},
                        message: { Text(Strings.linkedIDHelpMessage) }
                    )
                }
            }
            .padding(.bottom, 16)
            
            FormField(label: "Tags") {
                TagEditorView(tags: $viewModel.tags).padding(.horizontal, -16).padding(.top, -8)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Edit Metadata")
    }
}

struct MetadataView_Previews: PreviewProvider {
    static var previews: some View {
        MetadataView(MetadataViewModel())
    }
}
