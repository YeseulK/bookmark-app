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
    @Environment(\.openURL) private var openURL
    @StateObject var vm: LinkViewModel
    @State var memoText: String = ""
    
    var body: some View {
        HStack {
            MetaImageView(imageUrl: vm.metadata?[.image] ?? "").frame(width: 60, height: 30, alignment: .center).padding().contextMenu {
                Button {
                    print("\(vm.metadata?[.url] ?? vm.strUrl)")
                } label: {
                    Label("삭제", systemImage: "delete")
                }
            }.onTapGesture {
                openURL(URL(string: vm.strUrl)!)
            }
            VStack {
                Text(vm.metadata?[.title] ?? vm.strUrl).style(.title).alignment(.leading)
                Text(vm.metadata?[.description] ?? "").style(.description).alignment(.leading)
                Text(vm.metadata?[.url] ?? vm.strUrl).style(.url).alignment(.leading)
            }.onTapGesture {
                openURL(URL(string: vm.strUrl)!)
            }
            TextEditor(text: $memoText).frame(width: 120, height: 70, alignment: .leading)
        }
        .padding()
    }
}

struct MetaImageView: View {
    var imageUrl: String = ""
    
    var body: some View {
        if let url = URL(string: imageUrl) {
            URLImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        } else {
            Image(systemName: "book")
        }
    }
}

//struct MetaTextView: View {
//    var text: String = ""
//    var optText: String = ""
//
//    var body: some View {
//
//    }
//}
