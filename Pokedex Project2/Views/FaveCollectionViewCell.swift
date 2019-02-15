//
//  FaveCollectionViewCell.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/14/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

class FaveCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height - 20))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        label = UILabel(frame: CGRect(x: 0, y: contentView.frame.height - 15, width: contentView.frame.width, height: 15))
        label.textAlignment = .center
        contentView.addSubview(label)
    }
}
