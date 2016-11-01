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
    @IBOutlet weak var playlistImageView1: UIImageView!
    @IBOutlet weak var playlistImageView2: UIImageView!
    @IBOutlet weak var playlistImageView3: UIImageView!
    @IBOutlet weak var playlistImageView4: UIImageView!
    @IBOutlet weak var playlistImageView5: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playlistArray += [
            playlistImageView0,playlistImageView1,
            playlistImageView2,playlistImageView3,
            playlistImageView4,playlistImageView5
        ]
        
        for index in 0..<playlistArray.count{
            let playlist = Playlist(index: index)
            let playlistImageView = playlistArray[index]
            
            playlistImageView.image = playlist.icon
            playlistImageView.backgroundColor = playlist.backgroundColor
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlaylistDetailSegue" {
            let playlistImageView = (sender! as AnyObject).view! as! UIImageView
            
            
            if let index = playlistArray.index(of: playlistImageView){
                let playlistDetailController = segue.destination as! PlaylistDetailViewController
                let playlistInstance = Playlist(index:index)
                playlistDetailController.playlist = playlistInstance
            }
            
            
        }
    }
    
    @IBAction func showPlaylistDetails(_ sender: AnyObject) {
        performSegue(withIdentifier: "showPlaylistDetailSegue", sender: sender)
        
    }
    
}

