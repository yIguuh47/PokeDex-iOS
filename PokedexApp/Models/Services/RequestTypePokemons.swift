//
//  RequestTypePokemons.swift
//  PokedexApp
//
//  Created by Virtual Machine on 14/07/22.
//

import Foundation

protocol RequestTypeDelegate: NSObjectProtocol {
    func didTypePokemon(type: [TypePokemon])
}

class RequestTypePokemons {
    
    var delegateType: RequestTypeDelegate?
    
    func getTypePokemons(url: String) {
        
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
                
                if let type = self.parseJSONType(listData: safeData) {
                    self.delegateType?.didTypePokemon(type: type)
                    return
                } else {
                    return
                }
            }
        }
        tarefa.resume()
    }
    
    func parseJSONType(listData: Data) -> [TypePokemon]? {
        let decoder = JSONDecoder()
        do {
            let decoderData =  try decoder.decode(PokemonDethails.self, from: listData)
            let results = decoderData.types
            return results
        } catch {
            print("Erro Decoder \(error)")
            return nil
        }
    }
    
}
