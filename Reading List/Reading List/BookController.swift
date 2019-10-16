//
//  BookController.swift
//  Reading List
//
//  Created by Brandi on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    @discardableResult func createBook(entitled title: String, withReasonToRead reasonToRead: String, withHasBeenRead hasBeenRead: Bool) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let indexToUpdate = books.index(of: book) else { return }
        books[indexToUpdate].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    // Check code, revisit this.  Rough guess about if this is what really works.
    func updateBookInfo(for book: Book) {
        guard let indexOfBookToUpdate = books.index(of: book) else { return }
        let bookInfo = Book(title: book.title, reasonToRead: book.reasonToRead, hasBeenRead: book.hasBeenRead)
        books[indexOfBookToUpdate] = bookInfo
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        return dir.appendingPathComponent("ReadingList.plist")
    }
    
    // This function will be responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects so the application may display them on the table view, etc.
    
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        
        do {
            guard let url = readingListURL,
                fm.fileExists(atPath: url.path) else { return }
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
            // Combine
            // ::::| let decodedBooks = try decoder.decode([Book].self, from: data)
            // ::::| books = decodedBooks
            // into:
                books = try decoder.decode([Book].self, from: data)
            
        } catch {
            print("Error loading book data: \(error)")
        }
        
    }
    
    // This function will be responsible for saving any changes to any Book object so that the changes will still be there when the user comes back into the application.
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving book data: \(error)")
        }
    }
}
