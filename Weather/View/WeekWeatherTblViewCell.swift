//
//  WeekWeatherTblViewCell.swift
//  Weather
//
//  Created by Даниил Гетманцев on 28.11.2022.
//

import UIKit

class WeekWeatherTblViewCell: UITableViewCell {
    
    // MARK: - Public static Variables
    
    static let indificatorCell: String = "WeekWeatherTblViewCell"
    
    // MARK: - Private UI
    
    private lazy var lblNameOftheWeek: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var lblTempDayMinMax: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
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
        contentView.addSubview(lblNameOftheWeek)
        contentView.addSubview(lblTempDayMinMax)
        contentView.addSubview(imgWeather)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    internal func fillTable(_ nameOftheWeek: String,_ iconOfWeather: UIImage, _ tempDayMinMax: String) {
        // TODO: The function is responsible for filling in the weekly weather information table
        lblNameOftheWeek.text = nameOftheWeek
        lblTempDayMinMax.text = tempDayMinMax
        imgWeather.image = iconOfWeather
        configureUI()
    }
    
    // MARK: - Privates func
    
    private func configureUI() {
        // TODO: The function is responsible and placement for the location UI
        let csWidthImgWeather = NSLayoutConstraint(item: imgWeather, attribute: NSLayoutConstraint.Attribute.width, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 50)
        self.addConstraint(csWidthImgWeather)
        
        let csHeightImgWeather = NSLayoutConstraint(item: imgWeather, attribute: NSLayoutConstraint.Attribute.height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 50)
        self.addConstraint(csHeightImgWeather)
        
        let csCentrYImgWeather = NSLayoutConstraint(item: imgWeather, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
        self.addConstraint(csCentrYImgWeather)
        
        let csRightLblTempDayMinMax = NSLayoutConstraint(item: lblTempDayMinMax, attribute: NSLayoutConstraint.Attribute.right, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: -20)
        self.addConstraint(csRightLblTempDayMinMax)
        
        let csCenterYTempDayMinMax = NSLayoutConstraint(item: lblTempDayMinMax, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
        self.addConstraint(csCenterYTempDayMinMax)
        
        let csRightImgWeather = NSLayoutConstraint(item: imgWeather, attribute: NSLayoutConstraint.Attribute.right, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: -100)
        self.addConstraint(csRightImgWeather)
        
        let csLeftLblNameOftheWeek = NSLayoutConstraint(item: lblNameOftheWeek, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 20)
        self.addConstraint(csLeftLblNameOftheWeek)
        
        let csCenterYbLNameOftheWeek = NSLayoutConstraint(item: lblNameOftheWeek, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
        self.addConstraint(csCenterYbLNameOftheWeek)
    }
}
