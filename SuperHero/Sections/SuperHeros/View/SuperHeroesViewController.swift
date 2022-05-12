//
// 11/05/22
// SuperHeroViewController.swift File
//


import UIKit

class SuperHeroesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return refreshControl
    }()
    
    private var superHeroes: [SuperHeroViewModel] = []
    var presenter: SuperHeroesInputPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Localizable.superHeroesTitle
        
        setupView()
        refresh()
    }
    
    private func setupView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SuperHeroCell", bundle: nil), forCellWithReuseIdentifier: "SuperHeroCell")
        collectionView.refreshControl = refreshControl
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showOrderOptions))
    }
    
    @objc private func refresh() {
        presenter.fetchSuperHeroes()
    }
    
    
    @objc func showOrderOptions() {
        let actionSheet = makeActionSheetForOrderCases { [weak self] orderCase in
            self?.presenter.filter(by: orderCase)
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func removeHero(at cell: SuperHeroCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else {
            return
        }
        
        superHeroes.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
}

extension SuperHeroesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuperHeroCell", for: indexPath) as! SuperHeroCell
        cell.item = superHeroes[indexPath.row]
        cell.onRemoveCallback = { [weak self] cell in
            self?.removeHero(at: cell)
        }
        return cell
    }
}

extension SuperHeroesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var leftPadding = CGFloat(0)
        var rightPadding = CGFloat(0)
        var spaceBetweenCells = CGFloat(0)
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            spaceBetweenCells = flowLayout.minimumInteritemSpacing
            leftPadding = flowLayout.sectionInset.left
            rightPadding = flowLayout.sectionInset.right
        }
        
        let availableWidth = collectionView.frame.width - leftPadding - rightPadding - spaceBetweenCells
        let w = floor(availableWidth / 2)
        return CGSize(width: w, height: 280)
    }
}

extension SuperHeroesViewController: SuperHeroesView {
    
    func display(_ loading: LoadingViewModel) {
        if loading.loading {
            refreshControl.beginRefreshing()
        } else {
            refreshControl.endRefreshing()
        }
    }
    
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

extension SuperHeroesViewController {
    
    func makeActionSheetForOrderCases(optionSelected: @escaping (OrderCase) -> Void) -> UIAlertController {
        let actionSheetController = UIAlertController(title: Localizable.orderBy, message: nil, preferredStyle: .actionSheet)

        let higherIntelligence = UIAlertAction(title: Localizable.higherIntelligence, style: .default) { action -> Void in
            optionSelected(.higherIntelligence)
        }
        
        let lowerIntelligence = UIAlertAction(title: Localizable.lowerIntelligence, style: .default) { action -> Void in
            optionSelected(.lowerIntelligence)
        }

        let higherStrenght = UIAlertAction(title: Localizable.higherStrenght, style: .default) { action -> Void in
            optionSelected(.higherStrenght)
        }
        
        let lowerStrenght = UIAlertAction(title: Localizable.lowerStrenght, style: .default) { action -> Void in
            optionSelected(.lowerStrenght)
        }
        
        let higherSpeed = UIAlertAction(title: Localizable.higherSpeed, style: .default) { action -> Void in
            optionSelected(.higherSpeed)
        }
        
        let lowerSpeed = UIAlertAction(title: Localizable.lowerSpeed, style: .default) { action -> Void in
            optionSelected(.lowerSpeed)
        }

        let cancelAction: UIAlertAction = UIAlertAction(title: Localizable.cancel, style: .cancel) { action -> Void in }

        actionSheetController.addAction(higherIntelligence)
        actionSheetController.addAction(lowerIntelligence)
        actionSheetController.addAction(higherStrenght)
        actionSheetController.addAction(lowerStrenght)
        actionSheetController.addAction(higherSpeed)
        actionSheetController.addAction(lowerSpeed)
        actionSheetController.addAction(cancelAction)

        return actionSheetController
    }
}
