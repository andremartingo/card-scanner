//
//  ViewController.swift
//  card-io
//
//  Created by André Martingo on 22/01/2019.
//  Copyright © 2019 André Martingo. All rights reserved.
//

import UIKit
import PayCardsRecognizer

class ViewController: UIViewController, PayCardsRecognizerPlatformDelegate, CardIOPaymentViewControllerDelegate {
    
    
    let button: UIButton = UIButton()
    let numberLabel: UILabel = UILabel()
    let holderNameLabel: UILabel = UILabel()
    let expireDateMonthLabel: UILabel = UILabel()
    let expireDateYearLabel: UILabel = UILabel()
    let cvv: UILabel = UILabel()
    var recognizer: PayCardsRecognizer!
    let cardIO: Bool = true

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        recognizer = PayCardsRecognizer(delegate: self,
                                        resultMode: .async,
                                        container: self.view,
                                        frameColor: .white)
        
        setUpSubviews()
    }
    
    
    private func setUpSubviews() {
        
        view.backgroundColor = .white
        
        view.addSubview(button)
        button.frame = CGRect(x: 15, y: 100, width: 50, height: 25)
        button.backgroundColor = .blue
        button.setTitle("Scan", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        view.addSubview(numberLabel)
        numberLabel.frame = CGRect(x: 15, y: 150, width: 200, height: 50)

        view.addSubview(holderNameLabel)
        holderNameLabel.frame = CGRect(x: 15, y: 200, width: 200, height: 50)

        view.addSubview(expireDateMonthLabel)
        expireDateMonthLabel.frame = CGRect(x: 15, y: 250, width: 200, height: 50)

        view.addSubview(expireDateYearLabel)
        expireDateYearLabel.frame = CGRect(x: 15, y: 300, width: 200, height: 50)
        
        view.addSubview(cvv)
        cvv.frame = CGRect(x: 15, y: 350, width: 200, height: 50)
    }
    
    @objc private func buttonAction(sender: UIButton!) {
                
        if cardIO {
            guard let cardIOVC = CardIOPaymentViewController(paymentDelegate: self) else { return }
            cardIOVC.modalPresentationStyle = .formSheet
            present(cardIOVC, animated: true, completion: nil)
        } else {
            recognizer.startCamera()
        }
    }
    
    // MARK: - PayCardsRecognizerPlatformDelegate
    
    func payCardsRecognizer(_ payCardsRecognizer: PayCardsRecognizer, didRecognize result: PayCardsRecognizerResult) {
        
        self.numberLabel.text = result.recognizedNumber
        self.holderNameLabel.text = result.recognizedHolderName
        self.expireDateMonthLabel.text = result.recognizedExpireDateMonth
        self.expireDateYearLabel.text = result.recognizedExpireDateYear

        recognizer.stopCamera()
    }
    
    // MARK: - CardIO Methods
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        print("user canceled")
        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv)
            self.numberLabel.text = info.cardNumber
            self.expireDateMonthLabel.text = String(info.expiryMonth)
            self.expireDateYearLabel.text = String(info.expiryYear)
            self.cvv.text = info.cvv
            print(str)
            //dismiss scanning controller
            paymentViewController?.dismiss(animated: true, completion: nil)
        }
    }
}

