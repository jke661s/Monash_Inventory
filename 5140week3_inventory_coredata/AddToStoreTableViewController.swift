//
//  AddToStoreTableViewController.swift
//  5140week3_inventory_coredata
//
//  Created by Jiaqi Wang on 12/8/17.
//  Copyright © 2017 Jiaqi Wang. All rights reserved.
//

import UIKit

class AddToStoreTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var productList: [Product] = []
    var store: Store?
    var pList: [ProductListLine] = []
    var pllExisting: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tableView.reloadData()
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
        return productList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddToStoreTableViewCell", for: indexPath) as! AddToStoreTableViewCell
        let p = productList[indexPath.row]
        
        cell.nameLabel.text = p.sName
        
        return cell
    }
    
    func getData(){
        do{
            productList = try context.fetch(Product.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            pList = try context.fetch(ProductListLine.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
        for productListLine in pList {
            if (productListLine.product == productList[indexPath.row] && productListLine.store == store){
                pllExisting = true
                //UPDATE
                productListLine.iNumber = productListLine.iNumber + 1
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                navigationController?.popViewController(animated: true)
            }
        }
        if pllExisting == false {
            let productListLine = ProductListLine(context: context)
            productListLine.iNumber = productListLine.iNumber + 1
            productListLine.store = store
            productListLine.product = productList[indexPath.row]
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    
}
