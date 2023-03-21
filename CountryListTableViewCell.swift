//
//  CountryListTableViewCell.swift
//  TableViewExamples
//
//  Created by Saddam Khan on 15/02/23.
//

import UIKit

//Step-1
protocol CountryListTableViewCellDelegate {
    func nextButtonTapForCell(_ sender: UIButton)
    func nextButtonTapForCell(indexRow: Int)
}

class CountryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    //Step-2
    var delegate: CountryListTableViewCellDelegate?
    var currentRow: Int?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func nextButtonTap(_ sender: UIButton) {
        //Step-5
//        delegate?.nextButtonTapForCell(sender)

        //Using Optional Binding
        if let currentRow1 = currentRow {
            delegate?.nextButtonTapForCell(indexRow: currentRow1)
        }
        else {
            print("Fount Nil value")
        }

        //Using Guard
//        guard let currentRow2 = currentRow else {
//            print("Fount Nil value")
//            return
//        }
//        delegate?.nextButtonTapForCell(indexRow: currentRow2)
        
        
    }
}
