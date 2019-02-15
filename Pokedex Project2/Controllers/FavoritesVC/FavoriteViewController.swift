//
//  FavoriteViewController.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/14/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    var profilePokemon: Pokemon!
    var favoritePokemon = [Pokemon]()
    var favoritePassed: Pokemon!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let saved = UserDefaults.standard.array(forKey: "favorites") as? Array<Int>
        
        pokemonAppend()
        collectionViewSetup()
        
    }
    
    func pokemonAppend(){
        favoritePokemon.append(favoritePassed)
    }
    
    func collectionViewSetup(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        self.collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        self.collectionView.backgroundColor = .white
        collectionView.dataSource = self as! UICollectionViewDataSource
        collectionView.delegate = self as! UICollectionViewDelegate
        self.view.addSubview(collectionView)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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


