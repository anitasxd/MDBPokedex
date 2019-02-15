//
//  FavoriteSetupViewController.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/14/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//
import UIKit
class FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritePokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4 , height: collectionView.frame.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        
        let pokemon: Pokemon
        pokemon = favoritePokemon[indexPath.row]
        cell.label.text = "# \(pokemon.number!) " + pokemon.name
        
        guard let url = URL(string: pokemon.imageUrl) else {
            cell.imageView.image = UIImage(named: "block")
            return cell
        }
        do {
            let data: Data = try Data(contentsOf: URL(string: pokemon.imageUrl)!)
            cell.imageView.image = UIImage(data: data)
        } catch is Error {
            return cell
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profilePokemon = favoritePokemon[indexPath.row]
        UserDefaults.standard.set(favoritePokemon, forKey: "favorites")
        self.performSegue(withIdentifier: "toProfile", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let profile = segue.destination as? ProfileViewController{
            profile.selectedPokemon = profilePokemon
        }
    }
    
    
    
}

}
