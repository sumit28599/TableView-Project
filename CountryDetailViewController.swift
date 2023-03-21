//
//  CountryDetailViewController.swift
//  TableViewExamples
//
//  Created by Saddam Khan on 20/02/23.
//

import UIKit

protocol CountryDetailViewControllerDelegate {
    func setLastCountryFlag(countryFlagName: String)
}

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var toolbar: UIToolbar!
    //MARK: @IBOutlet
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!

    //MARK: Variable
    var country: Country?
    var delegate: CountryDetailViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        toolbar.clipsToBounds = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func setupUI() {
        countryNameLabel.text = country?.countryName
        flagImageView.image = UIImage(named: country!.countryFlag)
    }

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        
        //1-On present
//        dismiss(animated: true)
        
        
        //2-On push
        delegate?.setLastCountryFlag(countryFlagName: country!.countryFlag)
        navigationController?.popViewController(animated: true)

    }
    
    
}
