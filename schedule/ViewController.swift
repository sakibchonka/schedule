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
		
		if !UserDefaults().bool(forKey: "setup") {
			UserDefaults().set(true, forKey: "setup")
			UserDefaults().set(0, forKey: "count")
		}
		
		// Get all current saved schedules
		updateTasks()
		
	}
	
	func updateTasks() {
		
		schedules.removeAll()
		
		guard let count = UserDefaults().value(forKey: "count") as? Int else {
			return
		}
		
		for t in 0 ..< count {
			if let task = UserDefaults().value(forKey: "task_\(t+1)") as? String {
				schedules.append(task)
			}
		}
		
		tableView.reloadData()
		
	}
	
	@IBAction func didTapAdd() {
		let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
		vc.title = "New Task"
		vc.update = {
			DispatchQueue.main.async {
				self.updateTasks()
			}
			
		}
		navigationController?.pushViewController(vc, animated: true)
	}


}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
		vc.title = "New Task"
		vc.task = schedules[indexPath.row]

		navigationController?.pushViewController(vc, animated: true)
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
