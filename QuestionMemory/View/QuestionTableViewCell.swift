//
//  QuestionTableViewCell.swift
//  QuestionMemory
//
//  Created by sh3ll on 18.02.2021.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewQuestion: UIImageView!
    @IBOutlet weak var labelLesson: UILabel!
    @IBOutlet weak var labelLack: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
