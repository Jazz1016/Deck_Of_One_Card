//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by James Lea on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var cardValueAndSuitLabel: UILabel!
    
    @IBOutlet weak var cardUIImageView: UIImageView!
    
    @IBOutlet weak var drawNewButton: UIButton!
    @IBOutlet var UIView: UIView!
    // MARK: - Lifecrycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCard()
        self.drawNewButton.layer.cornerRadius = 10
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        
        gradientLayer.shouldRasterize = true
        
//        view.layer.insertSublayer(0, at: gradientLayer)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Properties
    
    var card: Card?
    
    // MARK: - Actions
    
    @IBAction func cardDrawButtonTapped(_ sender: Any) {
        fetchCard()
    }
    
    // MARK: - Functions
    
    func fetchCard(){
        
        CardController.fetchCard { (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let card):
                    self.card = card
                    self.fetchImage(card: card)
                    self.cardValueAndSuitLabel.text = "\(card.value) of \(card.suit)"
            
                case .failure(let error):
                    self.cardUIImageView.image = UIImage(named: "poo")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func fetchImage(card: Card?){
        
        CardController.fetchImage(url: card?.image) { (result) in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let image):
                    self.cardUIImageView.image = image
                
                
                case .failure(let error):
                    self.cardUIImageView.image = UIImage(named: "poo")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
                
            }
            
            
            
            
        }
        
        
    }
    
    
}//End of class
