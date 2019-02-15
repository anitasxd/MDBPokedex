//
//  SearchViewController.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/10/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //pokemon array
    var pokemon: [Pokemon] = PokemonGenerator.getPokemonArray()
    var filteredT = [String]()
    var filteredPokemon = [Pokemon]()
    
    
    //types button and drop down
    let pokemonTypes = ["bug", "grass", "dark", "ground", "dragon", "ice", "electric", "normal", "fairy",
                 "poison", "fighting", "psychic", "fire", "rock", "flying", "steel", "ghost", "water"]
    
    var typesLabel: UILabel!
    var typesButton: UIButton!
    let typesView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = UIColor(hue: 0.9722, saturation: 1, brightness: 0.79, alpha: 1.0) /* #c90021 */
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        return collection
    }()
    let typesID = "typesID"
    
    //ui setup
    var banner : UIImageView!
    var searchButton: UIButton!
    var randomButton: UIButton!
    
    //search bar
    var searchBar : UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    
    //attributes
    var attributesLabel : UILabel!
    var attackLabel : UILabel!
    var defenseLabel : UILabel!
    var healthLabel : UILabel!
    var attackText : UITextField!
    var defenseText : UITextField!
    var healthText : UITextField!
    var attackMin : Int!
    var healthMin : Int!
    var defenseMin : Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //displayLabel()
        //setupTableView()
        uiSetup()
        searchBarSetup()
        typesSetup()
        typesView.delegate = self
        typesView.dataSource = self
        self.typesView.allowsMultipleSelection = true
        typesView.register(SearchViewCell.self, forCellWithReuseIdentifier: typesID)
        view.addSubview(typesView)
        typesGridSetup()
        attributesSetup()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    //UI Setup search and random button
    func uiSetup(){
        banner  =  UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 90))
        //banner.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 3)
        banner.image = UIImage(named: "banner")
        banner.contentMode = .scaleAspectFill
        banner.clipsToBounds = true
        view.addSubview(banner)
        
        searchButton = UIButton(frame: CGRect(x: 0, y: view.frame.height - 90, width: view.frame.width / 2, height: 40))
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = UIColor(hue: 0.9722, saturation: 1, brightness: 0.79, alpha: 1.0) /* #c90021 */
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        view.addSubview(searchButton)
        
        randomButton = UIButton(frame: CGRect(x: view.frame.height / 3 - 35, y: view.frame.height - 90, width: view.frame.width / 2, height: 40))
        randomButton.setTitle("Random", for: .normal)
        randomButton.backgroundColor = UIColor(hue: 0.9722, saturation: 1, brightness: 0.79, alpha: 1.0) /* #c90021 */
        randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
        view.addSubview(randomButton)
 
    }
    
    //searchBar
    func searchBarSetup(){
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 95, width: UIScreen.main.bounds.width, height: 40))
        view.addSubview(searchBar)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange textSearched: String)
    {
       
    }
    
    func slideViewDown() {
        UIView.animate(withDuration: 0.2, animations: {self.view.frame.origin.y = 0.0})
    }
    
    @objc func searchButtonPressed(sender: UIButton){
        //UserDefaults.standard.set(userScore, forKey: "Score")
        filteredPokemon.removeAll()
        attackMin = 0
        defenseMin = 0
        healthMin = 0
        if !((attackText.text?.isEmpty)!) {
            attackMin = Int(attackText.text!)
        }
        
        if !((defenseText.text?.isEmpty)!) {
            defenseMin = Int(defenseText.text!)
        }
        
        if !((healthText.text?.isEmpty)!) {
            healthMin = Int(healthText.text!)
        }
        filterPokemon()
        performSegue(withIdentifier: "toTableView", sender: self)
    }
    
    @objc func randomButtonPressed(sender: UIButton){
        filteredPokemon.removeAll()
        for index in 1...20 {
            var number = Int(arc4random_uniform(UInt32(800)))
            filteredPokemon.append(pokemon[number])
        }
        performSegue(withIdentifier: "toTableView", sender: self)
    }

    // types setup
    func typesSetup(){
        typesLabel = UILabel(frame: CGRect(x: 20, y: 140, width: view.frame.width - 40, height: 40))
        typesLabel.text = "Search by Type:"
        typesLabel.textColor = .black
        view.addSubview(typesLabel)
    }
    
    func typesGridSetup(){
        typesView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        typesView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        typesView.heightAnchor.constraint(equalToConstant: 175  ).isActive = true
        typesView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    //attributes setup
    func attributesSetup(){
        attributesLabel = UILabel(frame: CGRect(x: 20, y: view.frame.height / 2 + 40, width: view.frame.width - 40, height: 40))
        attributesLabel.text = "Search by Attribute:"
        attributesLabel.textColor = .black
        view.addSubview(attributesLabel)
        
        attackLabel = UILabel(frame: CGRect(x: 20, y: view.frame.height / 2 + 100 , width: view.frame.width - 40, height: 40))
        attackLabel.text = "Minimum Attack: "
        attackLabel.textColor = .black
        view.addSubview(attackLabel)
        
        defenseLabel = UILabel(frame: CGRect(x: 20, y: view.frame.height / 2 + 150 , width: view.frame.width - 40, height: 40))
        defenseLabel.text = "Minimum Defense: "
        defenseLabel.textColor = .black
        view.addSubview(defenseLabel)
        
        healthLabel = UILabel(frame: CGRect(x: 20, y: view.frame.height / 2 + 200, width: view.frame.width - 40, height: 40))
        healthLabel.text = "Minimum Health: "
        healthLabel.textColor = .black
        view.addSubview(healthLabel)
        
        
        attackText = UITextField(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2 + 100 , width: view.frame.width - 70 , height: 40))
        attackText.placeholder = "enter 1-200"
        //attackText.layer.borderColor = .black
        self.view.addSubview(attackText)
        
        defenseText = UITextField(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2 + 150 , width: view.frame.width - 70, height: 40))
        defenseText.placeholder = "enter 1-200"
        //defenseText.borderStyle = UITextBorderStyleRoundedRect;
        self.view.addSubview(defenseText)
        
        healthText = UITextField(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2 + 200 , width: view.frame.width - 40, height: 40))
        healthText.placeholder = "enter 1-200"
        //healthText.layer.borderColor = .black
        self.view.addSubview(healthText)
       
    }
    
    func filterPokemon(){
        filteredPokemon.removeAll()
        if (attackMin == 0 && healthMin == 0 && defenseMin == 0){
            for p in pokemon{
                for type in pokemonTypes{
                    for poketype in p.types {
                        if poketype.lowercased() == type {
                            filteredPokemon.append(p)
                        }
                    }
                }
                
            }
        }else if (filteredT.count == 0) {
            for p in pokemon{
                if (p.attack! >= attackMin && p.defense! >= defenseMin && p.health! >= healthMin){
                    filteredPokemon.append(p)
                }
                
            }
        } else {
            for p in pokemon{
                for type in pokemonTypes{
                    for poketype in p.types {
                        if (poketype.lowercased() == type && p.attack >= attackMin && p.defense >= defenseMin && p.health >= healthMin) {
                            filteredPokemon.append(p)
                        }
                    }
                }
                
            }
            
        }
        
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? PokemonViewController{
            vc.filteredP = filteredPokemon
        }
    }
    

}

