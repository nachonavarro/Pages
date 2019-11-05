//
//  PagingView.swift
//  Pages
//
//  Created by Nacho Navarro on 03/11/2019.
//  Copyright © 2019 nachonavarro. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import SwiftUI

/**
 The base class that describes a paging view and its behavior.

 The paging view is internally a `ScrollView` with an attached `DragGesture` that will determine
 the scroll view's content offset based on user interaction. The paging view's width is recorded via
 preference keys and used on the `PageGeometry` to calculate offsets.
 */
@available(iOS 13.0, OSX 10.15, *)
internal struct PagingView<P>: View where P: View {

    var pages: P
    @ObservedObject private var pg: PageGeometry

    /**
    Creates the  base class that describes a paging view and its behavior.

     - Parameters:
        - pg: The `PageGeometry` class that is created in `Pages`.
        - pages: A function that outputs the view with all the pages. This will be supplied by
                `ModelPages` or `Pages`.
     - Note: This class can be seen as a helper class and not intended for the user.
     */
    init(_ pg: PageGeometry, @ViewBuilder pages: () -> P) {
        self.pg = pg
        self.pages = pages()
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: self.pg.alignment.vertical, spacing: self.pg.spacing) {
                self.pages
            }.padding(self.pg.insets)
        }
        .content.offset(x: self.pg.pageOffset)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle()) // needed so drag gesture is only recognized within the page
        .gesture(
            DragGesture()
                .onChanged { self.pg.onChangePage(offset: $0.translation.width) }
                .onEnded { self.pg.onEndPage(offset: $0.predictedEndTranslation.width) }
        )
        .clipped()
    }

}
