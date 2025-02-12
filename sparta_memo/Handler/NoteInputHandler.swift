//
//  NoteInputHandler.swift
//  sparta_memo
//
//  Created by Seol WooHyeok on 2/12/25.
//

import Foundation
import UIKit

protocol NoteInputHandlerDelegate: AnyObject {
    func didAddNote(note: Note)
}

class NoteInputHandler {
    weak var delegate: NoteInputHandlerDelegate?
    
    init(delegate: NoteInputHandlerDelegate? = nil) {
        self.delegate = delegate
    }

    func showNoteInputAlert(from viewController: UIViewController) {
        let ac = UIAlertController(title: "알림", message: "새 메모를 작성합니다.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let text = ac.textFields?.first?.text, !text.isEmpty else { return }
            let newNote = Note(content: text)
            self.delegate?.didAddNote(note: newNote)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        ac.addTextField { textField in
            textField.placeholder = "note"
        }
            
        viewController.present(ac, animated: true)
    }
}
