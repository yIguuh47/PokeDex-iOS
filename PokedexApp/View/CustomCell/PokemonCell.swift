//
//  PokemonCell.swift
//  PokedexApp
//
//  Created by Virtual Machine on 12/07/22.
//

import UIKit

class PokemonCell: UICollectionViewCell, RequestImageDelegate {
    
    
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonTextField: UILabel!
    
    var requestImage = RequestImagePokemons()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyShadow()
    }
    
    override func layoutSubviews() {
        pokemonView.layer.cornerRadius = 12

    }
    
    func applyShadow(){
        pokemonView.layer.masksToBounds = false
        pokemonView.layer.shadowRadius = 4.0
        pokemonView.layer.shadowOpacity = 0.60
        pokemonView.layer.shadowColor = UIColor.gray.cgColor
        pokemonView.layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func setupImageView(url: String) {
        requestImage.delegateImage = self
        requestImage.getImagePokemons(url: url)
    }
    
    func didConvertImageUrl(url: ImagePokemon) {
        DispatchQueue.main.async {
            do {
                let data = try Data.init(contentsOf: URL.init(string: String(url.front_default))!)
                
                self.pokemonImageView.image = UIImage(data: data)
            }
            catch {
                print("Erro image")
            }
        }
    }
}

