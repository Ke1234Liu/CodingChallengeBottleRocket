//
//  RestaurantsMainViewController.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import UIKit

class RestaurantsMainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        collectionView.boundToSuperView()
        collectionView.register(RestaurantCollectionCell.self, forCellWithReuseIdentifier: RestaurantCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    private let mainViewModel: RestaurantsViewModel
    
    init(viewModel: RestaurantsViewModel = RestaurantsViewModel()) {
        self.mainViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not found")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainViewModel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        } errHandler: { [weak self] (err) in
            self?.displayErrorMessage(for: err)
        }
        self.mainViewModel.launchRestaurants()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    func displayErrorMessage(for error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(dismiss)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

extension RestaurantsMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCollectionCell.reuseIdentifier, for: indexPath) as? RestaurantCollectionCell else {
            return UICollectionViewCell()
        }
        cell.contentView.backgroundColor = (indexPath.item.isMultiple(of: 2)) ? .white : .gray
        cell.configure(with: self.mainViewModel.restaurantDetailViewModel(for: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainViewModel.count
    }
}

extension RestaurantsMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return CGSize(width: self.view.frame.width, height: 180)
        default:
            return CGSize(width: (self.view.frame.width - 5) / 2, height: 180)
        }
    }
}

extension RestaurantsMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = RestaurantInfoViewController(restaurantDetailViewModel: self.mainViewModel.restaurantDetailViewModel(for: indexPath.row)) else { return }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
