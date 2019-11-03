//
//  ContentView.swift
//  PagesDemo
//
//  Created by Nacho Navarro on 03/11/2019.
//  Copyright © 2019 nachonavarro. All rights reserved.
//

import SwiftUI
import Pages

struct ContentView: View {
    var body: some View {
        SPages {
            Text("Hello")
            Text("Bye")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
