//
//  AmbatukamTodoListApp.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/1/23.
//

import SwiftUI

@main
struct AmbatukamTodoListApp: App {
    //@StateObject private var viewModel = AmbatukamTodoListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ListView()
                //.environment(\.managedObjectContext, viewModel.container.viewContext)
        }
    }
}
