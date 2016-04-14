//
//  PlaylistMasterViewController.swift
//  Algorhrythm
//
//  Created by Domenico on 14/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import UIKit

class PlaylistMasterViewController: UIViewController {
    
    @IBOutlet weak var playlistImageView0: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playlist = Playlist(index: 0)
        playlistImageView0.image = playlist.icon
        playlistImageView0.backgroundColor = playlist.backgroundColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlaylistDetail" {
            let playlistDetailController = segue.destinationViewController as! PlaylistDetailViewController
            let playlistInstance = Playlist(index:0)
            playlistDetailController.playlist = playlistInstance
        }
    }
    
    
}

