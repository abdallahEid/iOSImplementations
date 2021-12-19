//
//  PhotoTableViewCell.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var downloadedImageView: UIImageView!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var labelContainerView: UIView!
    
    var model: PhotoTableViewCellModel? {
        didSet {
            bindData()
        }
    }
        
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        labelContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        downloadedImageView.contentMode = .scaleToFill
    }
    
    private func bindData() {
        
        guard let model = model else {
            return
        }
        
        dateLabel.text = model.date
        descriptionLabel.text = model.description
        nameLabel.text = model.name
        downloadedImageView.kf.setImage(with: URL(string: model.imageUrl))
    }
}
