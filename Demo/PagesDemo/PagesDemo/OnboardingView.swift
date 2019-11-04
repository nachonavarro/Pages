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
        Pages {
            WelcomePage(background: "avenue")
            WelcomePage(background: "elephant")
            WelcomePage(background: "nature")
        }
        .background(Color.blue)
    }
}

struct WelcomePage: View {

    var background: String

    var body: some View {
        VStack(alignment: .leading) {
            Text("Hi")
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
