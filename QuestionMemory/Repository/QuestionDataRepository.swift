//
//  QuestionDataRepository.swift
//  QuestionMemory
//
//  Created by sh3ll on 21.02.2021.
//

import Foundation
import CoreData

struct QuestionDataRepository: QuestionRepository {



    func create(question: CoreDataQuestion) {

        let cdQuestion = CDQuestion(context: PersistentStorage.shared.context)
        cdQuestion.id = question.id
        cdQuestion.lessonType = question.lessonType
        cdQuestion.lackType = question.lackType
        cdQuestion.descriptionText = question.descriptionText
        cdQuestion.questionImage = question.questionImage
        cdQuestion.answerImage = question.answerImage
        cdQuestion.formattedImage = question.formattedImage

        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [CoreDataQuestion]? {

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDQuestion.self)

        var questionss: [CoreDataQuestion] = []
        result?.forEach({ (cdQuestion) in
            questionss.append(cdQuestion.convertToQuestion())
        })

        return questionss
    }

    func get(byIdentifier id: UUID) -> CoreDataQuestion? {

        let result = getCDQuestion(byIdentifier: id)
        guard result != nil else { return nil }
        return result?.convertToQuestion()
    }

    func update(question: CoreDataQuestion) -> Bool {

        let cdQuestion = getCDQuestion(byIdentifier: question.id)
        guard cdQuestion != nil else { return false }

        cdQuestion?.lessonType = question.lessonType
        cdQuestion?.lackType = question.lackType
        cdQuestion?.descriptionText = question.descriptionText
        cdQuestion?.questionImage = question.questionImage
        cdQuestion?.answerImage = question.answerImage
        PersistentStorage.shared.saveContext()
        return true

    }

    func delete(id: UUID) -> Bool {
        let cdQuestion = getCDQuestion(byIdentifier: id)
        guard cdQuestion != nil else { return false }

        PersistentStorage.shared.context.delete(cdQuestion!)
        PersistentStorage.shared.saveContext()
        return true
    }

    private func getCDQuestion(byIdentifier id: UUID) -> CDQuestion? {
        let fetchRequest = NSFetchRequest<CDQuestion>(entityName: "CDQuestion")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first

            guard result != nil else { return nil }
            return result

        } catch let error {
            debugPrint(error)
        }
        return nil
    }

}
