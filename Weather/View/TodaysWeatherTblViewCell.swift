//
//  WeatherTblViewCell.swift
//  Weather
//
//  Created by Даниил Гетманцев on 25.11.2022.
//

import UIKit

class TodaysWeatherTblViewCell: UITableViewCell {
    
    // MARK: - Public static Variables
    
    static let indificatorCell: String = "TodaysWeatherTblViewCell"
    
    //MARK: - Private UI
    
    private lazy var lblTempNow: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 60)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var lblTempDayMinMax: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var lblCity: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var imgWeather: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "clear-day.png")
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    // MARK: - Cell lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblTempNow)
        contentView.addSubview(imgWeather)
        contentView.addSubview(lblTempDayMinMax)
        contentView.addSubview(lblCity)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    internal func fillTable(_ tempNow: String, _ tempDayMinMax: String,_ city: String, _ iconOfWeather: UIImage) {
        // TODO: The function is responsible for filling in the table of information about the main information about today's weather
        lblTempNow.text = tempNow
        lblTempDayMinMax.text = tempDayMinMax
        lblCity.text = city
        imgWeather.image = iconOfWeather
        configureUI()
    }
    
    // MARK: - Privates func
    private func configureUI() {
        // TODO: The function is responsible and placement for the location UI
        let csWidthImgWeather = NSLayoutConstraint(item: imgWeather, attribute: NSLayoutConstraint.Attribute.width, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 200)
        self.addConstraint(csWidthImgWeather)
        
        let csHeightImgWeather = NSLayoutConstraint(item: imgWeather, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 200)
        self.addConstraint(csHeightImgWeather)
        
        let csRightImgWeather = NSLayoutConstraint(item: imgWeather, attribute: NSLayoutConstraint.Attribute.right, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: -20)
        self.addConstraint(csRightImgWeather)
        
        let csTopImgWeather = NSLayoutConstraint(item: imgWeather, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 10)
        self.addConstraint(csTopImgWeather)
        
        let csLeftLblTempIsNow = NSLayoutConstraint(item: lblTempNow, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 40)
        self.addConstraint(csLeftLblTempIsNow)
        
        let csTopLblTempIsNow = NSLayoutConstraint(item: lblTempNow, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 30)
        self.addConstraint(csTopLblTempIsNow)
        
        let csLeftLblTempDayMinMax = NSLayoutConstraint(item: lblTempDayMinMax, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 40)
        self.addConstraint(csLeftLblTempDayMinMax)
        
        let csTopLblTempDayMinMax = NSLayoutConstraint(item: lblTempDayMinMax, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: lblTempNow, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 5)
        self.addConstraint(csTopLblTempDayMinMax)
        
        let csLeftLblCity = NSLayoutConstraint(item: lblCity, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 40)
        self.addConstraint(csLeftLblCity)
        
        let csTopLblCity = NSLayoutConstraint(item: lblCity, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: lblTempDayMinMax, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 30)
        self.addConstraint(csTopLblCity)
    }
}
