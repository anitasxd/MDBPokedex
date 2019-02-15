//
//  PokemonViewController.swift
//  Pokedex Project2
//
//  Created by Anita Shen on 2/14/19.
//  Copyright © 2019 Anita Shen. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var filteredP : [Pokemon]!
    var profilePokemon : Pokemon!
    
    
    //views and segment control
    var collectionView: UICollectionView!
    var tableView: UITableView!
    var segmentControl = UISegmentedControl(items: ["Table", "Grid"])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewSetup()
        segmentControlSetup()
    }
    
    func segmentControlSetup(){
        segmentControl.selectedSegmentIndex = 0
        segmentControl.setWidth(80, forSegmentAt: 0)
        segmentControl.setWidth(80, forSegmentAt: 1)
        segmentControl.addTarget(self, action: #selector(switchView), for: .valueChanged)
        navigationItem.titleView = segmentControl
     
    }
    
    func tableViewSetup(){
        self.tableView = UITableView(frame: CGRect(x: 10, y: 10, width: view.frame.width, height: view.frame.height))
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    func collectionViewSetup(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        self.collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        self.collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
    }
    
    @objc func switchView(){
        if segmentControl.selectedSegmentIndex == 0{
            tableViewSetup()
        }
        else{
            collectionViewSetup()
        }
        
    }
    
    @objc func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10 
        
    }
    
    @objc func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        
        for subview in cell.contentView.subviews{
            subview.removeFromSuperview()
        }
        

        cell.awakeFromNib()
        let size = CGSize(width: tableView.frame.width, height: view.frame.height / 10)
        cell.initCellFrom(size: size)
        
        let pokemon: Pokemon
        pokemon = filteredP[indexPath.row]
        cell.message = "# \(pokemon.number!) " + pokemon.name
     
        /*guard pokemon.imageURL  else {
            show("No address to submit")
            return
        }*/

        guard let url = URL(string: pokemon.imageUrl) else {
            cell.mainImageView.image = UIImage(named: "block")
            return cell
        }
        do {
            let data: Data = try Data(contentsOf: URL(string: pokemon.imageUrl)!)
            cell.mainImageView.image = UIImage(data: data)
        } catch is Error {
            return cell
        }
        return cell
        
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredP?.isEmpty == true{
            return 800
        }
        return filteredP.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profilePokemon = filteredP[indexPath.row]
        self.performSegue(withIdentifier: "toProfile", sender: self)
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
extension PokemonViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredP.count
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
        pokemon = filteredP[indexPath.row]
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
        profilePokemon = filteredP[indexPath.row]
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
