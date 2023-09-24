//
//  ListaTableViewController.swift
//  ListaCidade
//
//  Created by Cátia Souza on 24/09/23.
//

import UIKit
import CoreData

class ListaTableViewController: UITableViewController {
    var fetchResult: NSFetchedResultsController<ListaC>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewController, let indexPath = tableView.indexPathForSelectedRow {
            controller.lista = fetchResult.object(at: indexPath)
            
        }
    }
    func load() {
        let fetchRequest: NSFetchRequest<ListaC> = ListaC.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "desc", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResult = NSFetchedResultsController(fetchRequest: fetchRequest as! NSFetchRequest<ListaC>, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResult.delegate = self
        try? fetchResult.performFetch()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResult.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListaTableViewCell else {
            return UITableViewCell()
            
        }
        let lista = fetchResult.object(at: indexPath)
        cell.configureCell(lista)
        return cell
    }
}
extension ListaTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
