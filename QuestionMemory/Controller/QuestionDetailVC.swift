//
//  QuestionDetailVC.swift
//  QuestionMemory
//
//  Created by sh3ll on 19.02.2021.
//

import UIKit

class QuestionDetailVC: UIViewController {

    @IBOutlet weak var imageViewQuestion: UIImageView!
    var isOpen = false
    var selecetedQuestion: CoreDataQuestion? = nil

    var frontImage: UIImage!
    var backImage: UIImage!


    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(flipCard))
        imageViewQuestion.addGestureRecognizer(tap)
        imageViewQuestion.isUserInteractionEnabled = true


        frontImage = UIImage(data: (selecetedQuestion?.questionImage)!)
        backImage = UIImage(data: (selecetedQuestion?.answerImage)!)

        imageViewQuestion.image = UIImage(data: (frontImage.jpegData(compressionQuality: 0.5))!)
    }



    @objc func flipCard() {

        if isOpen {
            isOpen = false
            imageViewQuestion.image = UIImage(data: frontImage.jpegData(compressionQuality: 0.5)!)
            UIView.transition(with: imageViewQuestion, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        } else {
            isOpen = true
            imageViewQuestion.image = UIImage(data: backImage.jpegData(compressionQuality: 0.5)!)
            UIView.transition(with: imageViewQuestion, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
}



