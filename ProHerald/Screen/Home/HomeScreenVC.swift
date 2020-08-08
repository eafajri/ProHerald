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
    func reloadRolesTableView(displayedRoles: [String])
}

class HomeScreenVC: BaseViewController, HomeScreenVCInterface {
    class State {
        var displayedHeroes: [HeroDetailObject] = []
        var displayedRoles: [String] = []
        var selectedRolesIndex: Set = Set<String>()
    }
    
    var screenState = State()
    
    private enum Constant {
        static let rolesTableViewWidth: CGFloat = 92
    }
    
    private var interactor: HomeScreenInteractorInterface?
    private var router: HomeScreenRouter?
    
    private var numberOfCulomn: Int = 1
    
    private lazy var rolesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .groupTableViewBackground
        tableView.estimatedRowHeight = 36
        
        tableView.register(RoleCardTableViewCell.self, forCellReuseIdentifier: "RoleCardTableViewCell")
        
        return tableView
    }()
    
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
        
        initView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        numberOfCulomn = calculateCollectionViewColumn()
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
        title = "ProHerald - Dota2 Heroes"
        
        view.addSubview(rolesTableView)
        
        rolesTableView.dataSource = self
        rolesTableView.delegate = self
        
        NSLayoutConstraint.activate([
            rolesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            rolesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rolesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            rolesTableView.widthAnchor.constraint(equalToConstant: Constant.rolesTableViewWidth)
        ])
    }
    
    private func calculateCollectionViewColumn() -> Int {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if UIDevice.current.orientation.isLandscape {
                return 3
            } else {
                return 1
            }
        } else {
            if UIDevice.current.orientation.isLandscape {
                return 4
            } else {
                return 3
            }
        }
    }
    
    // MARK:- Screen interface
    func reloadCollectionView() {
        
    }
    
    func reloadRolesTableView(displayedRoles: [String]) {
        screenState.displayedRoles = displayedRoles
        rolesTableView.reloadData()
    }
    
    // MARK:- Tap action
    func onTapHeroRole(at indexPath: IndexPath) {
        let role = screenState.displayedRoles[indexPath.row]
        
        if screenState.selectedRolesIndex.contains(role) {
            screenState.selectedRolesIndex.remove(role)
        } else {
            screenState.selectedRolesIndex.insert(role)
        }
        
        rolesTableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension HomeScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenState.displayedRoles.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoleCardTableViewCell", for: indexPath) as? RoleCardTableViewCell else {
            return UITableViewCell()
        }
        
        cell.title = screenState.displayedRoles[indexPath.row]
        cell.isActive = screenState.selectedRolesIndex.contains(cell.title)
        cell.tapButton = { [weak self] in
            self?.onTapHeroRole(at: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 36))
        label.text = "Select role"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .darkText
        label.textAlignment = .center
        label.backgroundColor = .groupTableViewBackground

        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        
        return 36
    }
}
