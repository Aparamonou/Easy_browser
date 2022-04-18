//
//  ListViewController.swift
//  Easy_Browser
//
//  Created by Alex Paramonov on 22.02.22.
//

import UIKit

class ListViewController: UITableViewController {
     
     var webcites = ["www.onliner.by", "banana.by", "charter97.org","www.google.com" ]
     
     override func viewDidLoad() {
          super.viewDidLoad()
          setTitle()
     }
     
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return webcites.count
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "webCite", for: indexPath)
          cell.textLabel?.text = webcites[indexPath.row]
          return cell
     }
     
     private func setTitle() {
          title = "Web Cites"
          navigationController?.navigationBar.prefersLargeTitles = true
     }
     
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
          if webcites[indexPath.row] == "charter97.org" {
               let alertController =  UIAlertController(title: "Error", message: "The site is not available in your region ", preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               present(alertController, animated: true)
          } else {
               if let viewController = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                    viewController.webcite = webcites[indexPath.row]
                    navigationController?.pushViewController(viewController, animated: true)
               }
          }
     }
}
