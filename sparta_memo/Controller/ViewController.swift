//
//  ViewController.swift
//  sparta_memo
//
//  Created by Seol WooHyeok on 2/10/25.
//

import UIKit

// UI를 관리하는 책임을 가진다.
class ViewController: UIViewController {
    private var noteTableViewManager: NoteTableViewManager!
    private var noteTableView: UITableView!
    private var noteInputHandler: NoteInputHandler!
    private var addNotesButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        self.noteInputHandler = NoteInputHandler(delegate: self)
        self.noteTableView = UITableView()
        self.noteTableViewManager = NoteTableViewManager(tableView: noteTableView)
        
        // UI, 제약 세팅
        setupTableViewUI()
        setupAddNotesButtonUI()
        setupConstraints()
        
        // addNotesButton 동작 추가
        addNotesButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
}

// MARK: UI 셋업 분리
extension ViewController {
    private func setupTableViewUI() {
        view.addSubview(noteTableView)
    }
    
    private func setupAddNotesButtonUI() {
        view.addSubview(addNotesButton)
        
        addNotesButton.setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    private func setupConstraints() {
        addNotesButton.translatesAutoresizingMaskIntoConstraints = false
        noteTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noteTableView.topAnchor.constraint(equalTo: addNotesButton.bottomAnchor),
            noteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            noteTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            noteTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            addNotesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addNotesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            addNotesButton.widthAnchor.constraint(equalToConstant: 50),
            addNotesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: Action function 분리
extension ViewController: NoteInputHandlerDelegate {
    @objc private func showAlert() {
        noteInputHandler.showNoteInputAlert(from: self)
    }
    
    func didAddNote(note: Note) {
        self.noteTableViewManager.addNote(note: note)
    }
}

