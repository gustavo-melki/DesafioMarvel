//
//  HomeWorker.swift
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


class HomeWorker {
  let disposeBag = DisposeBag()
  
  func doSomeWork() {
    
    MarvelManager.getCharactersList().subscribe(onNext: { (result) in
      print(result.data?.results)
      
    }, onError: { (error) in
      print(error)
    }, onCompleted: {
      print("onCompleted")
    }).disposed(by: disposeBag)
    
  }
}