//
//  Persistance.swift
//  MovieCenter
//
//  Created by Andres Castrillo on 24/6/21.
//

import Foundation
import CoreData

struct PersistanceController {
    static let shared = PersistanceController()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores{ (description, error) in
            if let error = error{
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func guardar(completion: @escaping(Error?) -> () = {_ in }){
        let context = container.viewContext
        if context.hasChanges{
            do{
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func eliminar(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}){
        let context = container.viewContext
        context.delete(object)
        guardar(completion: completion)
    }
    
    func obtenerFavoritos(tipo: String) -> [NSManagedObject]?{
        let managedContext = container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favoritos")
        fetchRequest.predicate = NSPredicate(format: "tipo == %@", tipo)
        do {
            let favoritos:[NSManagedObject] = try managedContext.fetch(fetchRequest)
            return favoritos
        } catch let error as NSError {
            print(error)
        }
        
        return nil
    }
    
    func verificarFavorito(id: Int32) -> Bool{
        var respuesta:Bool = false
        let managedContext = container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favoritos")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do {
            let favoritos:[NSManagedObject] = try managedContext.fetch(fetchRequest)
            print(favoritos)
            if favoritos.count >= 1 {
                respuesta = true
            }
        } catch let error as NSError {
            print(error)
        }
        
        return respuesta

    }
}
