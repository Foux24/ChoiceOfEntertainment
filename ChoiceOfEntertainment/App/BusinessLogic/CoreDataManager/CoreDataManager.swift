//
//  CoreDataManager.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 18.01.2023.
//

import Foundation
import CoreData

// MARK: - CoreDataManager
final class CoreDataManager {
    
    /// Singletone
    static let instance = CoreDataManager()
    
    /// Container
    private let persistentContainer: NSPersistentContainer
    
    /// Context
    private let context: NSManagedObjectContext
    
    /// Инициализтор
    private init() {
        let container = NSPersistentContainer(name: "ChoiceOfEntertainment")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer = container
        context = persistentContainer.newBackgroundContext()
    }
    
    /// Массив свойств для запросов фильмов  из БД
    var propertiesRequestMovies: [ModelRequestMoviesCD]? {
        let fetchRequest: NSFetchRequest<ModelRequestMoviesCD> = ModelRequestMoviesCD.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            let maxLimitObject: Int = 15
            if result.count > maxLimitObject {
                let lastFiveObject = result.sorted { $0.index < $1.index }.suffix(maxLimitObject)
                result.forEach { object in
                    if !lastFiveObject.contains(object) {
                        deleteItem(object)
                        saveContext()
                    }
                }
                return result.sorted { $0.index < $1.index }
            } else {
                return result
            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /// Создание обьекта свойств запроса в БД
    @discardableResult
    func createListPropertiesRequestCD(properties: CinemaListRequestDataModel) -> Error? {
        guard let typeCinema = properties.typeCinema,
              let typeCountry = properties.typeCountry,
              let genre = properties.genre,
              let typeSorted = properties.typeSorted,
              let ratingMin = properties.ratingMin,
              let ratingMax = properties.ratingMax,
              let yearMin = properties.yearMin,
              let yearMax = properties.yearMax else {
            assertionFailure("CinemaListRequestDataModel nil properties")
            return nil
        }
        let objectCD = ModelRequestMoviesCD(context: context)
        objectCD.typeCinema = typeCinema
        objectCD.typeCountry = typeCountry
        objectCD.genre = genre
        objectCD.typeSorted = typeSorted
        objectCD.ratingMin = ratingMin
        objectCD.ratingMax = ratingMax
        objectCD.yearMin = yearMin
        objectCD.yearMax = yearMax
        objectCD.index = Int16((propertiesRequestMovies?.sorted {$0.index < $1.index}.last?.index ?? 0) + 1)
        return saveContext()
    }
}

// MARK: - Private
private extension CoreDataManager {
    
    /// Сохранение контекста в БД
    @discardableResult
    private func saveContext() -> Error? {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
                context.rollback()
                return error
            }
        }
        return nil
    }
    
    /// Удаление обьекта из БД
    func deleteItem(_ object: NSManagedObject) {
        context.delete(object)
    }
}
