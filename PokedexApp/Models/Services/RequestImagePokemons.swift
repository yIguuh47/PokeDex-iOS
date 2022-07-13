//
//  RequestImagePokemons.swift
//  PokedexApp
//
//  Created by Virtual Machine on 13/07/22.
//

import Foundation

protocol RequestImageDelegate: NSObjectProtocol {
    func didConvertImageUrl(url: ImagePokemon)
}

class RequestImagePokemons {
    
    var delegateImage: RequestImageDelegate?
    
    func getImagePokemons(url: String) {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        let tarefa = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print("Error Task\(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            if httpResponse.statusCode >= 299 {
                print("Error Response\(error)")
                return
            }
            
            if let safeData = data {
                
                if let image = self.parseJSONImage(listData: safeData) {
                    self.delegateImage?.didConvertImageUrl(url: image)
                    return
                } else {
                    return
                }
            }
        }
        tarefa.resume()
    }
    
    func parseJSONImage(listData: Data) -> ImagePokemon? {
        let decoder = JSONDecoder()
        do {
            let decoderData =  try decoder.decode(PokemonDethails.self, from: listData)
            let results = decoderData.sprites
            return results
        } catch {
            print("Erro Decoder \(error)")
            return nil
        }
    }
}
