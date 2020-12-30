//
//  TableViewCell.swift
//  UI_Project
//
//  Created by Shisetsu on 12.12.2020.
//

import UIKit

@IBDesignable class TableViewCell: UITableViewCell {
    
    @IBInspectable let opacityShadow:Float = 1
    @IBInspectable let radiusShadow:CGFloat = 8
    @IBInspectable let colorShadow:UIColor = .black
    
    @IBOutlet weak var friendLabel: UILabel!
    @IBOutlet weak var friendPhoto: UIImageView!
    @IBOutlet weak var surnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 4, y: 6, width: 48, height: 48))
        headerView.backgroundColor = .lightGray
        headerView.layer.cornerRadius = headerView.frame.height / 2
        headerView.layer.shadowOffset = CGSize.zero
        headerView.layer.shadowColor = colorShadow.cgColor
        headerView.layer.shadowOpacity = opacityShadow
        headerView.layer.shadowRadius = radiusShadow
        return headerView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(headerView)
    }
    
}

