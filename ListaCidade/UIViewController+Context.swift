//
//  UIViewController+Context.swift
//  ListaCidade
//
//  Created by Cátia Souza on 24/09/23.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        return appdelegate.persistentcontainer.viewContext
    }
}
