//
//  AddStoreViewController.swift
//  5140week3_inventory_coredata
//
//  Created by Jiaqi Wang on 12/8/17.
//  Copyright © 2017 Jiaqi Wang. All rights reserved.
//

import UIKit

class AddStoreViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func AddStoreButtonTapped(_ sender: Any) {
        if textFieldValidate(){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let store = Store(context: context)
            
            store.sName = nameTextField.text

            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func textFieldValidate() -> Bool{
        if (nameTextField.text == ""){
            let alertController = UIAlertController(title: "ALert", message: "Please enter a store name", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController,animated: true, completion: nil)
            return false
        }
        else{
            return true
        }
    }


}
