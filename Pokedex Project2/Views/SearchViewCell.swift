//
//  SearchViewCell.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/10/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

class SearchViewCell: UICollectionViewCell {
    let pokemonTypes = ["bug", "grass", "dark", "ground", "dragon", "ice", "electric", "normal", "fairy",
                        "poison", "fighting", "psychic", "fire", "rock", "flying", "steel", "ghost", "water"]
    
    
    var imageView: UIImageView!
    //var typeButton: UIButton!
    var textLabel: UILabel!
    var filteredType = [""]
    
    func createImageAndLabel() {
        
        imageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.layer.cornerRadius = 50
            image.backgroundColor = UIColor.white
            return image
        }()
    
        textLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.textColor = .black
            return label
        }()
    }
    func setupView(){
        createImageAndLabel()
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100  ).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: self.frame.width - 50).isActive = true
        
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override var isSelected: Bool{
        //Write your code for cell selection here
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.backgroundColor = UIColor.white
                self.imageView.isHidden = false
                filteredType.append(self.textLabel.text!)
            }
            else
            {
                self.transform = CGAffineTransform.identity
                self.contentView.backgroundColor = UIColor(hue: 0.9722, saturation: 1, brightness: 0.79, alpha: 1.0) /* #c90021 */
                self.imageView.isHidden = false
                filteredType.remove(at: filteredType.index(of: self.textLabel.text!)!)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let d = segue.destination as? SearchViewController{
            d.filteredT = filteredType
        }
    }

}

