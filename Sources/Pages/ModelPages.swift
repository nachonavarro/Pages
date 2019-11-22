//
//  ModelPages.swift
//  Pages
//
//  Created by Nacho Navarro on 01/11/2019.
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

/// A paging view that generates pages dynamically based on some user-defined data.
@available(iOS 13.0, *)
public struct ModelPages<Data, Content>: View where Data: RandomAccessCollection, Content: View {

    @Binding var currentPage: Int
    var items: [Data.Element]

    private var template: (Int, Data.Element) -> Content
    private var navigationOrientation: UIPageViewController.NavigationOrientation
    private var transitionStyle: UIPageViewController.TransitionStyle
    private var bounce: Bool
    private var wrap: Bool
    private var hasControl: Bool
    private var pageControl: UIPageControl? = nil
    private var controlAlignment: Alignment

    /**
    Creates the paging view that generates pages dynamically based on some user-defined data.

    `ModelPages` can be used as follows:
       ```
           struct Car: {
               var model: String
           }

           struct CarsView: View {

               @State var index: Int = 0
               let cars = [Car(model: "Ford"), Car(model: "Ferrari")

               var body: some View {
                   ModelPages(self.cars, currentPage: $index) { i, car in
                       Text("Car is \(car.model)!")
                   }
               }
           }
       ```

       - Parameters:
            - items: The collection of data that will drive page creation.
            - currentPage: A binding to give the user control over the current page index.
            - navigationOrientation: Whether to paginate horizontally or vertically.
            - transitionStyle: Whether to perform a page curl or a scroll effect on page turn.
            - bounce: Whether to bounce back when a user tries to scroll past all the pages.
            - wrap: A flag indicating whether to wrap the pages circularly when the user scrolls past the beginning or end.
            - hasControl: Whether to display a page control or not.
            - control: A user defined page control.
            - controlAlignment: What position to put the page control.
            - template: A function that specifies how a page looks like given the position of the page and the item related to the page.
    */
    public init(
        _ items: Data,
        currentPage: Binding<Int>,
        navigationOrientation: UIPageViewController.NavigationOrientation = .horizontal,
        transitionStyle: UIPageViewController.TransitionStyle = .scroll,
        bounce: Bool = true,
        wrap: Bool = false,
        hasControl: Bool = true,
        control: UIPageControl? = nil,
        controlAlignment: Alignment = .bottom,
        template: @escaping (Int, Data.Element) -> Content
    ) {
        self._currentPage = currentPage
        self.navigationOrientation = navigationOrientation
        self.transitionStyle = transitionStyle
        self.bounce = bounce
        self.wrap = wrap
        self.hasControl = hasControl
        self.pageControl = control
        self.controlAlignment = controlAlignment
        self.items = items.map { $0 }
        self.template = template
    }

    public var body: some View {
        ZStack(alignment: self.controlAlignment) {
            PageViewController(
                currentPage: $currentPage,
                navigationOrientation: navigationOrientation,
                transitionStyle: transitionStyle,
                bounce: bounce,
                wrap: wrap,
                controllers: (0..<items.count).map { i in
                    let h = UIHostingController(rootView: template(i, items[i]))
                    h.view.backgroundColor = .clear
                    return h
                }
            )
            if self.hasControl {
                PageControl(
                    numberOfPages: items.count,
                    pageControl: pageControl,
                    currentPage: $currentPage
                ).padding()
            }
        }
    }

}
