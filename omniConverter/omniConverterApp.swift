//
//  omniConverterApp.swift
//  omniConverter
//
//  Created by John Florian on 12/19/24.
//

import SwiftUI

@main
struct omniConverterApp: App {
  @StateObject private var appState = AppState()
  
  var body: some Scene {
    WindowGroup {
      MainView(vm: MainViewModel(appState: appState))
        .environmentObject(appState)
    }
  }
}
