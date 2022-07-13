//
//  PokemonsModels.swift
//  PokedexApp
//
//  Created by Virtual Machine on 13/07/22.
//

import Foundation

struct Pokemons: Decodable {

    var results: [ListModel]

}

struct ListModel: Decodable {
    
    let name: String
    let url: String
    
}

struct PokemonDethails: Decodable {
    let sprites: ImagePokemon
}

struct ImagePokemon: Decodable {
    let front_default: String
}

