//
//  ContentView.swift
//  Cardless_Project
//
//  Created by Jonathan Green on 12/28/20.
//

import SwiftUI
import KingfisherSwiftUI

struct ContentView: View {
    @State private var results: [Photo] = []
    @State private var text = ""
    @State private var progress = 1.0
    @State private var shouldAnimate = false
    private var colors: [Color] = [.yellow, .purple, .green]

    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    func loadData() {
        FlickerAPI.search(text: text).observe { (result) in
            switch result {
            case .success(let photos):
                guard let photos = photos.results else {
                    return
                }
                DispatchQueue.main.async {
                    self.results = photos
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    var body: some View {
        TextField(
            "type something...",
            text: $text,
            onEditingChanged: { _ in print(text) },
            onCommit: { self.shouldAnimate = true; loadData()

            }
        ).padding(.top, 20).padding(.trailing, 20).padding(.leading, 20)
        ActivityIndicator(isAnimating: self.$shouldAnimate, style: .large)
        ScrollView {
            LazyVGrid(columns: gridItemLayout, alignment: .center, spacing: 20) {
                ForEach(results, id: \.self) { photo in
                    GeometryReader { gr in
                        KFImage(URL(string:photo.urls.raw))
                            .onSuccess(perform: { success in
                                self.shouldAnimate = false
                            })
                            .resizable()
                            .scaledToFit()
                            .scaledToFill()
                            .frame(height: gr.size.width)
                    }
                    .clipped()
                    .aspectRatio(1, contentMode: .fit)
                }
            }
        }.padding(.top, 20).padding(.trailing, 20).padding(.leading, 20).onAppear(perform: loadData)
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
