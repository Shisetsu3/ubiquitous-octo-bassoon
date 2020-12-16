//
//  FriendsTableController.swift
//  UI_Project
//
//  Created by  Shisetsu on 11.12.2020.
//

import UIKit

@IBDesignable class FriendsTableController: UITableViewController {
    
    @IBInspectable var opacity:Float = 0.5
    @IBInspectable var radius:CGFloat = 0
    @IBInspectable var color:UIColor = .gray
    
    
    let friends = ["Вася","Петя","Федор","Вова","Витя", "Вика", "Анна","Даша"]
    var friendPhoto = [UIImage(named: "Vasya.png"), UIImage(named: "Petya.png"), UIImage(named: "Fedor.png"), UIImage(named: "Vova.png"), UIImage(named: "Viktor.png"), UIImage(named: "Vika.png"), UIImage(named: "Anna.png"),  UIImage(named: "Dasha.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userFriends", for: indexPath) as! TableViewCellOnline
        cell.friendLabel.text = "\(self.friends[indexPath.row])"
        
        let imageName = friendPhoto[indexPath.row]
        
        let avatarView: UIView = UIView(frame: CGRect(x: 3, y: 2, width: 42, height: 42))
        let layer = CALayer()
        let image = imageName?.cgImage
        layer.frame = avatarView.bounds
        layer.contents = image
        avatarView.layer.addSublayer(layer)
        avatarView.layer.cornerRadius = avatarView.frame.width / 2

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 21, y: 21), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.gray.cgColor
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.lineWidth = 1.0

        let roundView = UIView(frame: CGRect(x: 4, y: 3, width: 40, height: 40))
        let circle = CALayer()
        circle.frame = roundView.bounds
        roundView.layer.addSublayer(circleLayer)
        roundView.backgroundColor = UIColor.gray
        roundView.alpha = 1
        roundView.layer.cornerRadius = roundView.frame.width / 2
        roundView.layer.shadowColor = color.cgColor
        roundView.layer.shadowOpacity = opacity
        roundView.layer.shadowRadius = radius
        roundView.layer.shadowOffset = CGSize.zero

        avatarView.layer.mask = circleLayer

        cell.contentView.addSubview(roundView)
        cell.contentView.addSubview(avatarView)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! CollectionViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            vc.userPhoto = friendPhoto[indexPath.row]
        }
    }
}
