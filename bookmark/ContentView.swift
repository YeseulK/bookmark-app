//
//  ContentView.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/5/22.
//

import SwiftUI

struct Bookmark: Hashable, Identifiable {
    var id = UUID()
    var title: String
    var url: String
}

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

struct ContentView: View {
    @State var folders: [FolderDto] = []
    @State private var showingAlert = false
    
    var body: some View {
            NavigationView {
                List {
                  HStack {
                    Text("북마크")
                        .font(.headline)
                    Button(action: {
                        self.showingAlert = true
                    }) {
                        Text("추가")
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Title"), message: Text("Message"), primaryButton: .destructive(Text("Primary"), action: {
                        }), secondaryButton: .cancel())
                    }
                  }
                  ForEach(folders, id: \.self)
                    { folder in
                    NavigationLink(destination: BookmarkListView(folder: folder)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    ) {
                        Text(folder.title)
                    }
                  }
                }.listStyle(SidebarListStyle())
            }.onAppear {
                FolderApi().getFolders() { result in
                    folders = result
                }
            }
    }
}

struct BookmarkView: View {
    @State var bookmark: Bookmark
    
    var body: some View {
        Link(bookmark.title, destination: URL(string: bookmark.url)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

