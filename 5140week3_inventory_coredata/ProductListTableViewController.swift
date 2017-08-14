//
//  ProductListTableViewController.swift
//  5140week3_inventory_coredata
//
//  Created by Jiaqi Wang on 12/8/17.
//  Copyright © 2017 Jiaqi Wang. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {

    var products: [Product] = []
    var productSelected: Product?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        let p = products[indexPath.row]
        
        cell.nameLabel.text = p.sName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        productSelected = products[indexPath.row]
        performSegue(withIdentifier: "ProductDetailSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete{
            let p = products[indexPath.row]
            context.delete(p)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            getData()
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProductDetailSegue")  {
            let controller: ProductDetailViewController = segue.destination as! ProductDetailViewController
            controller.product = productSelected
        }
    }
    
    
    // Get data from database
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            products = try context.fetch(Product.fetchRequest())
        }
        catch{
            print("Fetching failed")
        }
    }
}
