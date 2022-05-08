//
//  BookmarkView.swift
//  bookmark
//
//  Created by Yeseul Kim on 5/8/22.
//

import SwiftUI
//import LinkPresentation
import WebLinkPreview
import URLImage

struct Bookmark: Hashable, Identifiable {
    var id = UUID()
    var title: String
    var url: String
}


class LinkViewModel : ObservableObject {
    @Published var metadata: WebLinkMetadata?
    var strUrl: String = ""
    @State var imageData: Data = Data()
    
    init(link : String) {
        self.strUrl = link
        guard let url = URL(string: link) else {
            return
        }
        WebLinkMetadata(url: url) { webLinkMetadata, error in
            guard let webLinkMetadata = webLinkMetadata else {
                return
            }
            DispatchQueue.main.async {
                self.metadata = webLinkMetadata
            }
        }
    }
}


struct BookmarkView: View {
    @StateObject var vm : LinkViewModel
    @Environment(\.openURL) private var openURL
    
    var body: some View {
        HStack {
            ImageView(imageUrl: vm.metadata?[.image] ?? "").frame(width: 70, height: 70, alignment: .center).fixedSize()
            VStack {
                Text(vm.metadata?[.title] ?? vm.strUrl).fontWeight(.heavy).lineLimit(1)
                Text(vm.metadata?[.description] ?? "").lineLimit(2).font(.system(size: 11)).foregroundColor(.gray)
                Text(vm.metadata?[.url] ?? vm.strUrl).lineLimit(1).foregroundColor(.blue)
            }
        }.onHover(perform: { inside in
            if inside {
                NSCursor.crosshair.push()
            } else {
                NSCursor.pop()
            }
        })
        .onTapGesture {
            openURL(URL(string: vm.strUrl)!)
        }.padding()
    }
}

struct ImageView: View {
    var imageUrl: String = ""
    
    var body: some View {
        if let url = URL(string: imageUrl) {
            URLImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        } else {
            Image("")
        }
    }
}
