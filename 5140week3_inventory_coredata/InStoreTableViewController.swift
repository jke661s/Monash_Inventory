//
//  InStoreTableViewController.swift
//  5140week3_inventory_coredata
//
//  Created by Jiaqi Wang on 12/8/17.
//  Copyright © 2017 Jiaqi Wang. All rights reserved.
//

import UIKit

class InStoreTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var store: Store?
    var productList: [ProductListLine] = []
    var currentStoreProductList: [ProductListLine] = []

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
        super.didReceiveMemoryWarning()    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentStoreProductList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InStoreTableViewCell", for: indexPath) as! InStoreTableViewCell
        let pll = currentStoreProductList[indexPath.row]
        cell.productLabel.text = "\(pll.iNumber) \(pll.product!.sName ?? "NAME") in \(pll.store!.sName ?? "STORE")"
        cell.numberLabel.text = "\(pll.iNumber)"
        cell.addButton.addTarget(self, action: #selector(InStoreTableViewController.addButtonTapped), for: .touchUpInside)
        cell.addButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(InStoreTableViewController.minusButtonTapped), for: .touchUpInside)
        cell.minusButton.tag = indexPath.row
        
        return cell
    }

    func addButtonTapped(sender: UIButton!){
        let pll = currentStoreProductList[sender.tag]
        
        pll.iNumber = pll.iNumber + 1
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        getData()
        tableView.reloadData()
    }
    
    func minusButtonTapped(sender: UIButton!){
        let pll = currentStoreProductList[sender.tag]
        pll.iNumber = pll.iNumber - 1
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        getData()
        tableView.reloadData()
        
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let pll = currentStoreProductList[indexPath.row]
            context.delete(pll)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            getData()
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "AddToStoreSegue"){
            let controller: AddToStoreTableViewController = segue.destination as! AddToStoreTableViewController
            controller.store = store
        }
    }
    
    func getData(){
        do{
            productList = try context.fetch(ProductListLine.fetchRequest())
            currentStoreProductList.removeAll()
            for productListLine in productList {
                if (productListLine.store == store){
                    currentStoreProductList.append(productListLine)
                }
            }
        }
        catch{
            print("Fetching failed")
        }
    }
}
