//
//  SortingTableViewController.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class SortingTableViewController: UITableViewController {
    
    private let sortingAlgorithms: [SortInterface] = [InsertionSort(), SelectionSort(), BubbleSort(), QuickSort(), MergeSort(), HeapSort()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SortingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SortingTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comparison sorts"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortingAlgorithms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortingTableViewCell", for: indexPath) as! SortingTableViewCell
        cell.nameLabel.text = sortingAlgorithms[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToSingleSortingVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SortingViewController, segue.identifier == "goToSingleSortingVC" {
            destinationVC.algorithm = sortingAlgorithms[tableView.indexPathForSelectedRow!.row]
        }
    }
}
