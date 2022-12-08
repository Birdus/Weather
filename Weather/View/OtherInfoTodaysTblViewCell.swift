//
//  OtherWeatherInformationTblViewCell.swift
//  Weather
//
//  Created by Даниил Гетманцев on 28.11.2022.
//

import UIKit

class OtherInfoTodaysTblViewCell: UITableViewCell {
    
    // MARK: - Public satic Variables
    
    static let indificatorCell: String = "OtherInfoTodaysTblViewCell"
    
    // MARK: - Private Ui
    
    private lazy var lblPressure: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var lblHumidity: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var lblFeelsLike: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = .white
        return lbl
    }()
    
    // MARK: - Cell lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblPressure)
        contentView.addSubview(lblHumidity)
        contentView.addSubview(lblFeelsLike)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    internal func fillTable(_ pressure: String, _ humidity: String, _ feelsLike: String) {
        // TODO: The function is responsible for filling in the information table for additional weather information
        lblPressure.text = pressure
        lblHumidity.text = humidity
        lblFeelsLike.text = feelsLike
        configureUI()
    }
    
    // MARK: - Private func
    
    private func configureUI() {
        // TODO: The function is responsible and placement for the location UI
        let csLeftLblHumidity = NSLayoutConstraint(item: lblHumidity, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 20)
        self.addConstraint(csLeftLblHumidity)
        
        let csCentrYLblHumidity = NSLayoutConstraint(item: lblHumidity, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
        self.addConstraint(csCentrYLblHumidity)
        
        let csCentrYLblFeelsLike = NSLayoutConstraint(item: lblFeelsLike, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
        self.addConstraint(csCentrYLblFeelsLike)
        
        let csCentrXLblFeelsLike = NSLayoutConstraint(item: lblFeelsLike, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: -10)
        self.addConstraint(csCentrXLblFeelsLike)
        
        let csRightLblPressure = NSLayoutConstraint(item: lblPressure, attribute: NSLayoutConstraint.Attribute.right, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: -20)
        self.addConstraint(csRightLblPressure)
        
        let csCentrYLblPressure = NSLayoutConstraint(item: lblPressure, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0)
        self.addConstraint(csCentrYLblPressure)
    }
}
