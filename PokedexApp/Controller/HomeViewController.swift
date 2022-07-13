//
//  ViewController.swift
//  PokedexApp
//
//  Created by Virtual Machine on 12/07/22.
//

import UIKit

class HomeViewController: UIViewController {

    var listPokemons: [ListModel] = []
    var imagePokemon: UIImage?
    var requestList = RequestListPokemons()

    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
        
        requestList.delegateList = self
        requestList.getListPokemons()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, RequestListPokemonsDelegate {
    
    func didListPokemons(list: [ListModel]) {
        listPokemons = list
        DispatchQueue.main.async {
            self.pokemonCollectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pokemonCollectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as! PokemonCell
        
        let pokemon = listPokemons[indexPath.row]
        
        cell.pokemonTextField.text = pokemon.name
        cell.setupImageView(url: pokemon.url)
        
        return cell
    }
    
    
}

