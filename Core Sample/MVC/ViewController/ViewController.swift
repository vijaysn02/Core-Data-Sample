
//  GroceryViewController.swift

//  Copyright © 2020 Vijay. All rights reserved.


import Foundation
import UIKit

//MARK: - View Controller Initialization
class  GroceryViewController:UIViewController {
    
    let cellReuseIdentifier = "GroceryTableCell"
    let reUseNibName = "GroceryTableViewCell"
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notAvailableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseHandler.readGroceries()
        
        initialLabelSetup()
        initialViewSetup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
   
}

//MARK: - Initial View Setup
extension GroceryViewController {
    
    func initialLabelSetup() {
        notAvailableLabel.text = "No Grocery Available"
        if DatabaseHandler.groceries.count == 0 {
            self.notAvailableLabel.isHidden = false
        } else {
            self.notAvailableLabel.isHidden = true
        }
    }
    func initialViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        initialTableViewSetup()
    }
    func initialTableViewSetup() {
        self.tableView.register(UINib(nibName: reUseNibName, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
               
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.isScrollEnabled = false
        lineSeperatorSetup()
    }
    func lineSeperatorSetup() {
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = .white
    }
    
}

//MARK: - Button Actions
extension GroceryViewController {
    
     @IBAction func addGroceryButtonClicked(_ sender: Any) {
        addGrocery()
     }
     func addGrocery() {
         
         let alertController = UIAlertController(title:"Groceries",message: "Add your Item",preferredStyle: .alert)
         
         alertController.addTextField { (textField) in
             textField.placeholder = "Item Name"
         }
         
         alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (ok) in
             if let textField = alertController.textFields?.first {
                 if let grocery = textField.text {
                    if grocery == "" {
                        Toast.showasync(message: "No Items Added", controller: self)
                        return
                    }
                    DatabaseHandler.saveGrocery(name: grocery)
                    //DatabaseHandler.readGroceries()
                    self.reloadTableView()
                 } else {
                     Toast.showasync(message: "No Items Added", controller: self)
                 }
             }
         }))
         
         self.present(alertController, animated: true, completion: nil)

     }
    
}

//MARK: - Table View - show and hide
extension GroceryViewController {
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.notAvailableLabel.isHidden = true
        }
    }
    func hideTableView() {
        DispatchQueue.main.async {
            self.notAvailableLabel.isHidden = false
        }
    }
    
}

//MARK: - Table View Delegate and Source
extension GroceryViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatabaseHandler.groceries.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //TODO: - Adjust Row Height
        let rowHeight:CGFloat = 100
        return rowHeight
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,for: indexPath) as! GroceryTableViewCell

        let employee = DatabaseHandler.groceries[indexPath.row]
        cell.customTextLabel.text = employee.value(forKeyPath: "name") as? String
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected")
    }
    
}





