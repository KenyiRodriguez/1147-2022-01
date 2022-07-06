//
//  MoviesTabBarController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 6/07/22.
//

import UIKit

class MoviesTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [MoviesViewController.buildOnline(), MoviesViewController.buildLocal()]
    }
}

extension MoviesTabBarController {
    
    class func build() -> MoviesTabBarController {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MoviesTabBarController") as? MoviesTabBarController
        return controller ?? MoviesTabBarController()
    }
}
