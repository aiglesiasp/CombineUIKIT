//
//  TableViewControllerBoots.swift
//  CombineUIKit
//
//  Created by Aitor Iglesias Pubill on 6/12/22.
//

import UIKit
import Combine

class TableViewControllerBoots: UITableViewController {

    private var viewModel = viewModelBootcamps()
    
    private var suscriptor = Set<AnyCancellable>()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //el suscriptor
        viewModel.$bootCamps
            .sink { data in
                //lo que quieras con los datos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //self.tableView.reloadData()
            }
            .store(in: &suscriptor)
        
        //llamar a la crga
        viewModel.loadBootcamps()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.bootCamps.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        var content = cell.defaultContentConfiguration()
        content.text = self.viewModel.bootCamps[indexPath.row].name
        cell.contentConfiguration = content

        return cell
    }
    

    

}
