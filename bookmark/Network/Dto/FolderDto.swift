//
//  FolderDto.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import Foundation

struct FolderDto: Decodable, Hashable {
    let id: Int
    let name: String
    let bookmarks: [BookmarkDto]
}
