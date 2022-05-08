//
//  Text+Additions.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import Foundation
import SwiftUI

extension Text {
    
    enum MetaDataType {
        case title
        case description
        case url
    }

    func style(_ type: MetaDataType) -> some View {
        switch type {
        case .title:
            return self
                .font(.headline)
                .lineLimit(1)
        case .description:
            return self
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(1)
        case .url:
            return self
                .font(.subheadline)
                .foregroundColor(.blue)
                .lineLimit(1)
        }
    }
}
