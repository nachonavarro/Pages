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
import UIKit

/// A paging view that generates user-defined static pages.
@available(iOS 13.0, *)
public struct Pages: View {

    @Binding var currentPage: Int
    var pages: [AnyView]

    var navigationOrientation: UIPageViewController.NavigationOrientation
    var transitionStyle: UIPageViewController.TransitionStyle
    var bounce: Bool
    var wrap: Bool
    var hasControl: Bool
    var pageControl: UIPageControl? = nil
    var controlAlignment: Alignment

    /**
    Creates the paging view that generates user-defined static pages.

    `Pages` can be used as follows:
       ```
           struct WelcomeView: View {

               @State var index: Int = 0

               var body: some View {
                   Pages(currentPage: $index) {
                        Text("Welcome! This is Page 1")
                        Text("This is Page 2")
                        Text("...and this is Page 3")
                   }
               }
           }
       ```

       - Parameters:
           - navigationOrientation: Whether to paginate horizontally or vertically.
           - transitionStyle: Whether to perform a page curl or a scroll effect on page turn.
           - bounce: Whether to bounce back when a user tries to scroll past all the pages.
           - wrap: A flag indicating whether to wrap the pages circularly when the user scrolls past the beginning or end.
           - hasControl: Whether to display a page control or not.
           - control: A user defined page control.
           - controlAlignment: What position to put the page control.
           - pages: A function builder `PagesBuilder` that will put the views defined by the user on a list.
    */
    public init(
        currentPage: Binding<Int>,
        navigationOrientation: UIPageViewController.NavigationOrientation = .horizontal,
        transitionStyle: UIPageViewController.TransitionStyle = .scroll,
        bounce: Bool = true,
        wrap: Bool = false,
        hasControl: Bool = true,
        control: UIPageControl? = nil,
        controlAlignment: Alignment = .bottom,
        @PagesBuilder pages: () -> [AnyView]
    ) {
        self.navigationOrientation = navigationOrientation
        self.transitionStyle = transitionStyle
        self.bounce = bounce
        self.wrap = wrap
        self.hasControl = hasControl
        self.pageControl = control
        self.controlAlignment = controlAlignment
        self.pages = pages()
        self._currentPage = currentPage
    }

    public var body: some View {
        ZStack(alignment: self.controlAlignment) {
            PageViewController(
                currentPage: $currentPage,
                navigationOrientation: navigationOrientation,
                transitionStyle: transitionStyle,
                bounce: bounce,
                wrap: wrap,
                controllers: pages.map {
                    let h = UIHostingController(rootView: $0)
                    h.view.backgroundColor = .clear
                    return h
                }
            )
            if self.hasControl {
                PageControl(
                    numberOfPages: pages.count,
                    pageControl: pageControl,
                    currentPage: $currentPage
                ).padding()
            }
        }
    }
}
