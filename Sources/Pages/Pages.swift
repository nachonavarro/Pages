//
//  Pages.swift
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

/// A paging view that generates user-defined static pages.
@available(iOS 13.0, OSX 10.15, *)
public struct Pages: View {

    var pg: PageGeometry
    var pages: [AnyView]

    /**
    Creates the paging view that generates user-defined static pages.

    `Pages` can be used as follows:
       ```
           struct WelcomeView: View {
               var body: some View {
                   Pages {
                        Text("Welcome! This is Page 1")
                        Text("This is Page 2")
                        Text("...and this is Page 3")
                   }
               }
           }
       ```

       - Parameters:
            - bounce: Whether to bounce back when a user tries to scroll past all the pages.
            - alignment: How to align the content of each page. Defaults to `.center`.
            - pages: A function builder `PagesBuilder` that will put the views defined by the user on a list.
    */
    public init(bounce: Bool = true, alignment: Alignment = .center, @PagesBuilder pages: () -> [AnyView]) {
        self.pages = pages()
        self.pg = PageGeometry(bounce: bounce, alignment: alignment, numPages: self.pages.count)
    }

    public var body: some View {
        PagingView(self.pg) {
            ForEach(0..<self.pages.count) { i in
                WidthReader { width in
                    self.pages[i]
                        .preference(key: WidthPreferenceKey.self, value: width)
                        .onPreferenceChange(WidthPreferenceKey.self) {
                            self.pg.pageWidth = $0
                    }
                }
            }
        }
    }

}
