//
//  PageControl.swift
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

/// The page control for the page view.
@available(iOS 13.0, *)
internal struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    var pageControl: UIPageControl?
    @Binding var currentPage: Int

    func makeCoordinator() -> PageControlCoordinator {
        PageControlCoordinator(self)
    }

    func makeUIView(context: Context) -> UIPageControl {
        if let control = self.pageControl {
            return control
        } else {
            let control = UIPageControl()
            control.numberOfPages = numberOfPages
            control.addTarget(
                context.coordinator,
                action: #selector(Coordinator.updateCurrentPage(sender:)),
                for: .valueChanged
            )
            return control
        }
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = self.currentPage
    }

}

@available(iOS 13.0, *)
class PageControlCoordinator: NSObject {
    var control: PageControl

    init(_ control: PageControl) {
        self.control = control
    }

    @objc
    func updateCurrentPage(sender: UIPageControl) {
        control.currentPage = sender.currentPage
    }
}

