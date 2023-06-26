//
//  SongTableViewCell.swift
//  Music Player
//
//  Created by mohammad noor uddin on 17/6/23.
//

import UIKit
import AVFoundation

protocol TableCellDelegate: AnyObject {
    func didSelectCell(with flag: Bool)
    func copyButtonTapped()
    func downloadButtonTapped()
}

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var copyButton: UIButton!
    
    @IBOutlet weak var songImageView: UIImageView!
    
    @IBOutlet weak var songLabel: UILabel!
    
    @IBOutlet weak var descriptonContainerView: UIView!
    
    @IBOutlet weak var songDescription: UILabel!
    
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var heartButton: UIButton!
    
    var isPlaying: Bool = false
    var heartTapped: Bool = false
    var isDownloaded: Bool = true
    var dependend: Bool?
    weak var delegate: TableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        playPauseButton.isHidden = !selected
        downloadButton.isHidden = !selected
        heartButton.isHidden = !selected
        descriptonContainerView.isHidden = !selected
        if selected {
            contentView.backgroundColor = UIColor(red: 28.0/255.0, green: 29.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            songImageView.alpha = 0.5
            playPauseButton.setImage(UIImage(systemName: "Pause"), for: .normal)
        } else {
            contentView.backgroundColor = UIColor(red: 32.0/255.0, green: 34.0/255.0, blue: 38.0/255.0, alpha: 1.0)
            songImageView.alpha = 1.0
            playPauseButton.setImage(UIImage(systemName: "Play"), for: .normal)
        }
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        isPlaying.toggle()
        
        if isPlaying {
            updatePlayPauseButtonImage()
        }
        else {
            updatePlayPauseButtonImage()
        }
        
        delegate?.didSelectCell(with: isPlaying)
    }
    
    private func updatePlayPauseButtonImage () {
       // print(isPlaying)
        if isPlaying {
            playPauseButton.setImage(UIImage(named: "Play"), for: .normal)
        }
        else {
            playPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
        }
    }
    
    @IBAction func copyText(_ sender: UIButton) {
       // print("Tapped Copy")
        delegate?.copyButtonTapped()
    }
    
    @IBAction func downloadButtonTapped(_ sender: Any) {
        if isDownloaded {
            isDownloaded = false
            downloadButton.setImage(UIImage(named: "Use"), for: .normal)
            delegate?.downloadButtonTapped()
        }
    }
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        heartTapped.toggle()
        if heartTapped {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
