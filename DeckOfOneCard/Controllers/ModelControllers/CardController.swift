//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by James Lea on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        guard let finalURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1") else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("<#CALL#> STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            
            do {
                let topLevel = try JSONDecoder().decode(TopLevelObject.self, from: data)
                
                guard let card = topLevel.cards.first else { return completion(.failure(.noData))}
                return completion(.success(card))
             } catch {
                
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
        
        
    }
    static func fetchImage(url: URL?, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        guard let url = url else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let image = UIImage(data: data) else {return completion(.failure(.noData))}
            completion(.success(image))
        }.resume()
    }
}
