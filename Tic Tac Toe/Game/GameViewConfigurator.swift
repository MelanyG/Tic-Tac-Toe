//
//  GameViewConfigurator.swift
//  Tic Tac Toe
//
//  Created by Melany on 01.03.2022.
//

import UIKit

class GameViewConfigurator {
    var controller: UIViewController {
        return generateController()
    }
    
    func generateController() -> UIViewController {
     let presenter = GameViewPresenter()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: GameViewController.self)) as? GameViewController else {
            return UIViewController()
        }
        presenter.controller = viewController
        viewController.currentPresenter = presenter
        
        return viewController
    }
}
