//
//  ViewController.swift
//  Weather
//
//  Created by Даниил Гетманцев on 25.11.2022.
//

import UIKit
import CoreLocation

class ShowWeatherViewController: UIViewController {
    
    //MARK: - Private variable
    
    private lazy var weatherCurrentManager = APIManagerWeather(apiKey: "3289f2248cd47b24b51852822b341164")
    private var currentWeather : CurrentWeather?
    private var weekWeather: [WeekWeather]?
    
    //MARK: - Private UI
    
    private lazy var tblWeather: UITableView = {
        let tbl = UITableView()
        tbl.register(TodaysWeatherTblViewCell.self, forCellReuseIdentifier: TodaysWeatherTblViewCell.indificatorCell)
        tbl.register(WeekWeatherTblViewCell.self, forCellReuseIdentifier: WeekWeatherTblViewCell.indificatorCell)
        tbl.register(OtherInfoTodaysTblViewCell.self, forCellReuseIdentifier: OtherInfoTodaysTblViewCell.indificatorCell)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.dataSource = self
        tbl.delegate = self
        tbl.allowsSelectionDuringEditing = false
        tbl.layer.backgroundColor = UIColor.clear.cgColor
        tbl.backgroundColor = .clear
        tbl.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tbl
    }()
    
    private lazy var btnEdit: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "+", style: UIBarButtonItem.Style.done, target: self, action: #selector(btnEdit_Click))
        btn.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 45),
            NSAttributedString.Key.foregroundColor : UIColor.white,
        ], for: .normal)
        return btn
    }()
    
    //MARK: - Private locationManager
    
    private lazy var locationManager: CLLocationManager = {
        let locManager = CLLocationManager()
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        return locManager
    }()
    
    // MARK: - Application lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tblWeather)
        configureUI()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    // MARK: - Privates action
    
    @objc
    private func btnEdit_Click(_ sender: UIBarButtonItem) {
        let vc:ChangeCityViewController = ChangeCityViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: - Private Func
    
    private func configureUI() {
        // TODO: The function is responsible and placement for the location UI
        self.navigationItem.rightBarButtonItem = btnEdit
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        setGradientBackground ()
        let csLeftTblWeather = NSLayoutConstraint(item: tblWeather, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0)
        self.view.addConstraint(csLeftTblWeather)
        
        let csRightTblWeather = NSLayoutConstraint(item: tblWeather, attribute: NSLayoutConstraint.Attribute.right, relatedBy: .equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0)
        self.view.addConstraint(csRightTblWeather)
        
        let csTopTblWeather = NSLayoutConstraint(item: tblWeather, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 75)
        self.view.addConstraint(csTopTblWeather)
        
        let csBottomTblWeather = NSLayoutConstraint(item: tblWeather, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: .equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraint(csBottomTblWeather)
    }
    
    private func setGradientBackground() {
        // TODO: The function is responsible for setting the background
        let colorTop = UIColor(red: 19.0/255.0, green: 177.0/255.0, blue: 237.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 9.0/255.0, green: 61.0/255.0, blue: 119.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.1]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func checekNeedReloadTblWeather() {
        // TODO: The function answers whether it is necessary to update the information in the weather table
        if currentWeather != nil && weekWeather != nil {
            DispatchQueue.main.sync(execute: {
                self.tblWeather.reloadData()
            })
        }
    }
    
    private func updateDataByCoord(_ coordinatesUser: Coordinates) {
        // TODO: The function is responsible for receiving and updating the data model
        self.weatherCurrentManager.fetchCurrentWeatherWith(coordinates: coordinatesUser) {[weak self] (result) in
            switch result {
            case  .Success(let currentWeather):
                self?.currentWeather = currentWeather
                self?.checekNeedReloadTblWeather()
            case .Failure(let error as NSError):
                DispatchQueue.main.async(execute:{
                    let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    self?.present(alertController, animated: true, completion: nil)
                })
            default: break
            }
        }
        
        self.weatherCurrentManager.fetchWeekWeatherWith(coordinates: coordinatesUser, completionHandler: {[weak self] (result) in
            for reultElements in result {
                switch reultElements {
                case  .SuccessArray(let weekWeather):
                    self?.weekWeather = weekWeather
                    self?.checekNeedReloadTblWeather()
                case .Failure(let error as NSError):
                    DispatchQueue.main.async(execute:{
                        let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)
                        self?.present(alertController, animated: true, completion: nil)
                        return
                    })
                default: break
                }
            }
        })
    }
}

// MARK: - Extension ViewController from UITableViewDataSource, UITableViewDelegate

extension ShowWeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weekWeather?.count ?? -2 + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TodaysWeatherTblViewCell.indificatorCell, for: indexPath) as?
                TodaysWeatherTblViewCell else {
                return UITableViewCell()
            }
            if let weather = currentWeather {
                cell.fillTable(weather.temperatureString, weather.tempMinMaxString, weather.city, weather.icon)
            }
            cell.selectionStyle = .none
            cell.layer.backgroundColor = UIColor.clear.cgColor
            cell.backgroundColor = .clear
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherInfoTodaysTblViewCell.indificatorCell, for: indexPath) as? OtherInfoTodaysTblViewCell else {
                return UITableViewCell()
            }
            cell.fillTable(currentWeather?.pressureString ?? "", currentWeather?.humidityString ?? "", currentWeather?.tempFilsLikeString ?? "")
            cell.selectionStyle = .none
            cell.layer.backgroundColor = UIColor.clear.cgColor
            cell.backgroundColor = .clear
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTblViewCell.indificatorCell, for: indexPath) as? WeekWeatherTblViewCell
            else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.layer.backgroundColor = UIColor.clear.cgColor
            cell.backgroundColor = .clear
            if let week = weekWeather {
                cell.fillTable(week[indexPath.row - 2].dateOfWeather, week[indexPath.row - 2].icon, week[indexPath.row - 2].temperatureString)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 230
        default:
            return 70
        }
    }
}

// MARK: - Extension ViewController from UISearchBarDelegate, UISearchResultsUpdating

extension ShowWeatherViewController: UISearchBarDelegate{
    
}

extension ShowWeatherViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
}

extension ShowWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        let coordinate = Coordinates(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
        updateDataByCoord(coordinate)
    }
}

extension ShowWeatherViewController: ChangeCityViewControllerDelegate {
    func changeCityViewController(_ editViewController: ChangeCityViewController, didChanged coordinate: Coordinates) {
        updateDataByCoord(coordinate)
    }
}
