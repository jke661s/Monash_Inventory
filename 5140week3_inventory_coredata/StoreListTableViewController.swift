//
//  StoreListTableViewController.swift
//  5140week3_inventory_coredata
//
//  Created by Jiaqi Wang on 12/8/17.
//  Copyright © 2017 Jiaqi Wang. All rights reserved.
//

import UIKit

class StoreListTableViewController: UITableViewController {
    
    var storeList: [Store] = []
    var storeSelected: Store?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getdata()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreListTableViewCell", for: indexPath) as! StoreListTableViewCell
        let store = storeList[indexPath.row]
        
        cell.nameLabel.text = store.sName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let store = storeList[indexPath.row]
            context.delete(store)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            getdata()
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "InStoreSegue"){
            let controller: InStoreTableViewController = segue.destination as! InStoreTableViewController
            controller.store = storeSelected
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        storeSelected = storeList[indexPath.row]
        performSegue(withIdentifier: "InStoreSegue", sender: self)
    }
    

    
    // Get data from database
    
    func getdata(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            storeList = try context.fetch(Store.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
        
    }


}
