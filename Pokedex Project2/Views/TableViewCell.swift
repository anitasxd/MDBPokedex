//
//  TableViewCell.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/13/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    var message : String?
    var mainimage : UIImage?
    
    var messageView : UILabel!
    
    var mainImageView : UIImageView!
    
    override func awakeFromNib() {
        mainImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        contentView.addSubview(mainImageView)

    }
    
    func initCellFrom(size: CGSize) {
        messageView = UILabel(frame: CGRect(x: size.width/4, y: 0, width: size.width/2, height: size.height))
        messageView.textAlignment = .center
        contentView.addSubview(messageView)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       /* mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true*/
        
 
        
        /*
        messageView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true*/
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let message = message {
            messageView.text = message
        }
        if let image = mainimage {
            mainImageView.image = image
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init has not been implementesd")
    }


}
