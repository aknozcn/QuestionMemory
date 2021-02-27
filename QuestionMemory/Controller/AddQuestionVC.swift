//
//  AddQuestionVC.swift
//  QuestionMemory
//
//  Created by sh3ll on 18.02.2021.
//

import UIKit
import CoreData

class AddQuestionVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var pickerViewLesson: UIPickerView!
    @IBOutlet weak var pickerViewLack: UIPickerView!
    @IBOutlet weak var pickerViewExam: UIPickerView!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var imageViewQuestion: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!


    var lackText: String?
    var lessonText: String?

    private let manager: QuestionManager = QuestionManager()


    var transferedImage: UIImage!


    var pickerDataLesson = [String]()
    var pickerDataLack = [String]()
    var pickerDataExam = [String]()

    var firstPageImage: UIImage!
    var secondPageImage: UIImage!

    var placeHolder: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerViewLesson.delegate = self
        self.pickerViewLesson.dataSource = self
        self.pickerViewLack.delegate = self
        self.pickerViewLack.dataSource = self
        self.pickerViewExam.delegate = self
        self.pickerViewExam.dataSource = self

        LackType.allCases.forEach { (lack) in
            pickerDataLack.append(lack.rawValue)
        }

        ExamType.allCases.forEach { (exam) in
            pickerDataExam.append(exam.rawValue)
        }

        if transferedImage != nil {
            imageViewQuestion.image = transferedImage
            firstPageImage = transferedImage
            placeHolder = true
        }

        loadPickerViewItems(didSelectRow: ExamType.TYT)


        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewClicked))
        imageViewQuestion.addGestureRecognizer(tap)
        imageViewQuestion.isUserInteractionEnabled = true

    }



    @objc func imageViewClicked() {

        if placeHolder {
            let ac = UIAlertController(title: "New Photo…", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Take Picture", style: .default, handler: imageFromCamera))
            ac.addAction(UIAlertAction(title: "Choose From Gallery", style: .default, handler: imageFromGallery))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }

    }


    func imageFromCamera(action: UIAlertAction) {

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }

    func imageFromGallery(action: UIAlertAction) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {


        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            imageViewQuestion.image = pickedImage
            if pageController.currentPage == 0 {
                firstPageImage = pickedImage
                placeHolder = false
            }
            else if pageController.currentPage == 1 {
                secondPageImage = pickedImage
                placeHolder = false
            }
        }


        dismiss(animated: true, completion: nil)

    }



    @IBAction func buttonPageRightClicked(_ sender: UIButton) {
        changePage(move: PageMoveType.right)
    }

    @IBAction func buttonPageLeftClicked(_ sender: UIButton) {
        changePage(move: PageMoveType.left)
    }


    func changePage(move: PageMoveType) {

        switch move {
        case .right:
            pageController.currentPage += 1
            if secondPageImage == nil {
                imageViewQuestion.image = UIImage(named: "placeholder")
                placeHolder = true
            } else {
                imageViewQuestion.image = secondPageImage
                placeHolder = false
            }
        case .left:
            pageController.currentPage -= 1
            if firstPageImage == nil {
                imageViewQuestion.image = UIImage(named: "placeholder")
                placeHolder = true
            } else {
                imageViewQuestion.image = firstPageImage
                placeHolder = false
            }
        }
    }

    func loadPickerViewItems(didSelectRow row: ExamType) {

        pickerDataLesson.removeAll()

        if row == .TYT {
            LessonType.TYT.allCases.forEach { (lesson) in
                pickerDataLesson.append(lesson.rawValue)
            }
            pickerViewLesson.reloadAllComponents()
        }
        if row == .AYT {
            LessonType.AYT.allCases.forEach { (lesson) in
                pickerDataLesson.append(lesson.rawValue)
            }
            pickerViewLesson.reloadAllComponents()
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView == pickerViewExam {
            loadPickerViewItems(didSelectRow: ExamType(rawValue: pickerDataExam[row])!)
        }
        if pickerView == pickerViewLesson {
            lessonText = pickerDataLesson[row]
        }
        if pickerView == pickerViewLack {
            lackText = pickerDataLack[row]
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch pickerView {
        case pickerViewLesson:
            return pickerDataLesson.count
        case pickerViewLack:
            return pickerDataLack.count
        case pickerViewExam:
            return pickerDataExam.count
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        switch pickerView {
        case pickerViewLesson:
            return pickerDataLesson[row]
        case pickerViewLack:
            return pickerDataLack[row]
        case pickerViewExam:
            return pickerDataExam[row]
        default:
            return ""
        }

    }

    @IBAction func buttonSaveClicked(_ sender: UIButton) {

        if firstPageImage != nil && secondPageImage != nil {
            let resFormattedImage = self.resizeImage(image: firstPageImage, targetSize: CGSize(width: 350, height: 300))
            let resFhdQuestionImage = self.resizeImage(image: firstPageImage, targetSize: CGSize(width: 1920, height: 1080))
            let resFhdAnswerImage = self.resizeImage(image: secondPageImage, targetSize: CGSize(width: 1920, height: 1080))

            let question = CoreDataQuestion(id: UUID(), lessonType: pickerDataLesson[pickerViewLesson.selectedRow(inComponent: 0)], lackType: pickerDataLack[pickerViewLack.selectedRow(inComponent: 0)], descriptionText: textViewDescription.text, questionImage: resFhdQuestionImage.pngData(), answerImage: resFhdAnswerImage.pngData(), formattedImage: resFormattedImage.jpegData(compressionQuality: 0.8))

            manager.createQuestion(question: question)
        } else {
            print("Soru veya cevap resmi yükleyin.")
        }

    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}
