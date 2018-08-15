//
//  VacanciesVC.swift
//  HRApp
//
//  Created by Роман Мисников on 13/08/2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import UIKit

class VacanciesVC: UIViewController {

    // MARK: - Variables
    private var vacancies: [Vacancy] = [] {
        didSet { vacanciesTableView.reloadData() }
    }
    private var vacanciesPage: Int = 0
    private var updateAvilable = false
    
    // MARK: - Outlets
    @IBOutlet weak var vacanciesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - VC lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVacancies(forSearchText: "android", atPage: 0)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // hide keyboard when view is touched
        searchBar.resignFirstResponder()
    }
    
    func loadVacancies(forSearchText text: String, atPage page: Int) {
        activityIndicator.startAnimating()
        if page == 0 {
            vacanciesPage = 0
            vacancies = []
        }
        // create url from input data
        let fullUrlString = JSON_BASE_URL + "\(text)&page=\(page)"
        guard let url = URL(string: fullUrlString) else { return }
        
        // data loading
        NetworkService.shared.getData(url: url) { (result) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                switch result {
                case .success(let data):
                    guard let vacancies = data as? [Vacancy] else { return }
                    self.vacancies += vacancies
                    if vacancies.count != 0 {
                        self.vacanciesPage += 1
                        self.updateAvilable = true
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == DESCRIPTION_SEGUE else { return }
        guard let descriptionVC = segue.destination as? DescriptionVC else { return }
        guard let selectedVacancy = sender as? Vacancy else { return }
        descriptionVC.vacancy = selectedVacancy
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
            guard updateAvilable else { return }
            guard var searchText = searchBar.text else { return }
            guard vacanciesPage != 0 else { return }
            
            if searchText == "" { searchText = DEFAULT_SEARCH }
            print("❗️ curr page: \(vacanciesPage)")
            updateAvilable = false
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
