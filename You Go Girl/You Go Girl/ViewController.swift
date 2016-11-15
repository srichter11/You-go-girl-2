//
//  ViewController.swift
//  You Go Girl
//
//  Created by Sophia Richter on 11/12/16.
//  Copyright © 2016 Sophia Richter. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.dataSource=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var toDos = [NSManagedObject]()
    
    @IBOutlet weak var listTableView: UITableView!

    @IBAction func addItem(sender: AnyObject) {
        alert()
    }

// SET UP TABLE VIEW
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listItem")
        
        let person = toDos[indexPath.row]
        
        cell!.textLabel!.text =
            person.valueForKey("items") as? String
        return cell!
    }
 
    
// DELETE DATA
    

    
func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            managedContext.deleteObject(toDos[indexPath.row] )
            toDos.removeAtIndex(indexPath.row)
            do {
                try managedContext.save()
            } catch _ {
            }
            
            // remove the deleted item from the `UITableView`
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    
    
// FETCH FROM THE CORE DATABASE
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            toDos = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    
// ALERT POPUP TO ADD A NEW ITEM
    
    func alert() {
        let alert = UIAlertController(title:"Add a to do", message: "", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler{
            (textfield:UITextField) in
            textfield.placeholder = "Add a to do"
            
        }
        
        let add = UIAlertAction(title: "Add", style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                let textField = alert.textFields!.first
                self.saveName(textField!.text!)
                self.listTableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
// SAVE TO THE CORE DATABASE


    
    func saveName(items: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(items, forKey: "items")
        
        //4
        do {
            try managedContext.save()
            //5
            toDos.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }


}

