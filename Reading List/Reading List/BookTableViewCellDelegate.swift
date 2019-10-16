//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Brandi on 10/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
