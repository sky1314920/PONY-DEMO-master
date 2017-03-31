//
//  dbConnectModel.swift
//  test1
//
//  Created by panda on 2017/03/08.
//  Copyright © 2017年 panda. All rights reserved.
//

import Foundation
import SwiftCloudant

//extension dbConnectModel:sendMSGDelegate{
//   func sendValue(message: String) {
//        let tempIDs=message
//   }
//}

class dbConnectModel{
    
    
    
    let cloudantURL = NSURL(string:"https://1654df84-d75e-4866-9cdb-1462a49cbdf7-bluemix:7c578cc12999f846d7264e660905e765180654beb25e85855fe0cb2e1758447a@1654df84-d75e-4866-9cdb-1462a49cbdf7-bluemix.cloudant.com")!
    
    
    let accountNo = "1654df84-d75e-4866-9cdb-1462a49cbdf7-bluemix"
    
    let pwd = "7c578cc12999f846d7264e660905e765180654beb25e85855fe0cb2e1758447a"
    
    let dbName = "panda_db"
    
    
    func dbAdd(docid:String,context:Dictionary<String,String>){
               
        let client = CouchDBClient(url:cloudantURL as URL, username: accountNo, password: pwd)
        
        let create = PutDocumentOperation(id:docid, body:context,
                                          databaseName: dbName) {(response, httpInfo, error) in
                                            if let error = error {
                                                print("Encountered an error while creating a document. Error:\(error)")
                                                

                                            } else {
                                                print("Created document \(response?["id"]) with revision id \(response?["rev"])")
                                                
                                            }
                                            
        }
        client.add(operation: create)
        
    }

    
    func dbSelect(selectID :String,dm :dataModel)  {
        
        let client = CouchDBClient(url:cloudantURL as URL, username: accountNo, password: pwd)
        
        let read = GetDocumentOperation(id: selectID, databaseName: dbName){(response1, httpInfo1, error) in
            if let error1 = error {
                print("Encountered an error while reading a document. ERROR:\(error1)")
                dm.isflg=false
                 print ("dm.isflg========\(dm.isflg)")
              //  self.flagSelect = false
                
            } else {
                print ("Read document: \(response1)")
                //print("Version================\(response1?["_rev"])")
                if let vers=response1?["_rev"] {
                    print ("Version================\(vers)")
                    
                   dm.setdocvers(docvers: vers as! String)
                    print ("dm.docvers================\(dm.docvers)")
                    dm.isflg=true
                    print ("dm.isflg========\(dm.isflg)")
                    
                }
                
               // self.flagSelect = true
            }
        }
        
        client.add(operation:read)
        
        // print (read.revision!)
        
        // return self.flagSelect
    }
    
    func docDelect(deleteID :String, deleteVer: String ) {
        let client = CouchDBClient(url:cloudantURL as URL, username: accountNo, password: pwd)
        print("deleteID\(deleteID)")
        print("deleteVer\(deleteVer)")
        let delete = DeleteDocumentOperation(id: deleteID, revision :deleteVer,databaseName: dbName) {(response2, httpInfo2, error) in
            if let error2 = error {
                print("Encountered an error while deleting a document. ERROR:\(error2)")
               // self.flagDelete = false
                
            } else {
                print ("Document Deleted")
               // self.flagDelete = true
            }
        }
        client.add(operation:delete)
        //return self.flagDelete
        
    }
}
