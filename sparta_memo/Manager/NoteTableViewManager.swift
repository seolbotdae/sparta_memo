//
//  NoteTableViewManager.swift
//  sparta_memo
//
//  Created by Seol WooHyeok on 2/12/25.
//

import Foundation
import UIKit

class NoteTableViewManager: NSObject {
    private var noteManager: NoteManager
    private var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.noteManager = NoteManager(saveManager: UserDefaultsManager())
        super.init()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
    }
    
    private func reloadTableView() {
        tableView.reloadData()
    }
    
    func addNote(note: Note) {
        noteManager.addNote(note: note)
        reloadTableView()
    }
}

extension NoteTableViewManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteManager.getNotes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = noteManager.getNotes()[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { _, _, completionHandler in
            self.noteManager.deleteNote(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }

        deleteAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
