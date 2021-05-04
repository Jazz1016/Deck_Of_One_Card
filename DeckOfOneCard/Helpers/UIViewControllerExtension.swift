//
//  UIViewControllerExtension.swift
//  DeckOfOneCard
//
//  Created by Jared Warren on 12/18/19.
//  Copyright © 2019 Warren. All rights reserved.
//

import UIKit

// Recommend creating a snippet.
extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        
        // Feel free to customize the alert controller.
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
