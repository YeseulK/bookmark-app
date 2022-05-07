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

struct FolderView: View {
    var folder: FolderDto
    @State var bookmarks: [BookmarkDto] = []
        
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 12) {
                Text(folder.title)
                    .font(.headline)
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
    var body: some View {
            NavigationView {
                List {
                  HStack {
                    Text("북마크")
                        .font(.headline)
                  }
                  ForEach(folders, id: \.self)
                    { folder in
                    NavigationLink(destination: FolderView(folder: folder)
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

