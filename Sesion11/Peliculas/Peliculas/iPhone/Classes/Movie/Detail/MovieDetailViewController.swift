//
//  MovieDetailViewController.swift
//  Peliculas
//
//  Created by Kenyi Rodriguez on 22/06/22.
//

import UIKit
import Alamofire

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var scrollContent: UIScrollView!
    @IBOutlet private weak var imgMovie: UIImageView!
    @IBOutlet private weak var imgMovieBackground: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblGenres: UILabel!
    @IBOutlet private weak var lblOverview: UILabel!
    @IBOutlet private weak var lblReleaseDate: UILabel!
    @IBOutlet private var arrayImages: [UIImageView]!
    
    private let webService = MovieWS()
    var idMovie: Int!
    
    @IBAction private func clickBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateData(_ movie: Movie) {
        
        self.lblTitle.text = movie.title
        self.lblReleaseDate.text = movie.releaseDateFormat
        self.lblGenres.text = movie.genresDescription
        self.lblOverview.text = movie.overview
        
        for (index, imageView) in self.arrayImages.enumerated() {
            imageView.image = index < movie.voteAverage ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        }
        
        let request = AF.request(movie.urlImage)
        request.response { dataResponse in
            guard let data = dataResponse.data else { return }
            let image = UIImage(data: data)
            self.imgMovie.image = image
            self.imgMovieBackground.image = image
        }
    }

    private func showLoading(_ isLoading: Bool) {
        self.scrollContent.isHidden = isLoading
    }
    
    private func getDetail() {
        
        self.showLoading(true)
        self.webService.getDetail(self.idMovie) { movieDTO in
            
            self.showLoading(false)
            self.updateData(movieDTO.toMovie)
            
        } error: { errorMessage in
            
            self.showLoading(true)
            print(errorMessage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgMovie.layer.cornerRadius = 10
        self.getDetail()
    }
}

extension MovieDetailViewController {
    
    class func buildWithIdMovie(_ idMovie: Int) -> MovieDetailViewController {
        
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        controller?.idMovie = idMovie
        return controller ?? MovieDetailViewController()
    }
}
