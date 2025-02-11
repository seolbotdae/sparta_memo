//
//  ViewController.swift
//  sparta_memo
//
//  Created by Seol WooHyeok on 2/10/25.
//

import UIKit

class ViewController: UIViewController {
    private var notes: [Note] = []
    
    private var tableView: UITableView = UITableView()
    private var addNotesButton: UIButton = UIButton()
    
    // userDefaults
    private let saveManager = UserDefaultsManager<Note>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        // UI, 제약 세팅
        setupTableViewUI()
        setupAddNotesButtonUI()
        setupConstraints()
        
        // tableView 세팅
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // addNotesButton 동작 추가
        addNotesButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        // userDefault 불러오기
        if let notes = saveManager.getData(key: "notes") {
            self.notes = notes
        }
    }
}

//
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = notes[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { _, _, completionHandler in
            self.notes.remove(at: indexPath.row)
            self.saveManager.saveData(key: "notes", value: self.notes)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }

        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: UI 셋업 분리
extension ViewController {
    private func setupTableViewUI() {
        view.addSubview(tableView)
    }
    
    private func setupAddNotesButtonUI() {
        view.addSubview(addNotesButton)
        
        addNotesButton.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    private func setupConstraints() {
        addNotesButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addNotesButton.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            addNotesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addNotesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addNotesButton.widthAnchor.constraint(equalToConstant: 50),
            addNotesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: Action function 분리
extension ViewController {
    @objc private func showAlert() {
        let ac = UIAlertController(title: "알림", message: "메시지", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("ok button pressed")
            
            guard let text = ac.textFields?.first?.text else { return }
            self.notes.append(Note(content: text))
            
            self.saveManager.saveData(key: "notes", value: self.notes)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { textField in
            textField.placeholder = "note"
        }
            
        present(ac, animated: true)
    }
}

