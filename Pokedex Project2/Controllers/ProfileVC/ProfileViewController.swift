//
//  ProfileViewController.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/14/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var selectedPokemon : Pokemon!
    var imageP : UIImageView!
    var name : UILabel!
    var species : UILabel!
    var type : UILabel!
    var hp : UILabel!
    var attack : UILabel!
    var defense : UILabel!
    
    var favoriteButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        uiSetup()
        favoriteSetup()
        
    }
    
    func uiSetup(){
        imageP  =  UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width / 1.3, height: view.frame.width / 1.3))
        imageP.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 3)
        imageP.contentMode = .scaleAspectFit
        imageP.clipsToBounds = true
        imageP.image = getImageForPokemon(selectedPokemon: selectedPokemon)
        view.addSubview(imageP)
        
        name = UILabel(frame: CGRect(x: 10, y: 400, width: view.frame.width, height: 100))
        name.text = "# \(selectedPokemon.number!) " + selectedPokemon.name
        name.font = UIFont(name: "CourierNewPS-BoldMT", size: 24)
        name.textAlignment = .center
        view.addSubview(name)
        
        type = UILabel(frame: CGRect(x: 10, y: 440, width: view.frame.width, height: 100))
        type.text = "Type: \(selectedPokemon.types)"
        type.font = UIFont(name: "CourierNewPS-BoldMT", size: 24)
        type.textAlignment = .center
        view.addSubview(type)
        
        species = UILabel(frame: CGRect(x: 10, y: 480, width: view.frame.width, height: 100))
        species.text = "Species: " + selectedPokemon.species
        species.font = UIFont(name: "CourierNewPS-BoldMT", size: 24)
        species.textAlignment = .center
        view.addSubview(species)
        
        hp = UILabel(frame: CGRect(x: 10, y: 520, width: view.frame.width, height: 100))
        hp.text = "HP: \(selectedPokemon.health!)"
        hp.font = UIFont(name: "CourierNewPS-BoldMT", size: 24)
        hp.textAlignment = .center
        view.addSubview(hp)
        
        attack = UILabel(frame: CGRect(x: 10, y: 560, width: view.frame.width, height: 100))
        attack.text = "Attack: \(selectedPokemon.attack!)"
        attack.font = UIFont(name: "CourierNewPS-BoldMT", size: 24)
        attack.textAlignment = .center
        view.addSubview(attack)
        
        defense = UILabel(frame: CGRect(x: 10, y: 600, width: view.frame.width, height: 100))
        defense.text = "Defense: \(selectedPokemon.defense!)"
        defense.font = UIFont(name: "CourierNewPS-BoldMT", size: 24)
        defense.textAlignment = .center
        view.addSubview(defense)
    }
    
    func getImageForPokemon(selectedPokemon: Pokemon!) -> UIImage {
        let url = URL(string: selectedPokemon.imageUrl)
            do {
                let data = try Data(contentsOf: url!)
                return UIImage(data: data)!
                    
            }
            catch _{
                return UIImage(named: "block")!
                }
    }
    
    func favoriteSetup(){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "favorites-button"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.rightBarButtonItems = [item1]
    }
    
    @objc func favoriteButtonPressed(sender: UIButton){
        performSegue(withIdentifier: "toFavorites", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let f = segue.destination as? FavoriteViewController{
            f.favoritePassed = selectedPokemon
        }
    }
    

}
