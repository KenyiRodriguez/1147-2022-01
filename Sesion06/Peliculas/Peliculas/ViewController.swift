//
//  ViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 18/05/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let ws = MovieWS()
        ws.getAllMovies()
    }
}

