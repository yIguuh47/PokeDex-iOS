//
//  RequestListPokemons.swift
//  PokedexApp
//
//  Created by Virtual Machine on 13/07/22.
//

import Foundation

protocol RequestListPokemonsDelegate: NSObjectProtocol {
    func didListPokemons(list: [ListModel])
}

class RequestListPokemons {
    
    var delegateList: RequestListPokemonsDelegate?
    let url = "https://pokeapi.co/api/v2/pokemon/?limit=100"
    
    func getListPokemons() {
        
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
                
                if let list = self.parseJSONList(listData: safeData) {
                    self.delegateList?.didListPokemons(list: list)
                    return
                } else {
                    return
                }
            }
            
        }
        tarefa.resume()
    }
    
    func parseJSONList(listData: Data) -> [ListModel]? {
        let decoder = JSONDecoder()
        do {
            let decoderData =  try decoder.decode(Pokemons.self, from: listData)
            let results = decoderData.results
            return results
        } catch {
            print("Erro Decoder \(error)")
            return nil
        }
    }
    
}

