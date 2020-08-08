//
//  HomeScreenVC.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit

protocol HomeScreenVCInterface: class {
    func reloadCollectionView(displayedHeroes: [HeroDetailObject])
    func reloadRolesTableView(displayedRoles: [String])
}

class HomeScreenVC: BaseViewController, HomeScreenVCInterface {
    private enum Constant {
        static let title: String = "ProHerald - Dota2 Heroes"
        
        static let rolesTableCellIdentifier: String = "RoleCardTableViewCell"
        static let rolesTableCellHeaderTitle: String = "Select Role"
        static let rolesTableHeaderHeight: CGFloat = 36
        static let rolesTableViewWidth: CGFloat = 92
        
        static let heroesCollectionCellIdentifier: String = "HeroCardCollectionViewCell"
        static let heroesCollectionCellSizeRatio: CGFloat = 3 / 5 // height : width = 3 : 5
        static let heroesCollectionCellInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    class State {
        var displayedHeroes: [HeroDetailObject] = []
        var displayedRoles: [String] = []
        var selectedRolesIndex: Set = Set<String>()
    }
    
    private var screenState = State()
    
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
        
        tableView.register(RoleCardTableViewCell.self, forCellReuseIdentifier: Constant.rolesTableCellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    private lazy var heroesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(HeroCardCollectionViewCell.self, forCellWithReuseIdentifier: Constant.heroesCollectionCellIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
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
        
        reloadCollectionView(displayedHeroes: screenState.displayedHeroes)
    }
    
    private func setup() {
        let viewController = self
        let interactor: HomeScreenInteractor = HomeScreenInteractor()
        let presenter: HomeScreenPresenter = HomeScreenPresenter()
        let router: HomeScreenRouter = HomeScreenRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    private func initView() {
        title = Constant.title
        
        view.addSubview(rolesTableView)
        view.addSubview(heroesCollectionView)
        
        NSLayoutConstraint.activate([
            rolesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            rolesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rolesTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            rolesTableView.widthAnchor.constraint(equalToConstant: Constant.rolesTableViewWidth)
        ])
        
        NSLayoutConstraint.activate([
            heroesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            heroesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            heroesCollectionView.leftAnchor.constraint(equalTo: rolesTableView.rightAnchor),
            heroesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func calculateCollectionViewColumn() -> Int {
        if UIDevice.current.userInterfaceIdiom == .phone {
            if UIDevice.current.orientation.isLandscape {
                return 4
            } else {
                return 2
            }
        } else {
            if UIDevice.current.orientation.isLandscape {
                return 6
            } else {
                return 4
            }
        }
    }
    
    // MARK:- Screen interface
    func reloadCollectionView(displayedHeroes: [HeroDetailObject]) {
        numberOfCulomn = calculateCollectionViewColumn()
        screenState.displayedHeroes = displayedHeroes
        heroesCollectionView.reloadData()
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

// MARK:- table view delegate and datasource
extension HomeScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screenState.displayedRoles.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.rolesTableCellIdentifier, for: indexPath) as? RoleCardTableViewCell else {
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
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constant.rolesTableHeaderHeight))
        label.text = Constant.rolesTableCellHeaderTitle
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = .darkText
        label.textAlignment = .center
        label.backgroundColor = .groupTableViewBackground
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return 0 }
        
        return Constant.rolesTableHeaderHeight
    }
}

extension HomeScreenVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenState.displayedHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: HeroCardCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.heroesCollectionCellIdentifier, for: indexPath) as? HeroCardCollectionViewCell else {
                return UICollectionViewCell()
        }
        cell.name = screenState.displayedHeroes[indexPath.row].localizedName
        cell.image = screenState.displayedHeroes[indexPath.row].img
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - Constant.rolesTableViewWidth) / CGFloat(numberOfCulomn)
            - Constant.heroesCollectionCellInset.left
            - Constant.heroesCollectionCellInset.right
        
        let height = Constant.heroesCollectionCellSizeRatio * width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constant.heroesCollectionCellInset
    }
}
