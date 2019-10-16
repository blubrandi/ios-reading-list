//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Brandi on 10/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var beenRead: UIButton!
    
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?
    
    private func updateViews() {
        guard let book = book else { return }
        
        bookTitle.text = book.title
    
        
        let image = book.hasBeenRead ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "unchecked")
        beenRead.setImage(image, for: .normal)
    }
    
    @IBAction func beenReadTapped(_ sender: UIButton) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
