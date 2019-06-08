//
//  DetailViewController.swift
//  SwiftRestoredMasterDetail
//
//  Created by Malcolm Hall on 08/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.timestamp!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: Event? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    // MARK: - State Restoration
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        guard let detailItem = self.detailItem,
        let context = detailItem.managedObjectContext else{
            return
        }
        coder.encode(context, forKey: "managedObjectContext")
        coder.encode(detailItem.objectID.uriRepresentation(), forKey: "detailItem")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        guard let context = coder.decodeObject(of: NSManagedObjectContext.self, forKey: "managedObjectContext"),
        let url = coder.decodeObject(forKey: "detailItem") as? URL,
        let objectID = context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url),
        let object = try? context.existingObject(with: objectID) as? Event else{
            return
        }
        self.detailItem = object
    }
}

