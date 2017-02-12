//
//  ViewController.swift
//  DreamListerDemo
//
//  Created by macOSX on 2/13/17.
//  Copyright © 2017 macOSX. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate{
   
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var segementController:UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        attemFetch()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            return sections.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
            let sectioninfo = sections[section]
            return sectioninfo.numberOfObjects
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func configureCell(cell:ItemCell,indexPath:NSIndexPath){
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    func attemFetch(){
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        let dataSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dataSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        self.controller = controller
        do{
            try self.controller.performFetch()
        }catch{
            let error = error as NSError
            print("\(error)")
        }
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath{
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                //update mode a moment
               configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
        break
        case .move:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    
    
    
}

