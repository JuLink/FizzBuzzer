//
//  FizzBuzzListTableViewController.swift
//  FizzBuzzer
//
//  Created by Julien Lebeau on 23/02/2021.
//

import UIKit

class FizzBuzzListTableViewController: UITableViewController {
    static let storyboardId: String = "FizzBuzzListTableViewControllerID"
    static private let basicCellIdentifier: String = "BasicTableViewCellID"
    
    let viewModel: FizzBuzzListViewModel
    
    init?(coder: NSCoder, viewModel: FizzBuzzListViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with view model.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Result"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfElement
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Self.basicCellIdentifier) {
            cell.textLabel?.text = self.viewModel.string(for: indexPath)
            return cell
        }
        return UITableViewCell()
    }

}
