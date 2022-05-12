//
// 11/05/22
// SuperHeroViewController.swift File
//


import UIKit

class SuperHeroesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var superHeroes: [SuperHeroViewModel] = []
    var presenter: SuperHeroesInputPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SuperHeroCell", bundle: nil), forCellWithReuseIdentifier: "SuperHeroCell")
        
        presenter.fetchSuperHeroes()
        
        title = Localizable.superHeroesTitle
    }
}

extension SuperHeroesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperHeroCell", for: indexPath) as! SuperHeroCell
        cell.item = superHeroes[indexPath.row]
        return cell
    }
}

extension SuperHeroesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (collectionView.frame.width / 2) - 24
        return CGSize(width: w, height: 150)
    }
}

extension SuperHeroesViewController: SuperHeroesView {
    func display(_ superHeroes: [SuperHeroViewModel]) {
        self.superHeroes = superHeroes
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
