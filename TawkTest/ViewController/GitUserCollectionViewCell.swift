//
//  GitUserCellCollectionViewCell.swift
//  TawkTest
//
//  Created by JayR- Mac-mini on 8/30/21.
//

import UIKit

class GitUserCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var noteIndicator: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var borderView: UIView!
    
    var gitUser : GitUser? {
        didSet {
          titleLabel.text = gitUser?.login
          borderView.layer.borderWidth = 1
          borderView.layer.borderColor = UIColor.black.cgColor
          borderView.layer.cornerRadius = 8
        }
      }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
