//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Brandi on 10/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
       guard let indexPath = tableView.indexPath(for: cell) else { return }
       
        let book = bookFor(indexPath: indexPath)
           bookController.updateHasBeenRead(for: book)
              
       tableView.reloadData()
        
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }

        // 'Creates' the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
    
        cell.delegate = self
               
       let book = bookFor(indexPath: indexPath)
       cell.book = book
       
       return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               // Delete the row from the data source
            let book = bookFor(indexPath: indexPath)
                bookController.deleteBook(book: book)
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "AddBook" {
            
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
        } else if segue.identifier == "UpdateBook" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? BookDetailViewController else { return }
            
            let book = bookFor(indexPath: indexPath)
            
            destinationVC.book = book
            destinationVC.bookController = bookController
        }
    }
}
