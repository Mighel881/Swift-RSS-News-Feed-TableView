//
//  MasterTableViewController.swift
//  RSS Table Swift
//
//  Created by Aland Kawa on 8/10/16.
//  Copyright © 2016 Aland Kawa. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController, NSXMLParserDelegate {

    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var item = NSMutableDictionary()
    var titleString = NSMutableString()
    var link = NSMutableString()
    var element = NSString()
    let url = "http://images.apple.com/main/rss/hotnews/hotnews.rss"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feeds = NSMutableArray()
        parser = NSXMLParser(contentsOfURL: NSURL(string: url)!)!
        parser.delegate = self
        parser.shouldResolveExternalEntities = false
        parser.parse()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feeds.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = feeds.objectAtIndex(indexPath.row).objectForKey("title") as? String
        
        return cell
    }
    

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        
        if element == "item" {
            item = NSMutableDictionary()
            titleString = NSMutableString()
            link = NSMutableString()
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if element == "title" {
            titleString.appendString(string)
        } else if element == "link" {
            link.appendString(string)
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            item.setObject(titleString, forKey: "title")
            item.setObject(link, forKey: "link")
            
            feeds.addObject(item.copy())
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath: NSIndexPath
            var detail: DetailViewController
            var urlString = NSString()
            var titleString = NSString()
            
            
            indexPath = tableView.indexPathForSelectedRow!
            
            urlString = feeds.objectAtIndex(indexPath.row).objectForKey("link") as! NSString
            titleString = feeds.objectAtIndex(indexPath.row).objectForKey("title") as! NSString
            
            detail = segue.destinationViewController as! DetailViewController
            detail.url = urlString as String
            detail.titleString = titleString as String
            
        }
    }
}
