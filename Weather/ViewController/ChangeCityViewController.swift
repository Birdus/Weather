//
//  ChangeCityViewController.swift
//  Weather
//
//  Created by Даниил Гетманцев on 07.12.2022.
//

import UIKit

//MARK: - Protocol ChangeCityViewControllerDelegate

protocol ChangeCityViewControllerDelegate : AnyObject {
    func changeCityViewController (_ editViewController: ChangeCityViewController, didChanged coordinate: Coordinates)
}

class ChangeCityViewController: UIViewController {
    
    //MARK: - Public variable delegate
    
    weak var delegate: ChangeCityViewControllerDelegate!
    
    //MARK: - Private variable
    
    private lazy var timer = Timer()
    private lazy var citiesData = [City]()
    private lazy var filterCitiesData = [City]()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchCtrlCity.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchCtrlCity.isActive && !searchBarIsEmpty
    }
    
    //MARK: - Private UI
    
    private lazy var tblCity: UITableView = {
        let tbl = UITableView()
        tbl.register(CityTblViewCell.self, forCellReuseIdentifier: CityTblViewCell.indificatorCell)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.dataSource = self
        tbl.delegate = self
        return tbl
    }()
    
    private lazy var searchCtrlCity: UISearchController = {
        let searchCtrl = UISearchController()
        searchCtrl.searchResultsUpdater = self
        searchCtrl.searchBar.placeholder = "Поиск города..."
        searchCtrl.searchBar.delegate = self
        searchCtrl.obscuresBackgroundDuringPresentation = false
        return searchCtrl
    }()
    
    // MARK: - Application lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSONCity()
        self.view.addSubview(tblCity)
        configureUI()
    }
    
    // MARK: - Private Func
    
    private func configureUI() {
        // TODO: The function is responsible and placement for the location UI
        definesPresentationContext = true
        self.view.backgroundColor = .white
        self.navigationItem.searchController = searchCtrlCity
        let csLefTblCity = NSLayoutConstraint(item: tblCity, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
        self.view.addConstraint(csLefTblCity)
        
        let csRighTblCity = NSLayoutConstraint(item: tblCity, attribute: NSLayoutConstraint.Attribute.right, relatedBy: .equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
        self.view.addConstraint(csRighTblCity)
        
        let csTopTblCity = NSLayoutConstraint(item: tblCity, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 80)
        self.view.addConstraint(csTopTblCity)
        
        let csBottomTblCity = NSLayoutConstraint(item: tblCity, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: .equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraint(csBottomTblCity)
    }
    
    private func parseJSONCity() {
        // TODO: The function is responsible for parsing the JSON file with cities and updates the data model
        DispatchQueue.global(qos: .userInitiated).sync {
            guard let path = Bundle.main.path(forResource: "russian-cities", ofType: "json") else {
                return
            }
            let url = URL(fileURLWithPath: path)
            do {
                let jsonData = try Data(contentsOf: url)
                let result = try JSONDecoder().decode([City].self, from: jsonData)
                self.citiesData = result
                DispatchQueue.main.async(execute: {
                    self.tblCity.reloadData()
                })
            }
            catch {
                DispatchQueue.main.async(execute: {
                    let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                })
            }
        }
    }
}

// MARK: - Extension ChangeCityViewController: Table delegate

extension ChangeCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterCitiesData.count
        }
        else {
            return citiesData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTblViewCell.indificatorCell, for: indexPath) as? CityTblViewCell else {
            return UITableViewCell()
        }
        if isFiltering {
            cell.fillTable(filterCitiesData[indexPath.row].subjectString, filterCitiesData[indexPath.row].nameString)
        }
        else {
            cell.fillTable(citiesData[indexPath.row].subjectString, citiesData[indexPath.row].nameString)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            delegate.changeCityViewController(self, didChanged: filterCitiesData[indexPath.row].coords)
            self.navigationController?.popViewController(animated: true)
        }
        else {
            delegate.changeCityViewController(self, didChanged: citiesData[indexPath.row].coords)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - Extension ChangeCityViewController: Search bar delegate

extension ChangeCityViewController: UISearchBarDelegate {
    
}

extension ChangeCityViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {[weak self] (_) in
            if let city = self?.citiesData {
                self?.filterCitiesData = city.filter({(city: City) -> Bool in
                    return city.name.lowercased().contains(searchText.lowercased()) || city.subject.lowercased().contains(searchText.lowercased())
                })
                self?.tblCity.reloadData()
            }
        })
    }
}
