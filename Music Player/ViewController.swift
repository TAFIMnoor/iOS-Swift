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
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 28.0/255.0, alpha: 1.0)

        self.view.backgroundColor = UIColor(red: 32.0/255.0, green: 34.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 182.0/255.0, green: 195.0/255.0, blue: 209.0/255.0, alpha: 1.0)]
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! SongViewController
        destination.data = sender as? [String: Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 25.0/255.0, green: 25.0/255.0, blue: 28.0/255.0, alpha: 1.0)

        self.view.backgroundColor = UIColor(red: 32.0/255.0, green: 34.0/255.0, blue: 38.0/255.0, alpha: 1.0)
        
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 182.0/255.0, green: 195.0/255.0, blue: 209.0/255.0, alpha: 1.0)]
        
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
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

            // Create the attributed string for the text above the underline
            let aboveText = NSMutableAttributedString(string: cell.albumTitle.text!)

            // Set the font attribute for the above text
            let font = UIFont.boldSystemFont(ofSize: 13)
            aboveText.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: aboveText.length))

            // Create the attributed string for the text beneath the underline
            let songCount = (self.dataFromAPI?.albums[indexPath.row].songs.count)!
            let beneathText = NSAttributedString(string: "\n\(songCount)+ Premium Music")
            
            aboveText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: aboveText.length))

            // Combine the attributed strings
            let attributedString = NSMutableAttributedString()
            attributedString.append(aboveText)
            attributedString.append(beneathText)


            // Apply the attributed string to your label
            cell.albumTitle.attributedText = attributedString
            
            let imageUrl = (self.dataFromAPI?.asset_base_url)! + (self.dataFromAPI?.albumPath)! + (self.dataFromAPI?.albums[indexPath.row].thumb)!
            
            if let image = URL(string: imageUrl) {
                cell.albumImageView.sd_setImage(with: image)
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
            
            let titleText = NSMutableAttributedString(string: (self.dataFromAPI?.specials[indexPath.row].name)!)
            
            let font = UIFont.boldSystemFont(ofSize: 18)
            titleText.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: titleText.length))
            
            cell.albumTitle.attributedText = titleText
            
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
        return UIEdgeInsets(top: 6.0, left: 17.0, bottom: 6.0, right: 17.0)
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
            let collectionViewWidth = (collectionView.bounds.size.width - (17.0 * 2) - 10.0 * 2.0) / 3.0
            let collectionViewHeight = collectionViewWidth * (399.0/338.0)
            
            return CGSize(width: collectionViewWidth, height: collectionViewHeight)
        }
        else {
            let collectionViewWidth = (collectionView.bounds.size.width - (17.0 * 2) - 10.0 * 1.0) / 2.0
            let collectionViewHeight = collectionViewWidth * (437.0/541.0)
            
            return CGSize(width: collectionViewWidth, height: collectionViewHeight)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sectionData = (indexPath.section == 1 ?
                           dataFromAPI?.albums[indexPath.row].songs :
                           dataFromAPI?.specials[indexPath.row].songs)
        
        let tableTitle = (indexPath.section == 1 ?
                        dataFromAPI?.albums[indexPath.row].name :
                        dataFromAPI?.specials[indexPath.row].name)
        
        
        let songData = [
            "asset_base_url": dataFromAPI?.asset_base_url ?? "",
            "albumPath": dataFromAPI?.albumPath ?? "",
            "songThumbPath": dataFromAPI?.songThumbPath ?? "",
            "songPath": dataFromAPI?.songPath ?? "",
            "tableTitle": tableTitle ?? "",
            "songs": sectionData ?? ""
        ] as [String : Any]
        
        performSegue(withIdentifier: "ToSongVC", sender: songData)
//        let songVc = storyboard?.instantiateViewController(withIdentifier: "asas") as? SongViewController
//        songVc?.data = songData;
//        navigationController?.pushViewController(songVc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! HeaderReusableView
            
            header.titleText = "All Categories"
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
