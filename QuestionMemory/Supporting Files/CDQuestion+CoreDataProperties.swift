//
//  CDQuestion+CoreDataProperties.swift
//  QuestionMemory
//
//  Created by sh3ll on 22.02.2021.
//
//

import Foundation
import CoreData


extension CDQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDQuestion> {
        return NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
    }

    @NSManaged public var answerImage: Data?
    @NSManaged public var descriptionText: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lackType: String?
    @NSManaged public var lessonType: String?
    @NSManaged public var questionImage: Data?
    @NSManaged public var formattedImage: Data?

    func convertToQuestion() -> CoreDataQuestion {
        return CoreDataQuestion(id: self.id!, lessonType: self.lessonType, lackType: self.lackType, descriptionText: self.descriptionText, questionImage: self.questionImage, answerImage: self.answerImage, formattedImage: self.formattedImage)

    }
    
}

extension CDQuestion : Identifiable {

}
