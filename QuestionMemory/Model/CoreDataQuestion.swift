//
//  Question.swift
//  QuestionMemory
//
//  Created by sh3ll on 21.02.2021.
//

import Foundation

struct CoreDataQuestion {
    
    var id: UUID
    var lessonType: String?
    var lackType: String?
    var descriptionText: String?
    var questionImage: Data?
    var answerImage: Data?
    var formattedImage: Data?
}
