 //
//  CheckWifi.m
//  OmniRetailer
//
//  Created by MACPC on 6/22/15.
//
//

#import "CheckWifi.h"
#import "Reachability.h"

//added by Srinivasulu on 29/04/2017...

#import "Global.h"
//upto here on 29/04/2017...

Reachability* reachability;

@implementation CheckWifi

-(BOOL)checkWifi {
    
//    BOOL connectionStatusl;
//    NSURL *url=[NSURL URLWithString:@"http://www.google.com"];
//    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"HEAD"];
//    NSHTTPURLResponse *response;
//    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];
//    connectionStatusl = ([response statusCode]==200)?YES:NO;
//    
//    NSLog(connectionStatusl ? @"Yes" : @"No");
//    
//    return connectionStatusl;

    
   __block BOOL  status = TRUE;
    
    Reachability *internetReach = [Reachability reachabilityForInternetConnection] ;
    [internetReach startNotifier];
//    Reachability * wifiReach = [Reachability reachabilityForLocalWiFi] ;
//    [wifiReach startNotifier];
    
     reachability = [Reachability reachabilityWithHostName:@"www.google.com"];
//
   // dispatch_sync(dispatch_get_main_queue(), ^{
    
       [reachability startNotifier];
//        NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
        NetworkStatus netStatus1 = [internetReach currentReachabilityStatus];
//        NetworkStatus netStatus2 = [wifiReach currentReachabilityStatus];
    
    
    //changed by Srinivasulu on 05/08/2017....
    
//        if(netStatus1 == NotReachable && netStatus2 == NotReachable )
    //reason method was '
            if(netStatus1 == NotReachable )
        //upot here on 05/08/2017....
        {
            status = FALSE;
        }
//        else if (remoteHostStatus == NotReachable) {
//            status = FALSE;
//        }
        else {
            
            status = TRUE;
        }
        
    //});
//   // [reachability performSelectorOnMainThread:@selector(currentReachabilityStatus) withObject:nil waitUntilDone:YES];
//   // [reachability startNotifier];
//
    
    
    //added by Srinivasulu on 29/04/2017....
    
    if( isWifiSelectionChanged ){
    
        status = !isOfflineService;
      
    }
    
    isWifiSelectionChanged = TRUE;

    //written by Srinivasulu on 06/08/2017....
    //commented by Srinivasulu  because need to  test this....
    
//    [reachability stopNotifier];
    
    //upto here on 06/08/2017....
    
    //utpo here on 29/04/2017....
    
    return status;
   
}

@end
