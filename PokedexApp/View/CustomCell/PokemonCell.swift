//
//  PokemonCell.swift
//  PokedexApp
//
//  Created by Virtual Machine on 12/07/22.
//

import UIKit

class PokemonCell: UICollectionViewCell, RequestImageDelegate, RequestTypeDelegate {
    
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonTextField: UILabel!
    
    var requestImage = RequestImagePokemons()
    var requestType = RequestTypePokemons()
    
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
                print("Erro image\(url)")
            }
        }
    }
    
    func setupTypeView(url: String) {
        requestType.delegateType = self
        requestType.getTypePokemons(url: url)
    }
    
    func didTypePokemon(type: [TypePokemon]) {
        var color = getColorType(type: type[0].type.name)
        DispatchQueue.main.async {
            self.pokemonView.backgroundColor = color
        }
    }
    
    func getColorType(type: String) -> UIColor {
        switch type {
            case "grass": return hexStringToUIColor(hex: "#b9ef9d")
            case "fire": return hexStringToUIColor(hex: "#f1c8aa")
            case "water": return hexStringToUIColor(hex: "#c2d0f1")
            case "bug": return hexStringToUIColor(hex: "#e9efb7")
            case "poison": return hexStringToUIColor(hex: "#ecb8ec")
            case "electric": return hexStringToUIColor(hex: "#f5974c")
            case "ground": return hexStringToUIColor(hex: "#dccc9f")
            case "fairy": return hexStringToUIColor(hex: "#e7a9b7")
            case "fighting": return hexStringToUIColor(hex: "#dc6e68")
            case "psychic": return hexStringToUIColor(hex: "#F85888")
            case "rock": return hexStringToUIColor(hex: "#B8A038")
            case "ghost": return hexStringToUIColor(hex: "#705898")
            case "ice": return hexStringToUIColor(hex: "#98D8D8")
            case "dragon": return hexStringToUIColor(hex: "#7038F8")
            default: return hexStringToUIColor(hex:"#A8A878")
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}

