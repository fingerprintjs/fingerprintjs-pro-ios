//
//  FormField.swift
//  DemoSPM
//
//  Created by Petr Palata on 18.07.2022.
//

import SwiftUI

struct FormField<Content: View>: View {
    var label: String?
    var alignment: HorizontalAlignment = .leading
    var font: Font = .system(size: 13).bold()
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: alignment) {
            if let label = label {
                Text(label)
                    .font(font)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            
            content()
        }
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FormField(label: "Test") {
                Button("Test") {}
            }
            
            FormField(label: "This is a very long title that should be truncated somewhere along the way at the end") {
                Button("Test") {}
            }
        }
    }
        
}
