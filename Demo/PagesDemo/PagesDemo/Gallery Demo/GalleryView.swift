//
//  GalleryView.swift
//  PagesDemo
//
//  Created by Nacho Navarro on 04/11/2019.
//  Copyright © 2019 nachonavarro. All rights reserved.
//

import SwiftUI
import Pages

struct GalleryView: View {
    var body: some View {
        VStack {
            Text("My Art Collection")
                .font(.largeTitle)
            ModelPages(["a", "b", "c"]) { i, letter in
                Text(letter)
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
