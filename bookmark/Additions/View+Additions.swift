//
//  View+Additions.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import SwiftUI

extension View {
    
    func alignment(_ type: Alignment) -> some View {
        return self.frame(minWidth: 0, idealWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: 0, maxHeight: .infinity, alignment: type)
    }
}
