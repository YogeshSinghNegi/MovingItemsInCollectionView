//
//  MovingItemsInCollectionViewVC.swift
//  MovingItemsInCollectionView
//
//  Created by appinventiv on 31/08/17.
//  Copyright © 2017 yogesh singh negi. All rights reserved.
//

import UIKit

//=============================================================//
//MARK: MovingItemsInCollectionViewVC Class
//=============================================================//

class MovingItemsInCollectionViewVC: UIViewController {
    
//=============================================================//
//MARK: Stored Properties
//=============================================================//
    
    var nameArray = ["appinventiv logo","up arrow","down arrow","walt disney","gmail","group login","group logo","single user logo","password logo blue","password logo red","colors","self pic","password logo","add user logo","appinventiv logo","up arrow","down arrow","walt disney","gmail","group login","group logo","single user logo","password logo blue","password logo red","colors","self pic","password logo","add user logo"]
    
    var longPressGesture: UILongPressGestureRecognizer!
    
//=============================================================//
//MARK: Defining IBOutlet
//=============================================================//

    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
//=============================================================//
//MARK: View Methods
//=============================================================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewOutlet.delegate = self
        self.collectionViewOutlet.dataSource = self
        self.navigationItem.title = "Long Press and Rearrange"
    
//=============================================================//
//MARK: Long Press Gesture Recognizer
//=============================================================//
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture: )))
        self.collectionViewOutlet.addGestureRecognizer(longPressGesture)
        
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.collectionViewOutlet.indexPathForItem(at: gesture.location(in: self.collectionViewOutlet)) else {
                break
            }
            collectionViewOutlet.beginInteractiveMovementForItem(at: selectedIndexPath)
            
        case UIGestureRecognizerState.changed:
            collectionViewOutlet.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionViewOutlet.endInteractiveMovement()
            
        default:
            collectionViewOutlet.cancelInteractiveMovement()
        }
    }

}

//=============================================================//
//MARK: MovingItemsInCollectionViewVC Class Extension
//=============================================================//

extension MovingItemsInCollectionViewVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
//=============================================================//
//MARK: Setting Number Of Items
//=============================================================//
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return nameArray.count
    
    }
    
//=============================================================//
//MARK: Setting the Item
//=============================================================//
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "ClassForCell_ID", for: indexPath) as? ClassForCell else { fatalError() }
        
        cell.imageViewOutlet.image = UIImage(named: nameArray[indexPath.row])
       
        return cell
        
    }
    
//=============================================================//
//MARK: Setting the Item to Movable
//=============================================================//
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = nameArray[sourceIndexPath.row]
        nameArray.remove(at: sourceIndexPath.row)
        nameArray.insert(temp, at: destinationIndexPath.row)
        
    }

}

//=============================================================//
//MARK: Class for Cell UIView
//=============================================================//

class ClassForCell: UICollectionViewCell {
    
//=============================================================//
//MARK: CollectionView IBOutlet
//=============================================================//
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
}

