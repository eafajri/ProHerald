//
//  HomeScreenVC.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit

protocol HomeScreenVCInterface: class {
    func reloadCollectionView()
}

class HomeScreenVC: BaseViewController, HomeScreenVCInterface {
    private var interactor: HomeScreenInteractorInterface?
    private var router: HomeScreenRouter?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setup() {
        let viewController = self
        let interactor = HomeScreenInteractor()
        let presenter = HomeScreenPresenter()
        let router = HomeScreenRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    private func initView() {
        
    }
    
    // MARK:- Screen interface
    func reloadCollectionView() {
        
    }
}
