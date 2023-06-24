//
//  SongViewController.swift
//  Music Player
//
//  Created by mohammad noor uddin on 17/6/23.
//

import UIKit
import SDWebImage
import AVFoundation

class SongViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [String: Any]?
    var audioPlayer: AVPlayer?
    var songPath: String?
    var isPlaying: Bool = true
    var textToCopy: String?
    var cellTapped: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 56
       // tableView.backgroundColor = .black
        // Do any additional setup after loading the view.
    }
    
    
}

extension SongViewController: UITableViewDelegate, UITableViewDataSource, TableCellDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if let againData = data {
            rows = (againData["songs"] as? [Song])!.count
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        
        cell.delegate = self
        /*
         let songData = [
             "asset_base_url": dataFromAPI?.asset_base_url ?? "",
             "albumPath": dataFromAPI?.albumPath ?? "",
             "songThumbPath": dataFromAPI?.songThumbPath ?? "",
             "songPath": dataFromAPI?.songPath ?? "",
             "songs": dataFromAPI?.albums[indexPath.row].songs ?? ""
         ]
         */
        let songCollections = self.data!["songs"] as? [Song]
        cell.songLabel.text = songCollections![indexPath.row].name
        cell.songDescription.text = songCollections![indexPath.row].description
        var imageURL = (data!["asset_base_url"] as? String)!
            imageURL = imageURL + (data!["songThumbPath"] as? String)!
            imageURL = imageURL + (songCollections?[indexPath.row].thumb)!
        
        if let image = URL(string: imageURL) {
            cell.songImageView.sd_setImage(with: image)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.beginUpdates()
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.endUpdates()
        
        let dict = self.data!["songs"] as? [Song]
        var songPath = (self.data!["asset_base_url"] as? String)!
            songPath = songPath + (self.data!["songPath"] as? String)!
            songPath = songPath + dict![indexPath.row].file
        
        let cell = tableView.cellForRow(at: indexPath) as! SongTableViewCell
        let check = dict![indexPath.row].description
        if (check.isEmpty) {
            cell.descriptonContainerView.isHidden = true
        } else {
            cell.descriptonContainerView.isHidden = false
        }
        if self.cellTapped {
            self.cellTapped = false
            cell.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        else {
            self.cellTapped = true
            cell.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        textToCopy = dict![indexPath.row].description
        self.songPath = songPath
        playSong(with: songPath)
        
    }
    
    func didSelectCell(with flag: Bool) {
        self.isPlaying = flag
        playSong(with: songPath!)
    }
    
    func copyButtonTapped() {
        UIPasteboard.general.string = textToCopy ?? ""
    }
    
    func downloadButtonTapped() {
        
        if let url = URL(string: self.songPath!) {
            URLSession.shared.downloadTask(with: url) { (location, responds, error) in
                guard let location = location else {
                    print(error as Any)
                    return
                }
                
                let destinationURL = self.getDestinationURL()
                
                print(destinationURL)
                
                do
                {
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    DispatchQueue.main.async {
                        print("Song Downloaded SuccessFully")
                    }
                }
                catch
                {
                    print(error.localizedDescription)
                }
                
            }.resume()
        }
        
    }
    
    private func getDestinationURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let filname = "downloadedSong_\(Date().timeIntervalSince1970).mp3"
        let destinationURL = documentsDirectory.appendingPathComponent(filname)
        return destinationURL
    }
    
    func playSong(with songPath: String){
        
        guard let songURL = URL(string: songPath) else {
            return // Invalid Song URL
        }
        // is there a song playing already?
        if let player = audioPlayer {
            // is it different
            if let currentURL = player.currentItem?.asset as? AVURLAsset, currentURL.url != songURL {
                audioPlayer?.pause()
                let playerItem = AVPlayerItem(url: songURL)
                audioPlayer = AVPlayer(playerItem: playerItem)
                audioPlayer?.play()
            } else {
                // same song, do nothing for now
                if isPlaying {
                    isPlaying = false
                    audioPlayer?.pause()
                } else {
                    isPlaying = true
                    audioPlayer?.play()
                }
            }
        }
        else {
            let playerItem = AVPlayerItem(url: songURL)
            audioPlayer = AVPlayer(playerItem: playerItem)
            audioPlayer?.play()
        }
    }
    
    // for auotmated height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
