//
//  atilimSchApp.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 21.01.2024.
//

import SwiftUI

@main
struct atilimSchApp: App {
    @StateObject private var CoredataViewModel = CoreDataViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .colorScheme(.dark)
                .environment(\.managedObjectContext, CoredataViewModel.container.viewContext)
        }
    }
}
