//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Colby Harris on 3/30/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import CloudKit
import Foundation

class EntryController {
    //MARK: - Source of Truth and shared instance
    static let shared = EntryController()
    var entries: [Entry] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func createEntryWith(title: String, body: String, completion: @escaping(_ result: Result<Entry?, EntryError>) -> Void) {
        
        let newEntry = Entry(title: title, body: body)
        
    }
    
    // C.R.U.D. Methods
     func save(entry: Entry, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {

         let entryRecord = CKRecord(entry: entry)

         privateDB.save(entryRecord) { (record, error) in
             if let error = error {
                 print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                 completion(.failure(.ckError(error)))
                 return
             }
             guard let record = record,
             let savedEntry = Entry(ckRecord: record)
                 else { completion(.failure(.couldNotUnwrap)); return }
             print("new Entry saved successfully")
             self.entries.insert(savedEntry, at: 0)
             completion(.success(savedEntry))
         }
     }
    
    func fetchEntriesWith(completion: @escaping(_ result: Result<[Entry]?, EntryError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryConstants.recordTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error, error.localizedDescription)
                completion(.failure(.ckError(error)))
            }
            
            guard let records = records else { return completion(.failure(.couldNotUnwrap)) }
            let entries: [Entry] = records.compactMap(Entry.init(ckRecord: ))
            
            self.entries = entries
            
            completion(.success(entries))
            
            
        }
    }
}
