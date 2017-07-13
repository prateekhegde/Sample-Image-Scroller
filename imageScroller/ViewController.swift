//
//  ViewController.swift
//  imageScroller
//
//  Created by Prateek Hegde on 12/07/17.
//  Copyright © 2017 Prateek Hegde. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellID = "item"
    
   
    let imageArray1: [UIImage] = [UIImage(named: "1.jpg")!, UIImage(named: "2.jpg")!, UIImage(named: "3.jpg")!, UIImage(named: "4.jpg")!, UIImage(named: "5.jpg")!, UIImage(named: "6.jpg")!, UIImage(named: "7.jpg")!, UIImage(named: "8.jpg")!]
    
    let imageArray2: [UIImage] = [UIImage(named: "19.jpg")!, UIImage(named: "9.jpg")!, UIImage(named: "10.jpg")!, UIImage(named: "11.jpg")!, UIImage(named: "12.jpg")!, UIImage(named: "13.jpg")!]
    
    let imageArray3: [UIImage] = [UIImage(named: "14.jpg")!, UIImage(named: "15.jpg")!, UIImage(named: "16.jpg")!, UIImage(named: "17.jpg")!, UIImage(named: "18.jpg")!]
    
    let markerWidth: CGFloat = 155
    
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.gray
        return cv
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        setupControllers()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        navigationController?.navigationBar.backgroundColor = .clear
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupControllers(){
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        
    }
    
    func computeWidthAndHeight(image: UIImage) -> (CGFloat, CGFloat) {
        
        let screenWidth = collectionView.frame.width
        let ar = image.size.height/image.size.width
        
        var newImgWidth: CGFloat = 0
        var newImgHeight: CGFloat = 0
        var noOfImgsThatCanFit: CGFloat = 0
        
        if image.size.width > screenWidth{
            
            newImgWidth = screenWidth * 0.9
            newImgHeight = newImgWidth * ar * 0.9
            
            
        }
        else if image.size.width < screenWidth {
            
            noOfImgsThatCanFit = floor(screenWidth/image.size.width)
            newImgWidth = (screenWidth/noOfImgsThatCanFit) * 0.9
            newImgHeight = newImgWidth * ar * 0.9
            
        }
        
        return (newImgWidth, newImgHeight)
        
    }
    



    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let arrayOfarrays: [[UIImage]] = [imageArray1, imageArray2, imageArray3]
        return arrayOfarrays.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        let arrayOfarrays: [[UIImage]] = [imageArray1, imageArray2, imageArray3]
        
        var newImgWidth: CGFloat = 0
        var newImgHeight: CGFloat = 0
        //var noOfImgsThatCanFit: CGFloat = 0
        
        
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: view.frame.height))
        
        
        for i in 0 ... arrayOfarrays[indexPath.row].count-1 {
            
            let image = arrayOfarrays[indexPath.row][i]
            let imageView = UIImageView(image: image)
            
            
            imageView.frame = CGRect(x: CGFloat(i) * markerWidth, y: 0, width: markerWidth, height: 83)
            
            
            
            
            if i == 0 {
            
                (newImgWidth, newImgHeight) = computeWidthAndHeight(image: image)
                scrollView.contentSize = CGSize(width: CGFloat(arrayOfarrays[indexPath.row].count) * newImgWidth, height: newImgHeight)
            }
            
            imageView.frame = CGRect(x: CGFloat(i) * newImgWidth, y: 0.0, width: newImgWidth, height: newImgHeight)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
            
        }
        cell.contentView.addSubview(scrollView)
        //Resize View to fit superview
        
        cell.clipsToBounds = true
        
        return cell
    }
    
    
    



    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let arrayOfarrays: [[UIImage]] = [imageArray1, imageArray2, imageArray3]
       
        var newImgHeight: CGFloat = 0
        var newImgWidth: CGFloat = 0
        
        let image = arrayOfarrays[indexPath.row][0]
        //let imageView = UIImageView(image: image)
            
            
        //imageView.frame = CGRect(x: 0, y: 0, width: markerWidth, height: 83)
        //imageView.contentMode = .scaleAspectFill
        //imageView.clipsToBounds = true
            
            
        (newImgWidth, newImgHeight) = computeWidthAndHeight(image: image)
        
        
        return CGSize(width: collectionView.frame.width, height: newImgHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

}


