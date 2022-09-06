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
            FormField(label: "Linked ID") {
                HStack {
                    TextField("", text: $viewModel.linkedId)
                    Button(action: {
                        showLinkedIdHelp = true
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                }
            }
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
