//
//  PhotoDetailViewController.swift
//  mvvm-project
//
//  Created by Abdallah Eid on 19/12/2021.
//

import UIKit
import Kingfisher

class PhotoDetailViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak private var largeImageView: UIImageView!
    
    var imageUrl: String?

    // MARK: - Initializations
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        super.init(nibName: "PhotoDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageUrl = imageUrl {
            largeImageView.kf.setImage(with: URL(string: imageUrl))
        }
    }

}
