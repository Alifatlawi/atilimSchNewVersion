//
//  CoreDataViewModel.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 22.01.2024.
//

import Foundation
import CoreData


class CoreDataViewModel: ObservableObject {
    
    var container = NSPersistentContainer(name: "CoursesDB")
    
    init(){
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA \(error.localizedDescription)")
            }
        }
    }
}
