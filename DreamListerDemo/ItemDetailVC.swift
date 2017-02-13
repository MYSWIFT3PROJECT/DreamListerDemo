//
//  ItemDetailVC.swift
//  DreamListerDemo
//
//  Created by macOSX on 2/12/17.
//  Copyright © 2017 macOSX. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    var stores = [Store]()
    var itemToEdit:Item?
    var imagePicker:UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        
//        let store = Store(context: context)
//        store.name = "Best Buy"
//        let store1 = Store(context: context)
//        store1.name = "Tesla Dealership"
//        let store2 = Store(context: context)
//        store2.name = "Electorics"
//        let store3 = Store(context: context)
//        store3.name = "Amazon"
//        ad.saveContext()
        getStores()
        if itemToEdit != nil{
              loadItemData()
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = self.stores[row]
        return store.name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent: Int)->Int {
        return stores.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int){
        
    }
    func getStores(){
        let fetchRequest:NSFetchRequest<Store> = Store.fetchRequest()
        do{
            self.stores = try context.fetch(fetchRequest)
            self.pickerView.reloadAllComponents()
            
        }catch {
            //handle the error
        }
    }
    @IBAction func SavePressed(_ sender: UIButton) {
        var item:Item!
        
        if itemToEdit == nil{
            item = Item(context: context)
        }else{
            item = itemToEdit
        }
        
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text{
            item.price = (price as NSString).doubleValue
        }
        if let detail = detailField.text{
            item.detail = detail
        }
        item.toStore = stores[pickerView.selectedRow(inComponent: 0)]
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    func loadItemData(){
        if let  item = itemToEdit{
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailField.text = item.detail
            if let store = item.toStore{
                var index = 0
                repeat{
                let s = stores[index]
                if s.name == store.name{
                    pickerView.selectRow(index, inComponent: 0, animated: false)
                    break
                }
                index += 1
            }while(index < stores.count)
        }
    }
      
}
    @IBAction func deletePressed(_ sender: Any) {
        if itemToEdit != nil{
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImgePressed(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
           imagePickerView.image = img
        }
    }
    
    
    
    
        
        
}
