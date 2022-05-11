//
// 11/05/22
// SuperHeroViewController.swift File
//


import UIKit

class SuperHerosViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var superHeros: [SuperHeroViewModel] = []
    var presenter: SuperHerosInputPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SuperHeroCell", bundle: nil), forCellWithReuseIdentifier: "SuperHeroCell")
        
        presenter.fetchSuperHeros()
    }
}

extension SuperHerosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superHeros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperHeroCell", for: indexPath) as! SuperHeroCell
        cell.item = superHeros[indexPath.row]
        return cell
    }
}

extension SuperHerosViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (collectionView.frame.width / 2) - 24
        return CGSize(width: w, height: 150)
    }
}

extension SuperHerosViewController: SuperHerosView {
    func display(_ superHeros: [SuperHeroViewModel]) {
        self.superHeros = superHeros
        collectionView.reloadData()
        errorView.isHidden = true
        collectionView.isHidden = false
    }
    
    func display(_ error: ErrorViewModel) {
        errorLabel.text = error.message
        errorView.isHidden = false
        collectionView.isHidden = true
    }
}
