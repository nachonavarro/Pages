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
        Image(self.imagePath)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

struct FullscreenBackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenBackgroundImage(imagePath: "avenue")
    }
}
