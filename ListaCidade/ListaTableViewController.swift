//
//  ListaTableViewController.swift
//  ListaCidade
//
//  Created by Cátia Souza on 24/09/23.
//

import UIKit
import CoreData

class ListaTableViewController: UITableViewController {
    var fetchResultL: NSFetchRequestResult<Lista>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            controller.lista = fetchResultL.object(at: indexPath)
            
        }
    }
    func load() {
        let fetchRequest: NSFetchRequest<Lista> = Lista.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "desc", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResultL = NSFetchedResultsController(fetchRequest: fetchResultL as! NSFetchRequest<Lista>, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultL.delegate = self
        try? fetchResultL.performFetch()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultL.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListaTableViewCell else {
            return UITableViewCell()
            
        }
        let lista = fetchResultL.object(at: indexPath)
        cell.configureCell(lista)
        return cell
    }
    
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let lista = fetchResultL.object(at: indexPath)
            context.delete(lista)
            tableView.beginUpdates()
            try? context.save()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

}
extension ListaTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}
