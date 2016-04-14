//
//  PlaylistMasterViewController.swift
//  Algorhrythm
//
//  Created by Domenico on 14/04/16.
//  Copyright © 2016 Domenico Solazzo. All rights reserved.
//

import Cocoa

class PlaylistMasterViewController: UIViewController {
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var playlistImageView0: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aButton.setTitle("Press me!", forState: .Normal)
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
            playlistDetailController.playlist = Playlist(index: 0)
        }
    }
    
    
}

