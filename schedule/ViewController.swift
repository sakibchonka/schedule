//
//  ViewController.swift
//  schedule
//
//  Created by Mohammed Saqib on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet var tableView: UITableView!
	
	var schedules = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Tasks"
		
		tableView.delegate = self
		tableView.dataSource = self 
		
		// Setup
		
		// Get all current saved schedules
		
		
	}
	
	@IBAction func didTapAdd() {
		let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
		vc.title = "New Task"
		navigationController?.pushViewController(vc, animated: true)
	}


}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return schedules.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
		
		cell.textLabel?.text = schedules[indexPath.row]
		
		return cell
	}
}
