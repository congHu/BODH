//
//  TableViewController.swift
//  BODH2
//
//  Created by David on 16/2/29.
//  Copyright (c) 2016年 David. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var binary: UITextField!
    @IBOutlet var octal: UITextField!
    @IBOutlet var decimal: UITextField!
    @IBOutlet var hex: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 4
    }
    @IBAction func binaryEdit(sender: UITextField) {
        if sender.text == "."{
            sender.text = "0."
        }
        var d = b2d(sender.text)
        d2o(d)
        d2h(d)
    }
    @IBAction func octalEdit(sender: UITextField) {
        if sender.text == "."{
            sender.text = "0."
        }
        var d = o2d(sender.text)
        d2b(d)
        d2h(d)
    }
    @IBAction func decimalEdit(sender: UITextField) {
        if sender.text == "."{
            sender.text = "0."
        }
        d2b(DoubleD(sender.text))
        d2o(DoubleD(sender.text))
        d2h(DoubleD(sender.text))
    }
    @IBAction func hexEdit(sender: UITextField) {
        sender.text = sender.text.uppercaseString
        if sender.text == "."{
            sender.text = "0."
        }
        var d = h2d(sender.text)
        d2b(d)
        d2o(d)
    }
    
    func b2d(value:String) ->String{
        var legel = 0
        var count = 0
        for i in value{
            count++
            if i=="1"||i=="0"||i=="."{
                legel++
            }
        }
        if count == legel && count <= 11{
            binary.textColor = UIColor.blackColor()
            var bd:[UInt64] = []
            var ad:[UInt64] = []
            var dot = false
            for i in value{
                if i == "."{
                    dot = true
                }else if !dot{
                    bd.append(UInt64(String(i).toInt()!))
                }else{
                    ad.append(UInt64(String(i).toInt()!))
                }
                
            }
            var s:UInt64 = 0

            var t = 0.0
            if bd.count>0{
                for var j = 0; j<bd.count; j++ {
                    s += (bd[bd.count-j-1])*UInt64(pow(2, Double(j)))
                }
            }
            if ad.count>0{
                for var j = 0; j<ad.count; j++ {
                    t += Double(ad[j])*(pow(2, Double(-(j+1))))
                }
            }
            
            decimal.text = "\(Double(s)+t)"
            return "\(Double(s)+t)"

        }else{
            binary.textColor = UIColor.redColor()
            return "0.0"
        }
        

        
    }
    func o2d(value:String) ->String{
        var legel = 0
        var count = 0
        for i in value{
            count++
            if i=="1"||i=="0"||i=="."||i=="2"||i=="3"||i=="4"||i=="5"||i=="6"||i=="7"{
                legel++
            }
        }
        if count == legel && count <= 8{
            octal.textColor = UIColor.blackColor()
            var sp = split(value){$0 == "."}
            
            var s = 0
            if sp.count > 0{
                var bd:[Int] = []
                for i in sp[0]{
                    bd.append(String(i).toInt()!)
                }
                for var j = 0; j<bd.count; j++ {
                    s+=bd[bd.count-1-j]*Int(pow(8,Double(j)))
                    
                    
                }
            }
            var t = 0.0
            if sp.count > 1{
                var ad:[Int] = []
                for i in sp[1]{
                    ad.append(String(i).toInt()!)
                }
                for var j = 0; j<ad.count; j++ {
                    t+=Double(ad[j])*pow(8, Double(-(j+1)))
                }
            }
            decimal.text = "\(Double(s)+t)"
            return "\(Double(s)+t)"
        }else{
            octal.textColor = UIColor.redColor()
            return "0.0"
        }
    }
    func h2d(value:String) ->String{
        var legel = 0
        var count = 0
        for i in value{
            count++
            if i=="1"||i=="0"||i=="."||i=="2"||i=="3"||i=="4"||i=="5"||i=="6"||i=="7"||i=="8"||i=="9"||i=="A"||i=="B"||i=="C"||i=="D"||i=="E"||i=="F"{
                legel++
            }
        }
        if count == legel && count <= 8{
            hex.textColor = UIColor.blackColor()
            
            var sp = split(value){$0 == "."}
            var s = 0
            if sp.count > 0{
                var bd:[Int] = []
                for i in sp[0]{
                    bd.append(hc2i(i))
                }
                for var j = 0; j<bd.count; j++ {
                    s+=bd[bd.count-1-j]*Int(pow(16,Double(j)))
                    
                    
                }
            }
            var t = 0.0
            if sp.count > 1{
                var ad:[Int] = []
                for i in sp[1]{
                    ad.append(hc2i(i))
                }
                for var j = 0; j<ad.count; j++ {
                    t+=Double(ad[j])*pow(16, Double(-(j+1)))
                }
            }
            decimal.text = "\(Double(s)+t)"
            return "\(Double(s)+t)"
        }else{
            hex.textColor = UIColor.redColor()
            return "0.0"
        }
    }
    
    func DoubleD(value:String) ->String{
        var legel = 0
        var count = 0
        for i in value{
            count++
            if i=="1"||i=="0"||i=="."||i=="2"||i=="3"||i=="4"||i=="5"||i=="6"||i=="7"||i=="8"||i=="9"{
                legel++
            }
        }
        if count == legel && count <= 10{
            decimal.textColor = UIColor.blackColor()
            return value
        }else{
            decimal.textColor = UIColor.redColor()
            return "0.0"
        }
        
    }
    func d2b(value:String){
        var sp = split(value){$0 == "."}
        var s = "0"
        if sp.count>0{
            var i = sp[0].toInt()!
            if sp[0] != "0"{
                s = ""
            }
            while i>0{
                
                s.insert(Character(String(i%2)), atIndex: s.startIndex)
                i/=2
                
            }
            
        }
        var t = "0"
        if sp.count>1{
            
            var i = Double(sp[1].toInt()!)/(pow(10.0, Double(NSString(string: sp[1]).length)))
            if sp[1] != "0"{
                t = ""
            }
            for var j = 0; j<4; j++ {
                
                
                t+=String(Int(i*2))
                i=i*2-Double(Int(i*2))
                
                if i<=0{
                    break
                }
            }
        }
        binary.text = "\(s).\(t)"
    }
    func d2o(value:String){
        var sp = split(value){$0 == "."}
        var s = "0"
        if sp.count>0{
            var i = sp[0].toInt()!
            if i != 0{
                s = ""
            }
            while i>0{
                
                s.insert(Character(String(i%8)), atIndex: s.startIndex)
                i/=8
                
            }
            
        }
        var t = "0"
        if sp.count>1{
            
            var i = Double(sp[1].toInt()!)/(pow(10.0, Double(NSString(string: sp[1]).length)))
            if i != 0{
                t = ""
            }
            for var j = 0; j<4; j++ {
                
                
                t+=String(Int(i*8))
                i=i*8-Double(Int(i*8))
                
                if i<=0{
                    break
                }
            }
        }
        octal.text = "\(s).\(t)"
        
    }
    func hc2i(hex:Character) ->Int{
        
        if String(hex).toInt() != nil{
            return String(hex).toInt()!
        }else{
            switch hex{
            case "A":
                return 10
            case "B":
                return 11
            case "C":
                return 12
            case "D":
                return 13
            case "E":
                return 14
            case "F":
                return 15
            default:
                return 0
            }
        }
        
    }
    func i2hc(i:Int) ->Character{
        if i < 10{
            return Character(String(i))
        }else{
            switch i{
            case 10:
                return "A"
            case 11:
                return "B"
            case 12:
                return "C"
            case 13:
                return "D"
            case 14:
                return "E"
            case 15:
                return "F"
            default:
                return "X"
            }
        }
    }
    func d2h(value:String){
        var sp = split(value){$0 == "."}
        var s = "0"
        if sp.count>0{
            var i = sp[0].toInt()!
            if i != 0{
                s = ""
            }
            while i>0{
               s.insert(i2hc(i%16), atIndex: s.startIndex)
                i/=16
            }
            
        }
        var t = "0"
        if sp.count>1{
            
            var i = Double(sp[1].toInt()!)/(pow(10.0, Double(NSString(string: sp[1]).length)))
            if i != 0{
                t = ""
            }
            for var j = 0; j<4; j++ {
                t.insert(i2hc(Int(i*16)), atIndex: t.endIndex)
                i=i*16-Double(Int(i*16))
                
                if i<=0{
                    break
                }
            }
        }
        hex.text = "\(s).\(t)"
    }

    @IBAction func binaryEnd(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func octalEnd(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func decimalEnd(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func hexEnd(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...

        return cell
    }
    */
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
