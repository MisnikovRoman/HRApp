//
//  DescriptionVC.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {
    
    var vacancy: Vacancy?

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    
    func setupViewController() {
        // navigation bar title
        self.title = "Description"
        // setup UI
        guard let vacancy = vacancy else { return }
        let attributedDescription = vacancy.description.htmlAttributed(fontName: CSS_FONT_NAME, size: 14, color: #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1))
        if let date = vacancy.createdAt.convertToDate() {
            dateLbl.text = date.stringPrettyFormat()
        } else {
            dateLbl.text = "date error"
        }
        titleLbl.text = vacancy.title
        locationLbl.text = vacancy.location
        timeLbl.text = vacancy.type
        descriptionLbl.attributedText = attributedDescription
    }
}
