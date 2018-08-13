//
//  VacancyCell.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class VacancyCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(withModel model: Vacancy) {
        nameLbl.text = model.title
        cityLbl.text = model.location
        typeLbl.text = model.type
    }

}
