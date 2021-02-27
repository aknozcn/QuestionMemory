//
//  ViewController.swift
//  QuestionMemory
//
//  Created by sh3ll on 18.02.2021.
//

import UIKit
import FFPopup

class QuestionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var imageViewQuestion: UIImageView!
    @IBOutlet weak var buttonAddPhoto: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var imageViewPopup: UIImageView!

    private let manager = QuestionManager()
    var questionss: [CoreDataQuestion]? = nil
    var selectedQuestionId: UUID?

    var popup = FFPopup()
    let layout = FFPopupLayout(horizontal: .center, vertical: .bottom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count - 1] as URL)
        tableView.delegate = self
        tableView.dataSource = self
        popupView.layer.cornerRadius = 15

        popupView.layer.shadowColor = UIColor.black.cgColor
        popupView.layer.shadowOpacity = 1
        popupView.layer.shadowOffset = .zero
        popupView.layer.shadowRadius = 10
        popupView.layer.shadowPath = UIBezierPath(rect: popupView.bounds).cgPath
        popupView.layer.shouldRasterize = true
        popupView.layer.rasterizationScale = UIScreen.main.scale
    }

    override func viewWillAppear(_ animated: Bool) {
   
       reloadTableViewData()
    }

    
    func reloadTableViewData(){
        questionss = manager.fetchQuestion()

        if questionss != nil && questionss?.count != 0 {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func buttonDeleteClicked(_ sender: UIButton) {
        
        if manager.deleteQuestion(id: selectedQuestionId!) {
            reloadTableViewData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionss!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let questn = self.questionss![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionTableViewCell
        cell.labelLesson.text = questn.lessonType
        cell.labelLack.text = questn.lackType
        cell.textViewDescription.text = questn.descriptionText
        DispatchQueue.main.async {
            cell.imageViewQuestion.image = UIImage(data: (questn.formattedImage!))
        }
        return cell

    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showPopup()
        
        let questn = self.questionss![indexPath.row]
        
        imageViewPopup.image = UIImage(data: questn.questionImage!)
        
        selectedQuestionId = questn.id
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToDetails" {

            let detailsView = segue.destination as? QuestionDetailVC
            guard detailsView != nil else { return }

            detailsView?.selecetedQuestion = questionss![self.tableView.indexPathForSelectedRow!.row]
            popup.removeFromSuperview()
        }
    }

    func showPopup() {

        popup = FFPopup(contetnView: popupView, showType: .bounceInFromBottom, dismissType: .bounceOutToBottom, maskType: .dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)
        
        popup.show(layout: layout)
    }
}

