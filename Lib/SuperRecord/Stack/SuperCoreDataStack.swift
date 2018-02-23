//
//  SuperCoreDataStack.swift
//
//  SuperRecord - A small set of utilities to make working with CoreData a bit easier.
//  http://mike.kz/
//
//  Created by Michael Armstrong on 12/10/2014.
//  Copyright (c) 2014 SuperArmstrong.UK. All rights reserved.
//
//  RESPONSIBILITY : Setup a CoreData Stack accessible via a singleton.
//
//  NOTE: !!This Boiler Plate singleton is experimental and a work in progress!!

import UIKit
import CoreData

public var mainMOC:NSManagedObjectContext? = nil//SuperCoreDataStack.defaultStack.managedObjectContext
public var backgroundMOC:NSManagedObjectContext? = nil//SuperCoreDataStack.defaultStack.backgroundContext

open class SuperCoreDataStack {
    // MARK: MOC
    open lazy var managedObjectContext: NSManagedObjectContext =
        SuperCoreDataStack.createMainMOC(self.coordinator)
    open lazy var backgroundContext: NSManagedObjectContext =
        SuperCoreDataStack.createBackgroundMOC(self.coordinator)
    
    let config: Config
    fileprivate let coordinator: NSPersistentStoreCoordinator
    
    
    init?(config: Config?) {
        guard let config = config else {return nil}
        guard let momURL = Bundle.main.url(forResource: config.stackName, withExtension: "momd") else {return nil}
        guard let mom = NSManagedObjectModel(contentsOf: momURL) else {return nil}
        
        SuperCoreDataStack.checkAndCopyDatabaseFromProject(config: config)
        
        guard
        let coordinator = SuperCoreDataStack.makeCoordinator(
            mom: mom,
            storeType: config.type.type,
            url: config.storeNameURL
        ) else {
            return nil
        }
        
        self.coordinator = coordinator
        self.config = config
        
        
        
    }
}

// MARK: UTIL
extension SuperCoreDataStack {
    // MARK: Create Coordinator
    private class func makeCoordinator(mom: NSManagedObjectModel,storeType: String, url: URL) -> NSPersistentStoreCoordinator? {
        let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: mom)
        do {
            try coordinator.addPersistentStore(ofType: storeType, configurationName: nil, at: url, options: SuperCoreDataStackConfig.stackOption)
        } catch {
            return nil
        }
        return coordinator
    }
    
    // MARK: Create MOC
    private class func createMainMOC(_ coordinator:NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.mergePolicy = NSRollbackMergePolicy
        return managedObjectContext
    }
    
    private class func createBackgroundMOC(_ coordinator:NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        managedObjectContext.mergePolicy = NSOverwriteMergePolicy
        managedObjectContext.undoManager = nil
        return managedObjectContext
    }
    
    private class func setupMOC(main: NSManagedObjectContext, background: NSManagedObjectContext) {
        mainMOC = main
        backgroundMOC = background
        NotificationCenter.default.addObserver(
            main,
            selector: #selector(NSManagedObjectContext.contextDidSaveContext(notification:)),
            name: NSNotification.Name.NSManagedObjectContextDidSave,
            object: nil
        )
        NotificationCenter.default.addObserver(
            background,
            selector: #selector(NSManagedObjectContext.contextDidSaveContext(notification:)),
            name: NSNotification.Name.NSManagedObjectContextDidSave,
            object: nil
        )
    }
}

extension NSManagedObjectContext {
    @objc func contextDidSaveContext(notification: Notification) {
        print("moc save")
        guard let sender = notification.object as? NSManagedObjectContext else {return}
        
        if sender === mainMOC {
            //            NSLog("******** Saved main Context in this thread")
            backgroundMOC?.perform{
                backgroundMOC?.mergeChanges(fromContextDidSave: notification)
            }
        } else if sender === backgroundMOC {
            //            NSLog("******** Saved background Context in this thread")
            mainMOC?.perform{
                mainMOC?.mergeChanges(fromContextDidSave: notification)
            }
        } else {
            //            NSLog("******** Saved Context in other thread")
            mainMOC?.perform{
                mainMOC?.mergeChanges(fromContextDidSave: notification)
            }
            backgroundMOC?.perform{
                backgroundMOC?.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
}

extension SuperCoreDataStack {
    class fileprivate func checkAndCopyDatabaseFromProject(config: Config) {
        if !FileManager.default.fileExists(atPath: config.storeNameURL.path) {
            NSLog("copy db")
            self.copyDatabaseFileFromMainBundle(config: config, extensionName: "sqlite")
            self.copyDatabaseFileFromMainBundle(config: config, extensionName: "sqlite-shm")
            self.copyDatabaseFileFromMainBundle(config: config, extensionName: "sqlite-wal")
        } else {
            NSLog("db exist")
        }
    }
    
    class fileprivate func copyDatabaseFileFromMainBundle(config: Config, extensionName:String) {
        let target = config.copyTargetName + "." + extensionName
        guard let fromFile = Bundle.main.url(forResource: config.copyTargetName, withExtension: extensionName) else {
            print("Can't load \(target) from main bundle")
            return
        }
        
        print("Load \(target) from main bundle")
        let toFile = config.userDocumentURL.appendingPathComponent(config.stackName + "." + extensionName)
        copyFile(fromFile: fromFile, toFile: toFile)
    }
}

extension SuperCoreDataStack {
    // MARK: - Core Data Saving support
    
    open func saveContext () {
        saveContext(self.managedObjectContext)
    }
    
    open func saveContext (_ context:NSManagedObjectContext?) {
        //TODO: Improve error handling.
        if let moc = context {
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error as NSError {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error.userInfo)")
                    abort()
                }
            }
        }
    }
}

extension NSManagedObjectContext {
    public func mSave() {
        //TODO: Improve error handling.
        
        if self.hasChanges {
            do {
                try self.save()
            } catch let error as NSError {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error.userInfo)")
                //            abort()
            }
        }
    }
}
