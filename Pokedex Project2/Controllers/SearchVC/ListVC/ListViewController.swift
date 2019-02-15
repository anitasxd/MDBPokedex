//
//  ListViewController.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/13/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var backButton: UIButton!
    var filteredPokemon = PokemonGenerator.getPokemonArray()
    

    //views and segment control
    var collectionView: UICollectionView!
    var tableView: UITableView = UITableView()
    var segementControl: UISegmentedControl!
    
    override func viewDidload() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.frame = CGRect(x: 1, y: 1, width: view.frame.width, height: view.frame.height)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pokeCell")
        self.view.addSubview(tableView)
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokeCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        let pokemon: Pokemon
        pokemon = filteredPokemon[indexPath.row]
        
        pokeCell.textLabel!.text = pokemon.name
        
        return pokeCell
    }
    
}
