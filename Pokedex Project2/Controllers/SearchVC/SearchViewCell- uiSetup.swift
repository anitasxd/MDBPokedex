//
//  SearchViewCell- uiSetup.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/12/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let typecell = typesView.dequeueReusableCell(withReuseIdentifier: typesID, for: indexPath) as! SearchViewCell
        typecell.imageView.image = UIImage(named: pokemonTypes[indexPath.item].lowercased())
        typecell.textLabel!.text = pokemonTypes[indexPath.item].lowercased()
        return typecell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    
}
