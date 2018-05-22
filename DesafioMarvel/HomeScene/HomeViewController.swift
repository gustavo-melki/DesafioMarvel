//
//  HomeViewController.swift
//  DesafioMarvel
//
//  Created by Gustavo Melki Leal on 17/05/2018.
//  Copyright (c) 2018 gustavoMelki. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift
import SDWebImage

protocol HomeDisplayLogic: class {
  func displayCharacters(viewModel: Home.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
  var interactor: HomeBusinessLogic?
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle

  
  override func viewDidLoad() {
    super.viewDidLoad()
    getCharacters()
  }
  
  // MARK: Do something
  

  @IBOutlet weak var collectionView: UICollectionView!
  
  
  var characters = [Character]()
  
  func getCharacters() {
    let request = Home.Request()
    interactor?.getCharacters(request: request)
  }
  
  func displayCharacters(viewModel: Home.ViewModel) {
    print(viewModel)
    characters = viewModel.characters
    self.collectionView.reloadData()
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return characters.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
    
    let url = URL(string: (characters[indexPath.row].thumbnail?.path)! + "/portrait_medium." + (characters[indexPath.row].thumbnail?._extension)!)
    
    cell.nameLabel.text = characters[indexPath.row].name
    cell.characterImage.sd_setImage(with: url!, completed: nil)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
  
  
}
