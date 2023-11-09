//
//  MetadataViewModel.swift
//  DemoSPM
//
//  Created by Petr Palata on 01.09.2022.
//

import Combine
import FingerprintPro

typealias TagTuple = (key: String, value: JSONTypeConvertible)

final class MetadataViewModel: ObservableObject {

    @Published var tags: [TagTuple] = []
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
