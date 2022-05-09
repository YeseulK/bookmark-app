//
//  BookmarkDto.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import Foundation

struct BookmarkDto: Decodable, Hashable {
    let id: Int
    let memo: String
    let url: String
}
