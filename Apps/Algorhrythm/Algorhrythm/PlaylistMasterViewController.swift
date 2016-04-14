//
//  PlaylistMasterViewController.swift
//  Algorhrythm
//
//  Created by Domenico on 14/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit

class PlaylistMasterViewController: UIViewController {
    
    var playlistArray:[UIImageView] = []
    @IBOutlet weak var playlistImageView0: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playlistArray.append(playlistImageView0)
        
        for index in 0..<playlistArray.count{
            let playlist = Playlist(index: index)
            let playlistImageView = playlistArray[0]
            
            playlistImageView.image = playlist.icon
            playlistImageView.backgroundColor = playlist.backgroundColor
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlaylistDetailSegue" {
            let playlistDetailController = segue.destinationViewController as! PlaylistDetailViewController
            let playlistInstance = Playlist(index:0)
            playlistDetailController.playlist = playlistInstance
        }
    }
    
    @IBAction func showPlaylistDetails(sender: AnyObject) {
        performSegueWithIdentifier("showPlaylistDetailSegue", sender: sender)
        
    }
    
}

