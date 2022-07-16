//
//  DataManager.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 6/07/22.
//

import CoreData

class DataManager {
    
    static let current = DataManager()
    
    lazy var presistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Peliculas")
        container.loadPersistentStores { descripcion, error in
            if let error = error {
                print("ERROR EN LA LECTURA DE LA BASE DE DATOS: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
    func saveContext() {
        let context = self.presistentContainer.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}
