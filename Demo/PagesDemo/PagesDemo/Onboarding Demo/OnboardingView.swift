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
        Pages(bounce: false) {
            WelcomePage(background: "avenue",
                        title: "Ready. Set. Apple.",
                        subtitle: "Insert witty remark about your app that will catch potential users.")
            WelcomePage(background: "elephant",
                        title: "Wow. An elephant.",
                        subtitle: "Did you know these magnificent mammals spend between 12 to 18 hours eating grass, plants and fruit every single day?")
            WelcomePage(background: "nature",
                        title: "Nature.",
                        subtitle: "I'm running out of subtitles.")
            WelcomePage(background: "landscape",
                        title: "Ah yes, Scotland.",
                        subtitle: "They may take our lives, but they'll never take our freedom!")
        }.edgesIgnoringSafeArea(.all)
    }
}

struct WelcomePage: View {

    var background: String
    var title: String
    var subtitle: String

    var body: some View {
        ZStack(alignment: .leading) {
            FullscreenBackgroundImage(imagePath: self.background)
            VStack(alignment: .leading) {
                Spacer()
                Text(self.title)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                Text(self.subtitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                    .padding(.top, 8)
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
