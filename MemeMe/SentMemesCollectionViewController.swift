//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Krzysztof Maciążek on 28/03/16.
//  Copyright © 2016 kysieksoftware. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: SentMemesViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SentMemesCollectionViewController.didRotate(_:)), name:UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setFlowLayout()
    }
    
    func didRotate(notification: NSNotification) {
        setFlowLayout()
    }
    
    private func setFlowLayout() {
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2*space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension,dimension)
        collectionView.reloadData()
    }
}

extension SentMemesCollectionViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let memeDetailsCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("memeDetailsCollectionViewCell", forIndexPath: indexPath) as! MemeDetailsCollectionViewCell
        memeDetailsCollectionViewCell.memeImageView.image = dataSource[indexPath.row].memedImage
        return memeDetailsCollectionViewCell
    }
}
extension SentMemesCollectionViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("showMemeDetailsSegue", sender: dataSource[indexPath.row] as AnyObject)
    }
}