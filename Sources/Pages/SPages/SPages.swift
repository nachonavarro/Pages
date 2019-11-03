//
//  SPages.swift
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
public struct SPages: View {

    var pages: [AnyView]
    @ObservedObject private var pg: PageGeometry

    /**
    Creates the paging view that generates user-defined static pages.

    `SPages` can be used as follows:
       ```
           struct WelcomeView: View {
               var body: some View {
                   SPages {
                        Text("Welcome! This is Page 1")
                        Text("This is Page 2")
                        Text("...and this is Page 3")
                   }
               }
           }
       ```

       - Parameters:
           - pages: A function builder `PagesBuilder` that will put the views defined by the user on a list.
    */
    public init(@PagesBuilder pages: () -> [AnyView]) {
        self.pages = pages()
        self.pg = PageGeometry(numPages: self.pages.count)
    }

    public var body: some View {
        GeometryReader { geometry in
            Pages(numPages: self.pages.count) {
                HStack(spacing: 0) {
                    ForEach(0..<self.pages.count) { i in
                        self.pages[i]
                            .frame(width: geometry.size.width)
                    }
                }
            }
        }
    }

}
