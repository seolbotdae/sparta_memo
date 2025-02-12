//
//  NoteManager.swift
//  sparta_memo
//
//  Created by Seol WooHyeok on 2/12/25.
//

import Foundation

class NoteManager {
    private var notes: [Note] = []
    private var saveManager: UserDefaultsManager<Note>
    
    init(saveManager: UserDefaultsManager<Note>) {
        self.saveManager = saveManager
        self.notes = saveManager.getData(key: "notes") ?? []
    }
    
    func addNote(note: Note) {
        notes.append(note)
        saveManager.saveData(key: "notes", value: notes)
    }
    
    func deleteNote(at index: Int) {
        notes.remove(at: index)
        saveManager.saveData(key: "notes", value: notes)
    }
    
    func getNotes() -> [Note] {
        return notes
    }
}
