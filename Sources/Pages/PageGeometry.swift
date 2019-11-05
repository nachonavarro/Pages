//
//  PageGeometry.swift
//  Pages
//
//  Created by Nacho Navarro on 02/11/2019.
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

import Foundation
import SwiftUI

/// Performs the heavy lifting by determining offsets based on user interaction.
@available(iOS 13.0, OSX 10.15, *)
internal class PageGeometry: ObservableObject {

    @Published var pageWidth: CGFloat = 0
    @Published var pageOffset: CGFloat = 0
    @Published var index: Int = 0

    var insets: EdgeInsets
    var alignment: Alignment
    private var bounce: Bool
    private var numPages: Int = 0

    /**
    Creates the observable object that will determine offsets for the scroll view's content.

     - Parameters:
        - bounce: Whether to bounce back when a user tries to scroll past all the pages.
        - numPages: The number of pages on the paging view.
     */
    init(insets: EdgeInsets, bounce: Bool, alignment: Alignment, numPages: Int) {
        self.insets = insets
        self.bounce = bounce
        self.alignment = alignment
        self.numPages = numPages
    }

    func onChangePage(offset: CGFloat) {
        if self.bounce {
            self.pageOffset = -CGFloat(index) * self.pageWidth + offset
        } else {
            self.pageOffset = keepWithin(min: -CGFloat(self.numPages - 1) * self.pageWidth, max: 0) {
                -CGFloat(self.index) * self.pageWidth + offset
            }
        }
    }

    func onEndPage(offset: CGFloat) {
        if abs(offset) >= self.pageWidth / 2 {
            self.index = keepWithin(min: 0, max: self.numPages - 1) {
                self.index + (offset < 0 ? 1 : -1)
            }
        }
        withAnimation {
            self.pageOffset = -CGFloat(index) * self.pageWidth
        }
    }

    /**
     Performs `operation` ensuring the result is within `min` and `max`.

        This function can only be called with types that implement `Comparable`.
        This makes sense as we are performing an operation by comparing it with a `min` and `max`.

     - Parameters:
        - min: The minimum value considered. Anything below that will default to `min`.
        - max: The maximum value considered. Anything above that will default to `max`.
        - operation: The operation to perform

    Example:
        ```
            let x = keepWithin(min: 1, max: 5) {
                4 + 6
            }
            print(x) // prints 5
        ```
     */
    private func keepWithin<T: Comparable>(min: T, max: T, operation: @escaping () -> T) -> T {
        let op = operation()
        if min <= op && op <= max {
            return op
        }
        return op < min ? min : max
    }

}

/// The preference key for storing a view's width.
internal struct WidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat(0)

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

/// A view that reads the width of the child.
@available(iOS 13.0, OSX 10.15, *)
internal struct WidthReader<Content: View> : View {

    var content: (CGFloat)->Content
    @State private var width: CGFloat = 0

    init(@ViewBuilder content: @escaping (CGFloat)->Content) {
        self.content = content
    }

    var body: some View {
        content(width)
            .background(GeometryReader { geometry in
                Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
            })
            .onPreferenceChange(WidthPreferenceKey.self) { width in
                self.width = width
            }
    }
}
