//
//  AmbatukamTodoListViewModel.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/2/23.
//

import CoreData
import Foundation

class AmbatukamTodoListViewModel: ObservableObject {
    
    let container = NSPersistentContainer(name: "AmbatukamTodoListDataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "h:mm a 'on' MMMM dd, yyyy"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
}
