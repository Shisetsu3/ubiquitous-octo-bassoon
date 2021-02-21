//
//  CollectionViewController.swift
//  UI_Project
//
//  Created by  Shisetsu on 12.12.2020.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var userPhoto = [Size]()
    var avatar: UIImage!
    var userID: String!
    //var userGalery: [UIImage]!
    //var photoGallery = PhotoGallery().images
    
    
    var counts = 3
    var offset:CGFloat = 2.0
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = false
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "friendPhoto")
        self.collectionView!.register(UINib(nibName: "PhotoFullViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoFullViewCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FullScreenPhoto") as! FullScreenPhoto
        vc.userPhoto = userPhoto
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhoto.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoFullViewCell", for: indexPath) as! PhotoFullViewCell
        let photos = userPhoto[indexPath.row]
        let imageUrlString = photos.url
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        let imageName = UIImage(data: imageData)!
        
        cell.photoView.image = imageName
        //cell.photoView.image = photoGallery[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let photoFrame = collectionView.frame
        
        let widthFrame = photoFrame.width / CGFloat(counts)
        let heightFrame = widthFrame
        
        let spacing = CGFloat((counts + 1)) * offset / CGFloat(counts)
        
        return CGSize(width: widthFrame - spacing, height: heightFrame - (offset*2))
    }

}
