//
//  MetadataView.swift
//  DemoSPM
//
//  Created by Petr Palata on 01.09.2022.
//

import SwiftUI

struct MetadataView: View {
    @ObservedObject private var viewModel: MetadataViewModel
    
    init(_ viewModel: MetadataViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            FormField(label: "LinkedId") {
                TextField("LinkedId", text: $viewModel.linkedId)
            }
        }
        .navigationTitle("Edit Metadata")
        // .toolbar { ToolbarItem(label: "Save", content: <#() -> _#>, placement:  .navigationBarTrailing) {
        // }
    }
}

struct MetadataView_Previews: PreviewProvider {
    static var previews: some View {
        MetadataView(MetadataViewModel())
    }
}
