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
    @State var textFieldUrl: String = ""
    
    var body: some View {
        List {
            HStack {
                // Text(folder.title).font(.headline)
                TextField("Enter url", text: $textFieldUrl).multilineTextAlignment(.trailing)
                Button(action: {
                    if !textFieldUrl.isEmpty {
                        // TODO: url validation check
                        reqPostBookmark()
                        textFieldUrl = ""
                    }
                }) {
                    Text("추가")
                }
            }
            ForEach(bookmarks, id: \.self) { result in
                BookmarkView(vm: LinkViewModel(link: result.url), memoText: result.memo)
            }
        }.onAppear {
            reqGetFolder()
        }
    }
    
    private func reqGetFolder() {
        FolderApi().getFolder(folerId: folder.id) { result in
            bookmarks = result.bookmarks
        }
    }
    
    private func reqPostBookmark() {
        bookmarks.append(BookmarkDto(id: 0, memo: "", url: textFieldUrl))
        BookmarkApi().postBookmark(folderId: folder.id, memo: "", strUrl: textFieldUrl) {
            // TODO:
            
        }
    }
}

//struct BookmarkListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkListView()
//    }
//}
