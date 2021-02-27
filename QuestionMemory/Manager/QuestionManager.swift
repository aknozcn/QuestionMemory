//
//  QuestionManager.swift
//  QuestionMemory
//
//  Created by sh3ll on 21.02.2021.
//

import Foundation


struct QuestionManager {
    
    private let _questionDataRepository = QuestionDataRepository()
    
    func createQuestion(question: CoreDataQuestion) {
        
        _questionDataRepository.create(question: question)
    }
    
    func fetchQuestion() -> [CoreDataQuestion]? {
        
        return _questionDataRepository.getAll()
    }
    
    func fetchQuestion(byIdentifier id: UUID) -> CoreDataQuestion? {
        
        return _questionDataRepository.get(byIdentifier: id)
    }  
    
    func updateQuestion(question: CoreDataQuestion) -> Bool {
        
        return _questionDataRepository.update(question: question)
    }
    
    func deleteQuestion(id: UUID) -> Bool {
        
        return _questionDataRepository.delete(id: id)
    }
}
