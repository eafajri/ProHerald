//
//  HeroDetailScreenVC.swift
//  ProHerald
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit
import Kingfisher

protocol HeroDetailScreenVCInterface: class {
    func reloadTableView(relatedHeroes: [HeroDetailObject])
}

class HeroDetailScreenVC: BaseViewController, HeroDetailScreenVCInterface {
    private enum Constant {
        static let numberOfSection: Int = 4 // image, attributes, base state, related heroes
        static let sectionTitle: [String] = [
            "",
            "Roles",
            "Base States",
            "Related Heroes"
        ]
    }
    
    class State {
        var heroDetail: HeroDetailObject?
        var relatedHeros: [HeroDetailObject] = []
        var allHeros: [HeroDetailObject] = []
    }
    
    var screenState = State()
    
    private var interactor: HeroDetailScreenInteractor?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell1")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell2")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell3")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell4")
        
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
        
        interactor?.fetchRelatedHeroes(
            primaryAttribute: screenState.heroDetail?.primary_attr ?? "",
            allHeros: screenState.allHeros
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = screenState.heroDetail?.localizedName
    }
    
    private func setup() {
        let viewController = self
        let interactor: HeroDetailScreenInteractor = HeroDetailScreenInteractor()
        let presenter: HeroDetailScreenPresenter = HeroDetailScreenPresenter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func initView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    // MARK:- Screen interface
    func reloadTableView(relatedHeroes: [HeroDetailObject]) {
        screenState.relatedHeros = relatedHeroes
        
        tableView.reloadData()
    }
}

extension HeroDetailScreenVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.frame.width * 3 / 5
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constant.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 8
        case 3:
            return screenState.relatedHeros.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constant.sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let heroDetail: HeroDetailObject = screenState.heroDetail else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0: // image
            return getProfileCell(heroDetail: heroDetail, at: indexPath)
        case 1: // roles
            return getRolesCell(heroDetail: heroDetail, at: indexPath)
        case 2: // base states
            return getBaseStatesCell(heroDetail: heroDetail, at: indexPath)
        case 3: // similar heeros
            return getRelatedHeroCell(at: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    private func getProfileCell(heroDetail: HeroDetailObject, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
        
        let imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: 100, height: 200))
        imageView.kf.setImage(with: URL(string: "\(NetworkManager.shared.baseUrl)\(heroDetail.img ?? "")"))
        
        cell.backgroundView = imageView
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    private func getRolesCell(heroDetail: HeroDetailObject, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath)
        
        cell.textLabel?.text = "\(heroDetail.roles.joined(separator: ", "))"
        
        return cell
    }
    
    private func getBaseStatesCell(heroDetail: HeroDetailObject, at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell3", for: indexPath)        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Primary Attribute: \(heroDetail.primary_attr ?? "")"
        case 1:
            cell.textLabel?.text = "Agility: \(heroDetail.baseAgi ?? 0)"
        case 2:
            cell.textLabel?.text = "Inteligence: \(heroDetail.baseInt ?? 0)"
        case 3:
            cell.textLabel?.text = "Strength: \(heroDetail.baseStr ?? 0)"
        case 4:
            cell.textLabel?.text = "Health: \(heroDetail.baseHealth ?? 0)"
        case 5:
            cell.textLabel?.text = "Mana: \(heroDetail.baseMana ?? 0)"
        case 6:
            cell.textLabel?.text = "Speed: \(heroDetail.moveSpeed ?? 0)"
        case 7:
            cell.textLabel?.text = "Attack Type: \(heroDetail.attack_type ?? "")"
        default:
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    private func getRelatedHeroCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell4", for: indexPath)
        
        cell.textLabel?.text = screenState.relatedHeros[indexPath.row].localizedName
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}
