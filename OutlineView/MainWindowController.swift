//
//  MainWindowController.swift
//  OutlineView
//
//  Created by Dis3buted on 23/05/16.
//  Copyright © 2016 Seven Years Later. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var outline: NSOutlineView!
    fileprivate var rootItem: FileItem? = FileItem(url: URL(fileURLWithPath:"/"), parent: nil)
    
    var rootView: View?

    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = true
        panel.allowedFileTypes = ["json"]
        if panel.runModal() == NSFileHandlingPanelOKButton,
            let jsonString = try? String(contentsOf: panel.urls[0], encoding: String.Encoding.utf8) {
            rootView = ViewParser.parse(fromJsonString: jsonString)
            outline.dataSource = self
            outline.delegate = self
            outline.reloadData()
        }
    }
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
}

//MARK: - NSOutlineViewDelegate
extension MainWindowController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let it = item as? View {
            return it.children![index]
        }
        return rootView!
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let view = outline.make(withIdentifier: "TextCell", owner: self) as? NSTableCellView
        if let it = item as? View {
            if let textField = view?.textField {
                textField.stringValue = it.title
            }
        } 
        return view
    }
}

//MARK: - NSOutlineViewDataSource
extension MainWindowController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        guard let view = item as? View else {
            // root
            return 1
        }
        
        return view.children?.count ?? 0
    }
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return !((item as? View)?.children?.isEmpty ?? true)
//        if let it = item as? FileItem {
//            if it.count > 0 {
//                return true
//            }
//        }
//        return false
    }
}
