//
//  VacanciesVC.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class VacanciesVC: UIViewController {

    private var vacancies: [Vacancy] = []

    @IBOutlet weak var vacanciesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: JSON_URL) else { return }
        NetworkService.shared.getData(url: url) { (result) in
            switch result {
            case .success(let data):
                guard let vacancies = data as? [Vacancy] else { return }
                vacancies.forEach { $0.printDescription() }
                self.vacancies = vacancies
                self.vacanciesTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}


extension VacanciesVC: UITableViewDelegate {
    
}

extension VacanciesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VACANCY_CELL, for: indexPath) as? VacancyCell else { return UITableViewCell() }
        cell.setup(withModel: vacancies[indexPath.row])
        return cell
    }
    
    
}
