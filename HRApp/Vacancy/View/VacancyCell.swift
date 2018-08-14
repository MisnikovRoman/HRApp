//
//  VacancyCell.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit
import Kingfisher

class VacancyCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        logoImageView.layer.cornerRadius = logoImageView.frame.width / 2
    }
    
    func setup(withModel model: Vacancy) {
        nameLbl.text = model.title
        cityLbl.text = model.company
        guard let logoStringUrl = model.companyLogo else { return }
        guard let logoUrl = URL(string: logoStringUrl) else { return }
        logoImageView.kf.indicatorType = .activity
        logoImageView.kf.setImage(with: logoUrl)
    }

}
