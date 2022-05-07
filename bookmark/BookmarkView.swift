//
//  BookmarkView.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import SwiftUI

struct Bookmark: Hashable, Identifiable {
    var id = UUID()
    var title: String
    var url: String
}

struct BookmarkView: View {
    @State var bookmark: Bookmark
    
    var body: some View {
        Link(bookmark.title, destination: URL(string: bookmark.url)!)
    }
}

//struct BookmarkView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkView()
//    }
//}
