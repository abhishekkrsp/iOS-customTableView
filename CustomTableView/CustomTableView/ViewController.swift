//
//  ViewController.swift
//  CustomTableView
//
//  Created by Abhishek Kumar on 02/03/22.
//

import UIKit

class ViewController: UIViewController {

    let cellId = "cellId"
    var showIndexPaths = true
    var expandRows = true
    
    func someFunctionCall(cell :UITableViewCell) {
        print("inViewController")
        guard let indexTapped = tableView.indexPath(for: cell) else {
            return
        }
        print(indexTapped)
        let contact = twoDArray[indexTapped.section].names[indexTapped.row]
        let hasFavorite = contact.isFavorite
        twoDArray[indexTapped.section].names[indexTapped.row].isFavorite = !hasFavorite
        tableView.reloadRows(at: [indexTapped], with: .fade)
        
    }
    var twoDArray = [
        ExpandableNames(names: [ContactName(name: "A"), ContactName(name: "AB"), ContactName(name: "ABC"), ContactName(name: "ABCD")]),
        ExpandableNames(names: [ContactName(name: "B"), ContactName(name: "BC"), ContactName(name: "BCD"), ContactName(name: "BCDE")]),
        ExpandableNames(names: [ContactName(name: "C"), ContactName(name: "CD"), ContactName(name: "CDE"), ContactName(name: "CDEF")])
    ]
    
    override func loadView() {
        super.loadView()
        setupUI()
        setupConstraints()
        setupNav()
    }
    
    @objc func handleShowIndexPath() {
        var indexPathToReload = [IndexPath]()
        for section in twoDArray.indices {
            for row in twoDArray[section].names.indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathToReload.append(indexPath)
            }
        }
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableView.RowAnimation.right: UITableView.RowAnimation.left
        
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
    }
    func setupNav() {
        navigationItem.title = "Contacts"
        navigationController?
            .navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide/Show", style: .plain, target: self, action: #selector(handleShowIndexPath))
    }
    
    func setupUI() {
        view.addSubview(tableView)
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: 0)])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private let tableView: UITableView = {
        let someTableView = UITableView()
        someTableView.translatesAutoresizingMaskIntoConstraints = false
        return someTableView
    }()
}



extension ViewController: UITableViewDelegate {

    func go(to View: Int ) {
        print("go to index \(View)")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        go(to: indexPath.row)
    }
    
    
    @objc func handleExpandClose(for button: UIButton) {
        
        var indexPaths = [IndexPath]()
        let section = button.tag
        for index in twoDArray[section].names.indices {
            let indexPath = IndexPath(row: index, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = twoDArray[section].isExpanded
        twoDArray[section].isExpanded = !isExpanded
        button.setTitle(twoDArray[section].isExpanded ? "Close" : "Open", for: .normal)
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.tag = section
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return button
    }
}


extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDArray.count;
    }
    
    @objc private func handleFavorite(for button: UIButton) {
        print("clicked button")
        let indexTapped = button.tag
        let contact = twoDArray[0].names[indexTapped]
        let hasFavorite = contact.isFavorite
        twoDArray[0].names[indexTapped].isFavorite = !hasFavorite
        let indexTappedd = IndexPath(row: indexTapped, section: 0)
        tableView.reloadRows(at: [indexTappedd], with: .fade)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        cell.link = self
        let contact = twoDArray[indexPath.section].names[indexPath.row]
        cell.buttonFav.tintColor = contact.isFavorite ? .red : .lightGray
        if showIndexPaths {
            cell.name.text = twoDArray[indexPath.section].names[indexPath.row].name
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDArray[section].isExpanded ? twoDArray[section].names.count : 0
    }

}

