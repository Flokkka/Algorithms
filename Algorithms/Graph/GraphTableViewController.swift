//
//  GraphTableViewController.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/1/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import UIKit

class GraphTableViewController: UITableViewController {
    
    private let graphPE = Graph()
    private let graphNE = Graph(canHaveNegativeEdges: true)
    private let graphAlgorithms: [GraphInterface] = [BFS(), Dijkstra(), BellmanFord()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GraphTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GraphTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SSSP"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return graphAlgorithms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as! GraphTableViewCell
        cell.nameLabel.text = graphAlgorithms[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToGraphVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? GraphViewController, segue.identifier == "goToGraphVC" {
            let row = tableView.indexPathForSelectedRow!.row
            destinationVC.graph = graphAlgorithms[row] is BellmanFord ? graphNE : graphPE
            destinationVC.algorithm = graphAlgorithms[row]
        }
    }
}
