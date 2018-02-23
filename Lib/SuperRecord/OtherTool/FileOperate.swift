//
//  OtherTool.swift
//  CoreDataStack
//
//  Created by Yume on 2018/2/23.
//  Copyright © 2018年 Yume. All rights reserved.
//

import Foundation

func updatingDatabaseFile(userDocumentURL: URL, from: String, to: String) {
    let fromFile = userDocumentURL.appendingPathComponent(from)
    let toFile = userDocumentURL.appendingPathComponent(to)
    
    deleteFile(file: toFile)
    copyFile(fromFile: fromFile, toFile: toFile)
    deleteFile(file: fromFile)
}

func deleteFile(file: URL) {
    if FileManager.default.fileExists(atPath: file.path) {
        do {
            try FileManager.default.removeItem(at: file)
        } catch {
            NSLog("\(error)")
        }
    }
}

func copyFile(fromFile: URL, toFile: URL) {
    if !FileManager.default.fileExists(atPath: toFile.path) {
        do {
            try FileManager.default.copyItem(at: fromFile, to: toFile)
        } catch {
            NSLog("\(error)")
        }
    }
}
