//
//  ViewController.swift
//  TableViewExamples
//
//  Created by Saddam Khan on 15/02/23.
//

import UIKit

class CountryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textSearchField: UITextField!
    @IBOutlet weak var lastCountryImageView: UIImageView!
    
    
    @IBOutlet weak var label : UILabel!


    var countryArray = [Country]()
    var tempCountryArray = [Country]()
    var count = 0
    var timer = Timer()



    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryArray = Country.getDefaultCountryList()
        tempCountryArray = countryArray
        setupBinding()
    label.isHidden = true // hide
      // label.isHidden = false // show

    }
    
    private func setupBinding() {
        
        textSearchField.addTarget(self, action: #selector(textSearchFieldAction), for: .editingChanged)
    }
    
    @IBAction func nextButtonTap(_ sender: UIButton) {
        nextButtonAction(sender)
    }
    
    private func nextButtonAction(_ sender: UIButton) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        //Get indexPath
        guard let indexPath = self.tableView.indexPathForRow(at:buttonPosition) else {
            return
        }

//        let viewController = storyboard?.instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController
//        viewController.country = countryArray[indexPath.row]
//        navigationController?.pushViewController(viewController, animated: true)
        
        //Get cell
        guard let cell = tableView.cellForRow(at: indexPath) as? CountryListTableViewCell else {
            return
        }
        cell.countryNameLabel.textColor = .red
    }
    
}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //MARK: Show Label if result not found
        if countryArray.count == 0{
           
            label.isHidden = false

        }else{
          
            label.isHidden = true

        }

        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as! CountryListTableViewCell
        //Step-3
        cell.delegate = self
        cell.currentRow = indexPath.row
        
        cell.countryNameLabel.text = countryArray[indexPath.row].countryName
        cell.flagImageView.image = UIImage(named: countryArray[indexPath.row].countryFlag)
        
        //        if indexPath.row == countryArray.count-1 {
        //            cell.lineLabel.isHidden = true
        //        }
        //        else {
        //            cell.lineLabel.isHidden = false
        //        }
        cell.lineLabel.isHidden = indexPath.row == countryArray.count-1
        
        //        if countryArray[indexPath.row].isSelected {
        //            cell.checkImage.isHidden = false
        //        }
        //        else {
        //            cell.checkImage.isHidden = true
        //        }
        cell.checkImage.isHidden = !countryArray[indexPath.row].isSelected
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        for index in 0...countryArray.count-1 {
        //            countryArray[index].isSelected = false
        //        }
        //        countryArray[indexPath.row].isSelected = true
        //        tableView.reloadData()
        
        //1-Simple Present
        //        let viewController = storyboard?.instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController
        //        viewController.modalPresentationStyle = .fullScreen //.pageSheet .formSheet, .currentContext, .custom, .overFullScreen, .overCurrentContext, .popover, .none, .automatic
        //        present(viewController, animated: true)
        
        //2-Using Navigation
//                let viewController = storyboard?.instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController
//                viewController.country = countryArray[indexPath.row]
//                navigationController?.pushViewController(viewController, animated: true)
        
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textSearchField.resignFirstResponder()
        
        self.countryArray.removeAll()
        
        return true
    }
}

//Step-4
extension CountryListViewController: CountryListTableViewCellDelegate {
    
    
    func nextButtonTapForCell(_ sender: UIButton) {
        nextButtonAction(sender)
    }
    
    func nextButtonTapForCell(indexRow: Int) {
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController
        viewController.country = countryArray[indexRow]
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
                
        //Get cell
//        guard let cell = tableView.cellForRow(at: IndexPath(row: indexRow, section: 0)) as? CountryListTableViewCell else {
//            return
//        }
//        cell.countryNameLabel.textColor = .red

    }
    
}

extension CountryListViewController: CountryDetailViewControllerDelegate {
    func setLastCountryFlag(countryFlagName: String) {
        lastCountryImageView.image = UIImage(named: countryFlagName)
    }
}

//MARK: Search Feature
extension CountryListViewController {
    
    @objc func textSearchFieldAction() {
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(mainSearchLogic), userInfo: nil, repeats: false)
    }
    
    @objc func mainSearchLogic() {
        
        countryArray.removeAll()
        
        if let inputText = textSearchField.text {
            count += 1
            print("\(count) = \(inputText)")
            if inputText.count != 0 {
                for country in tempCountryArray {
                    
                    let range = country.countryName.lowercased().range(of: inputText, options: .caseInsensitive, range: nil,   locale: nil)
                    print("range")
                
                    if range != nil {
                        
                        countryArray.append(country)
                        
                    }
                }
            }
            else {
                
                countryArray = tempCountryArray
            }
            
            
            tableView.reloadData()
        }
        
    }
    
}

