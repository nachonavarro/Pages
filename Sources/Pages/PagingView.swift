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

    var pages: (CGFloat) -> P
    @ObservedObject private var pg: PageGeometry

    /**
    Creates the  base class that describes a paging view and its behavior.

     - Parameters:
        - alignment: How to align the content of each page. Defaults to `.center`.
        - numPages: Number of pages on the paging view.
        - pages: A function that outputs the view with all the pages. This will be supplied by
                `ModelPages` or `Pages`.
     - Note: This class can be seen as a helper class and not intended for the user.
     */
    init(bounce: Bool, alignment: Alignment, numPages: Int, @ViewBuilder pages: @escaping (CGFloat) -> P) {
        self.pg = PageGeometry(bounce: bounce, alignment: alignment, numPages: numPages)
        self.pages = pages
    }

    var body: some View {
        WidthReader { width in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    self.pages(width)
                }
            }
            .content.offset(x: self.pg.pageOffset)
            .frame(width: width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged { self.pg.onChangePage(offset: $0.translation.width) }
                    .onEnded { self.pg.onEndPage(offset: $0.predictedEndTranslation.width) }
            )
            .preference(key: WidthPreferenceKey.self, value: width)
            .onPreferenceChange(WidthPreferenceKey.self) {
                self.pg.pageWidth = $0
            }
        }
        .clipped()
    }

}
