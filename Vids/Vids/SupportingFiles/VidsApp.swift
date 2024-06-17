//
//  VidsApp.swift
//  Vids
//
//  Created by AliReza on 2024-06-16.
//

import SwiftUI

@main
struct VidsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FeedsListView()
            }
        }
    }
}
