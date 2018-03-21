//
//  PageControlCell.swift
//  MovieBuzz
//
//  Created by Appinventiv on 27/02/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class PageControlCell: UITableViewCell {
    let bigMovieCell = ["LBogan","LCivilwar","LDarkknight","LHaider","LIronman","LLegion","LInception","LFida","LSherlockholmes","LPirates"]
    let smallMovieCell = ["LCivilwar","PAvengers","PBattleship","LInception","PHobbit","LSherlockholmes","LFida","PSpyder","PThedarknight","PThor"]
    let smallMovieCell2 = ["PAssassin'screed","LDarkknight","LHaider","PDeadpool","PHobbit","PJusticeleague","PMadmax","PSpyder","PThedarknight","PThor"]
    var section : Int?
    var row : Int?
    var pageControl : UIPageControl?
    var offSet: CGFloat = 0
    @IBOutlet weak var bigCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDataSourceDelegate()
        self.offSet = 0
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: --> Data source and delegate methods

extension PageControlCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    func setDataSourceDelegate(){
        self.bigCollectionView.dataSource = self
        self.bigCollectionView.delegate = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return bigMovieCell.count
        }
        else if section == 1{
            return smallMovieCell.count
        }
        else{
            return bigMovieCell.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bigCollectionCell", for: indexPath) as! BigCollectionCell
            cell.bigImageView.image = UIImage(named: bigMovieCell[indexPath.item])
            cell.pageControl.currentPage = indexPath.item
            pageControl?.addTarget(self, action: #selector(self.moveScrollViewToCurrentPage), for: .valueChanged)
            self.pageControl = cell.pageControl
            return cell
        }
            
        else if section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bigCollectionCell", for: indexPath) as! BigCollectionCell
            cell.bigImageView.image = UIImage(named: smallMovieCell[indexPath.item])
            cell.pageControl.isHidden = true
            return cell
        }
            
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bigCollectionCell", for: indexPath) as! BigCollectionCell
            cell.bigImageView.image = UIImage(named: smallMovieCell2[indexPath.item])
            cell.pageControl.isHidden = true
            return cell
        }
    }
    
    //MARK:--> Flow layout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if section == 0{
            let width = collectionView.frame.width
            return  CGSize(width: width, height: 180)
        }
        else if section == 1{
            let width = 0.24 * collectionView.frame.width
            let index = indexPath.item
            if index%3 == 0 {
                let width = 1.5 * width
                return CGSize(width: width , height: 115)
            }
            return CGSize(width: width , height: 115)
        }
        else if section == 2{
            let width = 0.5 * collectionView.frame.width
            let index = indexPath.item
            if index%3 == 0 {
                let width = 0.5 * width
                return CGSize(width: width , height: 115)
            }
            return CGSize(width: width , height: 115)
        }
        else {
            return CGSize(width: 0.24 * collectionView.frame.width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if self.section == 0 {
            return 0
        }
        else{
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if self.section == 0 {
            return 0
        }
        else{
            return 10
        }
    }
    
    //MARK: --> Methods for horizontal scrolling using page control
    @objc private func moveScrollViewToCurrentPage() {
        
        let pageNumber = pageControl?.currentPage
        var frame = bigCollectionView.frame
        frame.origin.x = ((frame.size.width) * CGFloat(pageNumber!))
        frame.origin.y = 0
        bigCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    @objc func autoScroll() {
        if section == 0{
            let totalPossibleOffset = CGFloat(bigMovieCell.count - 1) * self.bigCollectionView.bounds.size.width
            if offSet == totalPossibleOffset {
                offSet = 0           // come back to the first image after the last image
            }
            else {
                offSet += self.bigCollectionView.bounds.size.width
            }
            DispatchQueue.main.async() {
                UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                    self.bigCollectionView.contentOffset.x = CGFloat(self.offSet)
                }, completion: nil)
            }
        }
    }
}

