//
//  FoodPickerViewController.swift
//  FatSecretSampleApp
//
//  Created by Ilya Laryionau on 02/07/2018.
//  Copyright © 2018 larryonoff. All rights reserved.
//

import FatSecretSDK
import Result
import UIKit

private let cellId = "CellId"
private let showFoodSegueId = "ShowFood"

final class FoodPickerViewController: UIViewController {

    @IBOutlet private(set) weak var tableView: UITableView?
    @IBOutlet private(set) var searchController: UISearchController?

    private let fatSecretClient: FatSecretClient = {
        return (UIApplication.shared.delegate as! AppDelegate).fatSecretClient
    }()

    private var foods: [Food] = []

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        _setupSearchController()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, sender) {
        case (showFoodSegueId?, let food as Food):
            guard let foodViewController = segue.destination as? FoodViewController else {
                assertionFailure()
                return
            }

            foodViewController.food = food
        default:
            assertionFailure()
        }
    }

    // Setup

    private func _setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        } else {
            navigationItem.titleView = searchController.searchBar
        }

        definesPresentationContext = true

        self.searchController = searchController
    }
}

// MARK: - UISearchResultsUpdating

extension FoodPickerViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text

        fatSecretClient.searchFoods(
            searchText: searchText,
            completion: { [weak self] result in
                guard let `self` = self else { return }

                switch result {
                case let .success(response):
                    `self`.foods = response.foods
                case let .failure(error):
                    debugPrint(error)
                    `self`.foods = []
                }

                `self`.tableView?.reloadData()
            })
    }
}

// MARK: - UISearchBarDelegate

extension FoodPickerViewController: UISearchBarDelegate {
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
}

// MARK: - UITableViewDataSource

extension FoodPickerViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foods[indexPath.row]

        let cell = tableView
            .dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FoodPickerCell
        cell.item = food

        return cell
    }
}

extension FoodPickerViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let food = foods[indexPath.row]
        performSegue(withIdentifier: showFoodSegueId, sender: food)
    }
}
