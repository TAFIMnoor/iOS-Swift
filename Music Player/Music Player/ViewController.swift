//
//  ViewController.swift
//  Music Player
//
//  Created by mohammad noor uddin on 13/6/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = Model()
    var dataFromAPI: ResponseData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFromAPI = model.getAlbums()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Customize the navigation bar appearance
        self.navigationItem.title = "Music Gallery"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SongViewController
        destination.data = sender as? [String: Any]
    }
    
}


// Extension for Collection View methods

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numOfRows: Int = 0
        if let dataFromAPI = dataFromAPI {
            numOfRows = (section == 1 ? dataFromAPI.albums.count : dataFromAPI.specials.count)
        }
        return numOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // configure the cells
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
            
            cell.albumTitle.text = self.dataFromAPI?.albums[indexPath.row].name
            let imageUrl = (self.dataFromAPI?.asset_base_url)! + (self.dataFromAPI?.albumPath)! + (self.dataFromAPI?.albums[indexPath.row].thumb)!
            
            if let image = URL(string: imageUrl) {
                cell.albumImageView.sd_setImage(with: image)
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
            
            cell.albumTitle.text = self.dataFromAPI?.specials[indexPath.row].name
            let imageUrl = (self.dataFromAPI?.asset_base_url)! + (self.dataFromAPI?.albumPath)! + (self.dataFromAPI?.specials[indexPath.row].thumb)!
            
            if let image = URL(string: imageUrl) {
                cell.albumImageView.sd_setImage(with: image)
            }
            return cell
        }
        
    }
    
    /*
     
     For Dynamic/Device independent Cell : inset space, item space, line space
     
     Cell width :
     {collectionView width - (insetSpace * 2) - [itemSpace * (column.count - 1)]} / column.count
     
     Cell height : Cell width * Ratio inverse
     
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                        indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            let collectionViewWidth = (collectionView.bounds.size.width - (12.0 * 2) - 10.0 * 2.0) / 3.0
            let collectionViewHeight = collectionViewWidth * (284.0/189.0)
            
            return CGSize(width: collectionViewWidth, height: collectionViewHeight)
        }
        else {
            let collectionViewWidth = (collectionView.bounds.size.width - (12.0 * 2) - 10.0 * 2.0) / 2.0
            let collectionViewHeight = collectionViewWidth
            
            return CGSize(width: collectionViewWidth, height: collectionViewHeight)
        }
    }
    
//    if navigationController != nil {
//        navigationItem.title = "Albums"
//    } else {
//        navigationItem.title = (indexPath.section == 1 ?
//                        dataFromAPI?.albums[indexPath.row].name :
//                        dataFromAPI?.specials[indexPath.row].name)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionData = (indexPath.section == 1 ?
                           dataFromAPI?.albums[indexPath.row].songs :
                           dataFromAPI?.specials[indexPath.row].songs)
        let songData = [
            "asset_base_url": dataFromAPI?.asset_base_url ?? "",
            "albumPath": dataFromAPI?.albumPath ?? "",
            "songThumbPath": dataFromAPI?.songThumbPath ?? "",
            "songPath": dataFromAPI?.songPath ?? "",
            "songs": sectionData ?? ""
        ] as [String : Any]
        
        navigationItem.title = (indexPath.section == 1 ?
                        dataFromAPI?.albums[indexPath.row].name :
                        dataFromAPI?.specials[indexPath.row].name)
        
        performSegue(withIdentifier: "ToSongVC", sender: songData)
//        let songVc = storyboard?.instantiateViewController(withIdentifier: "asas") as? SongViewController
//        songVc?.data = songData;
//        navigationController?.pushViewController(songVc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! HeaderReusableView
            
            header.titleText = "ALL Categories"
            header.configure()
            return header
        }
        else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! HeaderReusableView
            
            header.titleText = "Best of the Week"
            header.configure()
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 50)
    }
    
}
