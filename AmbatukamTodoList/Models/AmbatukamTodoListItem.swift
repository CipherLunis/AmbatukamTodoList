//
//  TodoListItem.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/2/23.
//

import Foundation

struct AmbatukamTodoListItem: Identifiable {
    var id: UUID = UUID()
    var imageURL: String
    var soundURL: String
    var content: String
}
