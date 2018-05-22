//
//  HomeRouter.swift
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

@objc protocol HomeRoutingLogic {
  func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
  var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
  weak var viewController: HomeViewController?
  var dataStore: HomeDataStore?
  
  // MARK: Routing
  
  func routeToSomewhere(segue: UIStoryboardSegue?) {
//    if let segue = segue {
//      let destinationVC = segue.destination as! DetailViewController
//      var destinationDS = destinationVC.router!.dataStore!
//      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//    } else {
//      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//      let destinationVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//      var destinationDS = destinationVC.router!.dataStore!
//      passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//      navigateToSomewhere(source: viewController!, destination: destinationVC)
//    }
  }

  // MARK: Navigation
  
  func navigateToDetailViewController(source: HomeViewController, destination: DetailViewController) {
    source.show(destination, sender: nil)
  }
  
   //MARK: Passing data
  
  func passDataToSomewhere(source: HomeDataStore, destination: inout DetailViewController) {
    //destination.name = source.name
  }
}
