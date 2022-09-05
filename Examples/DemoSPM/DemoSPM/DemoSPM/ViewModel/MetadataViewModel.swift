//
//  MetadataViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 01.09.2022.
//

import Foundation
import FingerprintPro

class MetadataViewModel: ObservableObject {
    @Published var tags: [String: JSONTypeConvertible] = [:]
    @Published var linkedId: String = ""
    @Published var showTagDialog: Bool = false
    
    var metadata: Metadata {
        var metadata = Metadata(linkedId: linkedId)
        tags.forEach { key, tag in
            metadata.setTag(tag, forKey: key)
        }
        return metadata
    }
}
