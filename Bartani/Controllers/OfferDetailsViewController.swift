//
//  OfferDetailsViewController.swift
//  Bartani
//
//  Created by Arif Rahman Sidik on 28/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class OfferDetailsViewController: UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductQuantity: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var labelUserDistance: UILabel!
    @IBOutlet weak var labelProductDescriptionTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonAccept: UIButton!
    @IBOutlet weak var buttonDecline: UIButton!

    var product: Product?
    var offer: Offer?
    
    var buyerProduct: Product?
    var sellerProduct: Product?
    
    //let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAccept.layer.cornerRadius = 10
        buttonAccept.layer.borderWidth = 1
        buttonAccept.layer.borderColor = #colorLiteral(red: 1, green: 0.5575068593, blue: 0, alpha: 1)
        
        buttonDecline.layer.cornerRadius = 10
        
        
        labelProductName.text = product?.title
        imageProduct.image = product?.image
        labelProductQuantity.text = product?.quantity
        
        if let price = product?.price {
            labelProductPrice.text = "Rp \(price)"
        }
        
        //locationManager.delegate = self
        labelDescription.text = product?.description
        
//        if CLLocationManager.locationServicesEnabled() {
//            checkLocationAuthorization(CLLocationManager.authorizationStatus())
//        } else {
//            // Show alert
//        }
        
   
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func acceptOffer(_ sender: UIButton) {
        if let offer = offer {
            CloudKitHelper.updateOfferStatus(offer: offer, accept: true) { (error) in
                if error != nil {
                    print(error!)
                    // TODO: Show alert
                    print("Error accepting offer!")
                } else {
                    DispatchQueue.main.async {
                        print("Berhasil!")
                        self.performSegue(withIdentifier: "toAcceptSuccess", sender: nil)
                    }
                }
                
            }
        }
    }
    
//    func chatWA() {
//
//    }
    
    @IBAction func declineOffer(_ sender: UIButton) {
        if let offer = offer {
            let alert = UIAlertController(title: "Delete", message: "This offer will be deleted from this app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                CloudKitHelper.updateOfferStatus(offer: offer, accept: false) { (error) in
                    DispatchQueue.main.async {
                        print("Berhasil!")
                        self.performSegue(withIdentifier: "toAcceptSuccess", sender: nil)
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
//    func checkLocationAuthorization(_ status: CLAuthorizationStatus) {
//        switch status {
//        case .authorizedWhenInUse:
//            locationManager.requestLocation()
//            break
//        case .denied:
//            // Show alert instructing them how to turn it on
//            break
//        case .notDetermined:
//            // Request the permission
//            locationManager.requestWhenInUseAuthorization()
//            break
//        case .restricted:
//            // Show alert letting them know what's up
//            break
//        case .authorizedAlways:
//            break
//        default:
//            break
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        checkLocationAuthorization(status)
//    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first, let productLocation = offer?.buyerProduct.location {
//            let distance = location.distance(from: productLocation) / 1000
//            labelUserDistance.text = "\(String(format: "%.1f", distance)) km"
//        }
//    }

//  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAcceptSuccess" {
            if let vc = segue.destination as? SuccesAcceptOfferViewController, let offer = sender as? Offer{
                vc.offer = offer
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
