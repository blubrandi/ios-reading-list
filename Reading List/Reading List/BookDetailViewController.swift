//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Brandi on 10/16/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookReason: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        guard let book = book else {
            title = "Add A New Book"
            return }
        
        title = book.title
        bookTitle.text = book.title
        bookReason.text = book.reasonToRead
    }

    @IBAction func saveBook(_ sender: UIBarButtonItem) {
       
        guard let title = bookTitle.text,
        let reasonToRead = bookReason.text,
            title != "" && reasonToRead != "" else { return }
        
        if let book = book {
            bookController?.updateBookInfo(for: book, title: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(entitled: title, withReasonToRead: reasonToRead, withHasBeenRead: false)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
