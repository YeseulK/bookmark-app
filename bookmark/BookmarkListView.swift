//
//  BookmarkListView.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import SwiftUI

struct BookmarkListView: View {
    var folder: FolderDto
    @State var bookmarks: [BookmarkDto] = []
    @State private var showingAlert = false
    @State var textFieldTitle: String = ""
    @State var textFieldUrl: String = ""
    
    var body: some View {
        List {
            HStack {
                Text(folder.title).font(.headline)
                Button(action: {
                    self.showingAlert = true
                    BookmarkApi().postBookmark(folderId: folder.id, title: textFieldTitle, strUrl: textFieldUrl) {
                        // TODO:
                        // bookmarks.append(BookmarkDto(id: ??, title: textFieldTitle, url: textFieldUrl))
                    }
                }) {
                    Text("추가")
                }
            }
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("주소:")
                    TextField("Enter url", text: $textFieldUrl)
                }
                HStack {
                    Text("이름:")
                    TextField("Enter title", text: $textFieldTitle)
                }
                ForEach(bookmarks, id: \.self) { result in
                    BookmarkView(bookmark: Bookmark(title: result.title, url:result.url))
                }
            }.onAppear {
                FolderApi().getFolder(folerId: folder.id) { result in
                    bookmarks = result.bookmarks
                }
            }
        }
    }
}

//struct BookmarkListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkListView()
//    }
//}
