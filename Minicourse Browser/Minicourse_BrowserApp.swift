//
//  Minicourse_BrowserApp.swift
//  Minicourse Browser
//
//  Created by the CIS 1951 team on 2/15/24.
//

import SwiftUI

@main
struct Minicourse_BrowserApp: App {
    @State var favoritesViewModel = FavoritesViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(favoritesViewModel)
        }
    }
}
