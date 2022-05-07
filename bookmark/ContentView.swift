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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

