//
//  OnboardingView.swift
//  PagesDemo
//
//  Created by Nacho Navarro on 03/11/2019.
//  Copyright © 2019 nachonavarro. All rights reserved.
//

import SwiftUI
import Pages

struct OnboardingView: View {
    var body: some View {
        VStack {
            Pages(alignment: .leading) {
                WelcomePage(background: "avenue")
                    .border(Color.blue, width: 3)
                WelcomePage(background: "elephant")
                WelcomePage(background: "nature")
            }
            .border(Color.red, width: 2)
        }.padding(100)
    }
}

struct WelcomePage: View {

    var background: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Hi")
        }
        .border(Color.blue)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
