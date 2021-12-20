//
//  ResultsViewController.swift
//  Counters
//
//  Created by Abner Abbey on 20/12/21.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    private struct Constants {
        static let cellID = "countCell"
        static let backgroundColor = UIColor(named: "Background")
        static let textColor = UIColor(named: "SecondaryText")
    }
    
    private let noResultsLabel: UILabel = .withConfig(.init(font: UIFont.systemFont(ofSize: 17, weight: .regular), textColor: Constants.textColor!))
    
    var viewModel: ResultsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        view.addSubview(noResultsLabel)
        noResultsLabel.centerAnchors(centerX: view.centerXAnchor, centerY: nil)
        noResultsLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 200, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 40))
        noResultsLabel.textAlignment = .center
        noResultsLabel.text = "No results"
        noResultsLabel.isHidden = true
        
        tableView.register(CountCell.self, forCellReuseIdentifier: Constants.cellID)
        tableView.separatorColor = .clear
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID) as? CountCell, let viewModel = viewModel else { return UITableViewCell() }
        cell.configure(withViewModel: viewModel[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}

extension ResultsViewController {
    
    
    
}
