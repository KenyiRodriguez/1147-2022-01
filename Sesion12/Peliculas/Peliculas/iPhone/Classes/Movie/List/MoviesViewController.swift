//
//  MoviesViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 1/06/22.
//

import UIKit

protocol MoviesViewProtocol: NSObjectProtocol {
    func reloadTableWithData(_ arrayData: [Any])
    func goToDetailMovie(_ movie: Movie)
    func setupAdapters()
    func addPullToRefresh()
    func showLoading(_ isShow: Bool)
    func reloadSearchWithData(_ arrayData: [Movie])
    func deleteMovieInSearch(_ movie: Movie)
}

//MARK: - Propiedades (Obligatorio)
class MoviesViewController: UIViewController {
    
    @IBOutlet private weak var tlvMovies: UITableView!
    @IBOutlet private weak var srcMovies: UISearchBar!
    
    private var listAdapter: ListMoviesAdapter!
    private var searchAdapter: SearchMovieAdapter!
    private var presenter: MoviesViewPresenter!
    
    lazy var refreshControl: UIRefreshControl = {
        let resfresh = UIRefreshControl()
        resfresh.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        return resfresh
    }()
}

//MARK: - Ciclo de vida del viewController - CONTRAPARTE
extension MoviesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.willAppear()
    }
}

//MARK: - Acciones del usuario (IBActions) - CONTRAPARTE
extension MoviesViewController {
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        self.presenter.pullToRefresh()
    }
}

//MARK: - Habilidades o capacidades (Obligatorio)
extension MoviesViewController: MoviesViewProtocol {
    
    func showLoading(_ isShow: Bool) {
        isShow ? self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
    }
    
    func deleteMovieInSearch(_ movie: Movie) {
        self.searchAdapter.deleteMovie(movie)
    }
    
    func addPullToRefresh() {
        self.tlvMovies.addSubview(self.refreshControl)
    }
    
    func setupAdapters() {
        self.listAdapter.setTableView(self.tlvMovies)
        self.searchAdapter.setSearchBar(self.srcMovies)
    }
    
    func goToDetailMovie(_ movie: Movie) {
        let controller = MovieDetailViewController.buildWithIdMovie(movie.id)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func reloadSearchWithData(_ arrayData: [Movie]) {
        self.searchAdapter.arrayData = arrayData
    }
    
    func reloadTableWithData(_ arrayData: [Any]) {
        self.listAdapter.arrayData = arrayData
        self.tlvMovies.reloadData()
    }
}

extension MoviesViewController {
    
    class func buildOnline() -> MoviesViewController {
        
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            return MoviesViewController()
        }
        
        controller.listAdapter = ListMoviesSimpleAdapter(controller: controller)
        controller.searchAdapter = SearchMovieAdapter(controller: controller)
        controller.presenter = MoviesViewOnlinePresenter(controller: controller)
        
        controller.tabBarItem.title = "Películas"
        controller.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        controller.tabBarItem.selectedImage = UIImage(systemName: "square.grid.2x2.fill")
        
        return controller
    }
    
    class func buildLocal() -> MoviesViewController {
        
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            return MoviesViewController()
        }
        
        controller.listAdapter = ListMoviesActionAdapter(controller: controller)
        controller.searchAdapter = SearchMovieAdapter(controller: controller)
        controller.presenter = MoviesViewLocalPresenter(controller: controller)
        
        controller.tabBarItem.title = "Favoritos"
        controller.tabBarItem.image = UIImage(systemName: "star")
        controller.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        return controller
    }
}
