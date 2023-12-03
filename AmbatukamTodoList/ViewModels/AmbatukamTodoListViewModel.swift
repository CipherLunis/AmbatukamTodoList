//
//  AmbatukamTodoListViewModel.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/2/23.
//

import CoreData
import Foundation

class AmbatukamTodoListViewModel: ObservableObject {
    
    let container = NSPersistentContainer(name: "Ambatukam")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    @Published var todoListData: [AmbatukamTodoListItem] = [
        AmbatukamTodoListItem(imageURL: "Ambatukam1", soundURL: "AMBASSING", content: "AMBASSING"),
        AmbatukamTodoListItem(imageURL: "Ambatukam2", soundURL: "AMBATUKAM", content: "AMBATUKAM"),
        AmbatukamTodoListItem(imageURL: "Ambatukam3", soundURL: "AMBATUKAM2", content: "AMBATUKAM2"),
        AmbatukamTodoListItem(imageURL: "Ambatukam4", soundURL: "AMBATUNAT", content: "AMBATUNAT"),
        AmbatukamTodoListItem(imageURL: "Ambatukam5", soundURL: "OMAYGOT", content: "OMAYGOT"),
        AmbatukamTodoListItem(imageURL: "Ambatukam5", soundURL: "THANKYOUSOMUCH", content: "THANKYOUSOMUCH")
    ]
    
    func appendTodoListItem(item todoListDataItem: AmbatukamTodoListItem) {
        todoListData.append(todoListDataItem)
    }
}
