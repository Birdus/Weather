//
//  TableViewCell.swift
//  Weather
//
//  Created by Даниил Гетманцев on 07.12.2022.
//

import UIKit

class CityTblViewCell: UITableViewCell {
    
    // MARK: - Public satic Variables
    
    static let indificatorCell: String = "CityTblViewCell"
    
    // MARK: - Private Ui
    
    private lazy var lblNameByCity: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    private lazy var lblSubjectByCity: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    // MARK: - Cell lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(lblNameByCity)
        contentView.addSubview(lblSubjectByCity)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    internal func fillTable(_ nameByCity: String, _ subjectByCity: String) {
        // TODO: The function is responsible for filling in the city information table
        lblNameByCity.text = nameByCity
        lblSubjectByCity.text = subjectByCity
        configureUI()
    }
    
    // MARK: - Private func
    
    private func configureUI() {
        // TODO: The function is responsible and placement for the location UI
        let csLeftLblNameByCity = NSLayoutConstraint(item: lblNameByCity, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 10)
        self.addConstraint(csLeftLblNameByCity)
        
        let csTopLblNameByCity = NSLayoutConstraint(item: lblNameByCity, attribute: NSLayoutConstraint.Attribute.top, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 10)
        self.addConstraint(csTopLblNameByCity)
        
        let csBottomLblSubjectByCity = NSLayoutConstraint(item: lblSubjectByCity, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: .equal, toItem: lblNameByCity, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 50)
        self.addConstraint(csBottomLblSubjectByCity)
        
        let csLeftLblSubjectByCity = NSLayoutConstraint(item: lblSubjectByCity, attribute: NSLayoutConstraint.Attribute.left, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 10)
        self.addConstraint(csLeftLblSubjectByCity)
    }
    
}
