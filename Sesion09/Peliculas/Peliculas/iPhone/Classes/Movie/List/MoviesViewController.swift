//
//  MoviesViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 1/06/22.
//

import UIKit

protocol MoviesViewProtocol: NSObjectProtocol {
    func didFilterWithResult(_ arrayData: [Any])
    func didSelectMovie(_ movie: Movie)
}

class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var tlvMovies: UITableView!
    @IBOutlet private weak var srcMovies: UISearchBar!
    
    lazy var listAdapter = ListMoviesAdapter(controller: self)
    lazy var searchAdapter = SearchMovieAdapter(controller: self)
    
    lazy var refreshControl: UIRefreshControl = {
        let resfresh = UIRefreshControl()
        resfresh.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return resfresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tlvMovies.addSubview(self.refreshControl)
        self.setupAdapters()
        self.getAllMovies()
    }
    
    @objc func pullToRefresh(_ sender: UIRefreshControl) {
        self.getAllMovies()
    }
    
    private func setupAdapters() {
        self.tlvMovies.dataSource = self.listAdapter
        self.tlvMovies.delegate = self.listAdapter
        self.srcMovies.delegate = self.searchAdapter
    }
    
    private func getAllMovies() {
        
        let ws = MovieWS()
        
        self.refreshControl.beginRefreshing()
        
        ws.getAllMovies { arrayMoviesDTO in
            
            self.refreshControl.endRefreshing()
            let arrayMovies = arrayMoviesDTO.toMovies
            
            self.listAdapter.arrayData = arrayMovies
            self.searchAdapter.arrayData = arrayMovies
            
            self.tlvMovies.reloadData()
        }
    }
}

extension MoviesViewController: MoviesViewProtocol {
    
    func didSelectMovie(_ movie: Movie) {
        print(movie.title)
    }
    
    func didFilterWithResult(_ arrayData: [Any]) {
        self.listAdapter.arrayData = arrayData
        self.tlvMovies.reloadData()
    }
}
