//
//  VacanciesVC.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class VacanciesVC: UIViewController {

    private var vacancies: [Vacancy] = [] {
        didSet {
            vacanciesTableView.reloadData()
        }
    }
    private var vacanciesPage: Int = 0

    @IBOutlet weak var vacanciesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVacancies(forSearchText: "android", atPage: 0)
    }
    
    func loadVacancies(forSearchText text: String, atPage page: Int) {
        if page == 0 {
            vacanciesPage = 0
            vacancies = []
        }
        // create url from input data
        let fullUrlString = JSON_BASE_URL + "\(text)&page=\(page)"
        guard let url = URL(string: fullUrlString) else { return }
        
        // data loading
        NetworkService.shared.getData(url: url) { (result) in
            switch result {
            case .success(let data):
                guard let vacancies = data as? [Vacancy] else { return }
                DispatchQueue.main.async {
                    self.vacancies += vacancies
                    if vacancies.count != 0 { self.vacanciesPage += 1 }
                }
             case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == DESCRIPTION_SEGUE else { return }
        guard let descriptionVC = segue.destination as? DescriptionVC else { return }
        guard let selectedVacancy = sender as? Vacancy else { return }
        descriptionVC.vacancyDescription = selectedVacancy.description.htmlAttributed(fontName: CSS_FONT_NAME, size: 17, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }
}

extension VacanciesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVacancy = vacancies[indexPath.row]
        performSegue(withIdentifier: DESCRIPTION_SEGUE, sender: selectedVacancy)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == vacancies.count - 1 {
            // check search
            guard var searchText = searchBar.text else { return }
            guard vacanciesPage != 0 else { return }
            
            if searchText == "" { searchText = DEFAULT_SEARCH }
            loadVacancies(forSearchText: searchText, atPage: vacanciesPage)
        }
    }
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

extension VacanciesVC: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        loadVacancies(forSearchText: text, atPage: 0)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        loadVacancies(forSearchText: text, atPage: 0)
        searchBar.resignFirstResponder()
    }
}
