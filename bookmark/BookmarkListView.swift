//
//  BookmarkListView.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import SwiftUI

struct BookmarkListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var folder: FolderDto
    @State var bookmarks: [BookmarkDto] = []
    @State var textFieldTitle: String = ""
    @State var textFieldUrl: String = ""
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    //                    Text(folder.title).font(.headline)
                    TextField("Enter url", text: $textFieldUrl).multilineTextAlignment(.trailing)
                    Button(action: {
                        if !textFieldUrl.isEmpty {
                            reqPostBookmark()
                            textFieldUrl = ""
                        }
                    }) {
                        Text("추가")
                    }
                }
                ForEach(bookmarks, id: \.self) { result in
                    BookmarkView(vm: LinkViewModel(link: result.url))
                }
            }.onAppear {
                reqGetFolder()
            }
        }
    }
    
    private func reqGetFolder() {
        FolderApi().getFolder(folerId: folder.id) { result in
            bookmarks = result.bookmarks
        }
    }
    
    private func reqPostBookmark() {
        BookmarkApi().postBookmark(folderId: folder.id, title: textFieldTitle, strUrl: textFieldUrl) {
            // TODO:
            // bookmarks.append(BookmarkDto(id: ??, title: textFieldTitle, url: textFieldUrl))
        }
    }
}

//struct BookmarkListView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkListView()
//    }
//}
