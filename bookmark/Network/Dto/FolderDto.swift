//
//  FolderDto.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import Foundation

struct FolderDto: Decodable, Hashable {
    let id: Int
    let title: String
    let bookmarks: [BookmarkDto]
}
