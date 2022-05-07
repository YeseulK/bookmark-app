//
//  ContentView.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/5/22.
//

import SwiftUI

struct ContentView: View {
    @State var folders: [FolderDto] = []
    @State private var showingAlert = false
    @State var textFieldTitle: String = ""
    
    var body: some View {
            NavigationView {
                List {
                  HStack {
                    Text("북마크")
                        .font(.headline)
                    Button(action: {
                        FolderApi().postFolder(title: textFieldTitle) {
                            // TODO:
                            // folders.append(FolderDto(id: 0, title: textFieldTitle, bookmarks: []))
                        }
                        textFieldTitle = ""
                    }) {
                        Text("추가")
                    }
                  }
                    HStack {
                        Text("이름:")
                        TextField("Enter title", text: $textFieldTitle)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

