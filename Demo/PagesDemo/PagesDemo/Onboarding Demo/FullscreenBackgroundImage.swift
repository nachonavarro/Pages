//
//  FullscreenBackgroundImage.swift
//  PagesDemo
//
//  Created by Nacho Navarro on 03/11/2019.
//  Copyright © 2019 nachonavarro. All rights reserved.
//

import SwiftUI

struct FullscreenBackgroundImage: View {

    var imagePath: String

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(self.imagePath)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .clipped()
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [.clear, Color(.sRGB, white: 0, opacity: 0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
            }
        }
    }
}

struct FullscreenBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenBackgroundImage(imagePath: "avenue")
    }
}
