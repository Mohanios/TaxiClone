//
//  BookingPageViewController.swift
//  Taxi Clone
//
//  Created by Mohanraj on 27/10/22.
//

import UIKit

class BookingPageViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var mobTf: UITextField!
    @IBOutlet weak var designationTf: UITextField!
    @IBOutlet weak var scheduleTf: UITextField!
    @IBOutlet weak var cashBtn: UIButton!
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var driverName: UITextField!
    @IBOutlet weak var drivrMob: UITextField!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var confirmBooking: UIButton!
    
    var diverName = ""
    var mobNum = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitialSetup()
    }
    
    func InitialSetup(){
        self.backgroundView.backgroundColor = .black.withAlphaComponent(0.84)
        self.nameTf.backgroundColor = .white.withAlphaComponent(0.2)
        self.mobTf.backgroundColor = .white.withAlphaComponent(0.2)
        self.designationTf.backgroundColor = .white.withAlphaComponent(0.2)
        self.scheduleTf.backgroundColor = .white.withAlphaComponent(0.2)
        self.driverName.backgroundColor = .white.withAlphaComponent(0.2)
        self.drivrMob.backgroundColor = .white.withAlphaComponent(0.2)
        self.stack.backgroundColor = .white.withAlphaComponent(0.2)
        self.confirmBooking.layer.cornerRadius = 10
        driverName.text = diverName
        drivrMob.text = mobNum
        driverName.isUserInteractionEnabled = false
        drivrMob.isUserInteractionEnabled = false
    }
    
    @IBAction func payment(_ sender: Any) {
        if (sender as AnyObject).tag == 1{
            cashBtn.isSelected = true
           // cashBtn.backgroundColor = .white
            cardBtn.isSelected = false
         //   cardBtn.backgroundColor = .black.withAlphaComponent(0.3)
            
        }
        else  if (sender as AnyObject).tag == 2{
            cashBtn.isSelected = false
         //   cardBtn.backgroundColor = .white
            cardBtn.isSelected = true
         //   cashBtn.backgroundColor = .black.withAlphaComponent(0.3)
        }
    }
    
    @IBAction func confirmBooking(_ sender: Any) {
        if (nameTf.text == "") ||  (mobTf.text == "") || (designationTf.text == "") || (scheduleTf.text == "") || (driverName.text == "") || (drivrMob.text == "") || ((cardBtn.isSelected == false) && (cashBtn.isSelected == false) )   {
            showAlert(message: "please fill all details")
            
        }else{
            showToast(controller: self, message : "Taxi Booked Successfully", seconds: 2.0)
            nameTf.text = ""
            mobTf.text = ""
            designationTf.text = ""
            scheduleTf.text = ""
            drivrMob.text = ""
            driverName.text = ""
            cashBtn.isSelected = false
            cardBtn.isSelected = false
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        let getInfo = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(getInfo)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
        
    }
}
