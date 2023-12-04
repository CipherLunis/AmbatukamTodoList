//
//  AmbatukamTodoListApp.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/1/23.
//

import SwiftUI

@main
struct AmbatukamTodoListApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var viewModel = AmbatukamTodoListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ListView(ambatukamViewModel: viewModel)
                .environment(\.managedObjectContext, viewModel.container.viewContext)
        }
    }
}
