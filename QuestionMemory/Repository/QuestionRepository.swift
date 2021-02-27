//
//  QuestionRepository.swift
//  QuestionMemory
//
//  Created by sh3ll on 21.02.2021.
//

import Foundation


protocol QuestionRepository {
    
    func create(question: CoreDataQuestion)
    func getAll() -> [CoreDataQuestion]?
    func get(byIdentifier id: UUID) -> CoreDataQuestion?
    func update(question: CoreDataQuestion) -> Bool
    func delete(id: UUID) -> Bool
}
