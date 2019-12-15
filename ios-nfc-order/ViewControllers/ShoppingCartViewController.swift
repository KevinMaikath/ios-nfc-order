//
//  ShoppingCartViewController.swift
//  ios-nfc-order
//
//  Created by alumno on 14/12/2019.
//  Copyright © 2019 alumno. All rights reserved.
//

import UIKit
import CoreNFC

class ShopItemCell: UITableViewCell {
    
    
    @IBOutlet weak var shopItemName: UILabel!
    @IBOutlet weak var shopItemQuantity: UILabel!
    @IBOutlet weak var shopItemPrice: UILabel!
    
    var addButtonAction: (() -> ())?
    var removeButtonAction: (() -> ())?
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addButtonAction?()
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        removeButtonAction?()
    }
    
}


class ShoppingCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NFCNDEFReaderSessionDelegate {
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var nfcSession: NFCNDEFReaderSession?
    
    var model: ShoppingCartModel = ShoppingCartModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.totalPriceLabel.text = "$\(model.totalPrice ?? 0)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.nfcSession = nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getCartListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopItemCell", for: indexPath) as! ShopItemCell
        
        let shopItem = model.cartList?[indexPath.row]
        cell.shopItemName.text = shopItem!.name
        cell.shopItemQuantity.text = "\(shopItem!.quantity ?? 0)"
        cell.shopItemPrice.text = "$\(shopItem!.price ?? 0)"
        cell.addButtonAction = { [unowned self] in
            self.addButtonTapped(indexPath)
        }
        cell.removeButtonAction = { [unowned self] in
            self.removeButtonTapped(indexPath)
        }
    
        return cell
    }
    
    private func addButtonTapped(_ indexPath: IndexPath) {
        self.model.addOneToCart(indexPath.row)
        self.refresh()
    }
    
    private func removeButtonTapped(_ indexPath: IndexPath) {
        self.model.removeOneFromCart(indexPath.row)
        self.refresh()
    }
    
    private func refresh() {
        self.tableView.reloadData()
        self.totalPriceLabel.text = "$\(model.totalPrice ?? 0)"
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard nfcSession == nil else { return }
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Please approach your phone to the NFC tag."
        nfcSession?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
         // Check the invalidation reason from the returned error.
               if let readerError = error as? NFCReaderError {
                   // Show an alert when the invalidation reason is not because of a success read
                   // during a single tag read mode, or user canceled a multi-tag read mode session
                   // from the UI or programmatically using the invalidate method call.
                   if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                       && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                       let alertController = UIAlertController(
                           title: "Session Invalidated",
                           message: error.localizedDescription,
                           preferredStyle: .alert
                       )
                       alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       DispatchQueue.main.async {
                           self.present(alertController, animated: true, completion: nil)
                       }
                   }
               }
               
               // A new session instance is required to read new tags.
               self.nfcSession = nil
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        //guard
          //  let ndefMessage = messages.first,
            //let record = ndefMessage.records.first,
            //record.typeNameFormat == .nfcWellKnown,
            //let payloadText = String(data: record.payload, encoding: .utf8)
           // let sku = payloadText.split(separator: "/").last
        //else {
          //  return
        //}
        
        for (index, ndefMessage) in messages.enumerated() {
            guard
                let record = ndefMessage.records.first,
                record.typeNameFormat == .nfcWellKnown,
                let payloadText = String(data: record.payload, encoding: .utf8)
            else {
                return
            }
            print("REGISTRO: -\(index)- //// DATOS: \(payloadText)")
        }
        
        self.nfcSession = nil
        
        //guard let product = productStore.product(withID: String(sku)) else {
          //  DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            //    let alertController = UIAlertController(title: "Info", message: "SKU Not found in catalog",preferredStyle: .alert)
              //  alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                //self?.present(alertController, animated: true, completion: nil)
            //}
            //return
        //}
        
       // DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
         //   self?.presentProductViewController(product: product)
        //}
    }
    
}
