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
    var name: String
    @State var tasks = []
    @StateObject private var network = RequestApi.shared
        
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 12) {
                Text(name)
                    .font(.headline)
                ForEach(network.result, id: \.self) { result in
                    BookmarkView(bookmark: Bookmark(title: result.title, url:result.url))
                }
                
            }.onAppear {
                network.fetchData()
            }
        }
    }
}

struct ContentView: View {
    let folders = ["폴더1", "폴더2", "폴더3"]
    var body: some View {
            NavigationView {
                List {
                  HStack {
                    Text("북마크")
                        .font(.headline)
                  }
                  ForEach(folders, id: \.self)
                    { folder in
                        NavigationLink(destination: FolderView(name: folder)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        ) {
                            Text(folder)
                        }
                  }
                }.listStyle(SidebarListStyle())
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

