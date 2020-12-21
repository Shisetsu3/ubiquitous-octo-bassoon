//
//  LikeButton.swift
//  UI_Project
//
//  Created by  Shisetsu on 12.12.2020.
//

import UIKit

@IBDesignable class LikeButton: UIButton {
    
    @IBInspectable var likesCount:Int = 1
    @IBInspectable var selectedImg = UIImage(named: "heart_full")
    @IBInspectable var deselectedImg = UIImage(named: "heart_empty")
    
    @IBInspectable var textColorDeselected:UIColor = UIColor.lightGray
    @IBInspectable var textColorSelected:UIColor = UIColor.black
    
    @IBInspectable var active:Bool = false

    override func draw(_ rect: CGRect) {

        if active {
            like()
            likesCount -= 1
        } else {
            dislike()
        }
        
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    @objc func onPress() {
        print("Button Pressed")
        active = !active
        
        if active {
            like()
        } else {
            dislike()
        }
    }
    
    func like() {
        likesCount += 1
        self.setImage(selectedImg, for: .normal)
        self.setTitle("\(likesCount)", for: .normal)
        self.setTitleColor(textColorSelected, for: .normal)
    }
    
    func dislike() {
        likesCount -= 1
        self.setImage(deselectedImg, for: .normal)
        self.setTitle("\(likesCount)", for: .normal)
        self.setTitleColor(textColorDeselected, for: .normal)
    }

}
