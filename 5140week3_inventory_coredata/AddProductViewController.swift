//
//  AddProductViewController.swift
//  5140week3_inventory_coredata
//
//  Created by Jiaqi Wang on 12/8/17.
//  Copyright © 2017 Jiaqi Wang. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    // Declare variables
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var manufacturerTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addProductButtonTapped(_ sender: Any) {

        if textFieldValidate(){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let product = Product(context: context)
            product.sName = nameTextField.text
            product.sDescription = descriptionTextField.text
            product.sManufacturer = manufacturerTextField.text
            product.dPrice = Double(priceTextField.text!)!
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            navigationController?.popViewController(animated: true)
        }
        
    }

    
    // Text Field Validation
    
    func textFieldValidate() -> Bool{
        let msg = "Please fill out all the fields!"
        
        if (nameTextField.text == "" && descriptionTextField.text == "" && manufacturerTextField.text == "" && priceTextField.text == ""){
            
            let alertController = UIAlertController(title: "ALert", message: msg, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController,animated: true, completion: nil)
            return false
            
        }
        else if Double(priceTextField.text!) != nil{
            
            return true
        }
        else{

            let msg1 = "Price must be a NUMBER!"
            let alertController = UIAlertController(title: "ALert", message: msg1, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController,animated: true, completion: nil)
            return false
        }
    }
}
