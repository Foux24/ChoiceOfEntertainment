//
//  ModelRequestMoviesCD+CoreDataProperties.swift
//  ChoiceOfEntertainment
//
//  Created by Виталий Сухорослов on 18.01.2023.
//
//

import Foundation
import CoreData


extension ModelRequestMoviesCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ModelRequestMoviesCD> {
        return NSFetchRequest<ModelRequestMoviesCD>(entityName: "ModelRequestMoviesCD")
    }

    @NSManaged public var typeCinema: String?
    @NSManaged public var typeCountry: String?
    @NSManaged public var genre: String?
    @NSManaged public var typeSorted: String?
    @NSManaged public var ratingMin: String?
    @NSManaged public var ratingMax: String?
    @NSManaged public var yearMin: String?
    @NSManaged public var yearMax: String?
    @NSManaged public var index: Int16

}

extension ModelRequestMoviesCD : Identifiable {

}
