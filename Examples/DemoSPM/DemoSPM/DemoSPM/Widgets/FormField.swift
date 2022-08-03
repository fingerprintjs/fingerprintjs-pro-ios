//
//  FormField.swift
//  DemoSPM
//
//  Created by Petr Palata on 18.07.2022.
//

import SwiftUI

struct FormField<Content: View>: View {
    var label: String?
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            if let label = label {
                Text(label)
                    .font(.system(size: 12).bold())
            }
            
            content()
        }
    }
}

struct FormField_Previews: PreviewProvider {
    static var previews: some View {
        FormField(label: "Test") {
            Button("Test") {}
        }
    }
}
