//
//  DescriptionVC.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {
    
    var vacancyDescription: NSAttributedString?

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Description"
        textView.attributedText = vacancyDescription
    }

}
