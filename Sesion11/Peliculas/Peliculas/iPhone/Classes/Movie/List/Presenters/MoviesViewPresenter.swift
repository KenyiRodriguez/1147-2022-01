//
//  MoviesViewPresenter.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 6/07/22.
//

import Foundation

protocol MoviesViewPresenter {
    func didLoad()
    func willAppear()
    func pullToRefresh()
}
