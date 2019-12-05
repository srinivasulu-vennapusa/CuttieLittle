//
//  OrderTrackingPageNew.m
//  OmniRetailer
//
//  Created by Technolabs on 05/12/19.
//

#import "OrderTrackingPageNew.h"

@interface OrderTrackingPageNew ()

-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) from to: (CLLocationCoordinate2D) to;
-(void) centerMap;

@end

@implementation OrderTrackingPageNew


@synthesize orderId, scrollView, billIdValueLbl, orderIdValueLbl,customerNameLbl, mobileNumberLbl, addressTextView, itemsListTableView, sNoLbl,skuLbl, itemLbl, uomLbl, priceLbl, qtyLbl, discLbl, costLbl, mapView ;
@synthesize soundFileObject,soundFileURLRef;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    
    

}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];

    [self callingOutletOrderIdDetails];

}




/**
 * @description
 * @date         <#date#>
 * @method       <#name#>
 * @author       Roja.K
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingOutletOrderIdDetails {
    
    @try {
        
        [HUD setHidden:NO];
        HUD.labelText = @"Getting Orders Details..";
        
        NSMutableDictionary * orderDetailsDic = [[NSMutableDictionary alloc]init];
        
        [orderDetailsDic setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [orderDetailsDic setValue:presentLocation forKey:kLocation];
        [orderDetailsDic setValue:ZERO_CONSTANT forKey:START_INDEX];
        [orderDetailsDic setValue:orderId forKey:ORDER_ID];
        
        // [orderDetailsDic setValue:orderChanneLString forKey:ORDER_CHANNEL];
        [orderDetailsDic setValue:@"" forKey:@"confirmedDate"];
        [orderDetailsDic setValue:@"" forKey:@"confirmedSlotStartTime"];
        [orderDetailsDic setValue:@"" forKey:@"confirmedSlotEndTime"];

        
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:orderDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * serviceController = [WebServiceController new];
        serviceController.outletOrderServiceDelegate = self;
        [serviceController getOutleOrderDetails:salesReportJsonString];
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
    }
    
}





/**
 * @description          ----------
 * @date
 * @method       getOutletOrderDetailsSuccessResponse
 * @author       Roja.K
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)getOutletOrderDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        
        
        NSDictionary * orderDic = [successDictionary valueForKey:ORDER];
        
        if ([[orderDic valueForKey:ORDER_ID] isEqualToString:orderId])
            
            orderId  = [[self checkGivenValueIsNullOrNil:orderDic[ORDER_ID] defaultReturn:@""]copy];
        
        orderIdValueLbl.text = [self checkGivenValueIsNullOrNil:orderDic[ORDER_ID] defaultReturn:@""];
        
        customerNameLbl.text = [self checkGivenValueIsNullOrNil:orderDic[@"shipmentName"] defaultReturn:@""];
        mobileNumberLbl.text = [self checkGivenValueIsNullOrNil:orderDic[@"shipmentContact"] defaultReturn:@""];
        addressTextView.text = [self checkGivenValueIsNullOrNil:orderDic[@"shipement_address_location"] defaultReturn:@""];
        
        float itemTotCost = 0;
        
        NSArray * orderItems = successDictionary[kItemDetails];
        if (orderItemListArray == nil)
            orderItemListArray = [NSMutableArray new];
        
        
        for (int i = 0; i < orderItems.count; i++) {
            
            NSDictionary * orderItemDic = orderItems[i];
            
            NSMutableDictionary * orderItemDetailsDic = [[NSMutableDictionary alloc] init];
            
        
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ITEM_NAME] defaultReturn:@""] forKey:ITEM_NAME];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ORDERED_QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:ORDERED_QUANTITY];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:SALE_PRICE];
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
            
            
            [orderItemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[orderItemDic valueForKey:UOM] defaultReturn:@""] forKey:UOM];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:DISCOUNT] defaultReturn:@"0.00"] floatValue]] forKey:DISCOUNT];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:SALE_PRICE] defaultReturn:@"0.00"] floatValue]] forKey:Item_Price];
            
            [orderItemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:CONFIRM_QUANTITY] defaultReturn:@"0.00"] floatValue]] forKey:CONFIRM_QUANTITY];
            
            float itemTotCost =  [[self checkGivenValueIsNullOrNil:[orderItemDic  valueForKey:@"minSaleQty"] defaultReturn:@"0.00"] floatValue]  * [[orderItemDic  valueForKey:SALE_PRICE] floatValue] * [[orderItemDic  valueForKey:CONFIRM_QUANTITY] floatValue];
            
            [orderItemDetailsDic setValue: [NSNumber numberWithFloat:itemTotCost] forKey:ITEM_TOTAL_COST]; //item_price * qty

            // upto here added by roja on 21-09-2018... && 16/04/2019
            
            [orderItemListArray addObject:orderItemDetailsDic];
        }
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        
        [itemsListTableView reloadData];
        [self mapViewMethodImplimentation];
    }
    
}

/**
 * @description  ----------
 * @date
 * @method       getOutletOrderDetailsErrorResponse
 * @author       Roja.K
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getOutletOrderDetailsErrorResponse:(NSString *)errorResponse {
    
    @try {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == itemsListTableView){
        
        return [orderItemListArray count];
    }
    else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(tableView == itemsListTableView) {
            
            static NSString * cellIdentifier = @"orderSummaryCell";
            
            UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ((hlcell.contentView).subviews){
                
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            tableView.separatorColor = [UIColor clearColor];
            
            CAGradientLayer *layer_1;
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                hlcell.accessoryType = UITableViewCellAccessoryNone;
                
                @try {
                    layer_1 = [CAGradientLayer layer];
                    layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                    
                    layer_1.frame = CGRectMake( sNoLbl.frame.origin.x, hlcell.frame.size.height - 2, itemsListTableView.contentSize.width - sNoLbl.frame.origin.x , 1);
                    
                    [hlcell.contentView.layer addSublayer:layer_1];
                    
                } @catch (NSException *exception) {
                    
                }
            }
            
        @try {
            
            UILabel * snoValueLbl;
            UILabel * skuIdValueLbl;
            UILabel * item_nameValLbl;
            UILabel * uomValueLbl;
            UILabel * itemPriceValueLbl;
            UILabel * qtyValueLbl;
            UILabel * discountValLbl;
            UILabel * costValueLbl;
            
            
            snoValueLbl = [[UILabel alloc] init];
            snoValueLbl.backgroundColor = [UIColor clearColor];
            snoValueLbl.layer.borderWidth = 0;
            snoValueLbl.textAlignment = NSTextAlignmentCenter;
            snoValueLbl.numberOfLines = 1;
            snoValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            skuIdValueLbl = [[UILabel alloc] init];
            skuIdValueLbl.backgroundColor = [UIColor clearColor];
            skuIdValueLbl.layer.borderWidth = 0;
            skuIdValueLbl.textAlignment = NSTextAlignmentCenter;
            skuIdValueLbl.numberOfLines = 1;
            skuIdValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            item_nameValLbl = [[UILabel alloc] init];
            item_nameValLbl.backgroundColor = [UIColor clearColor];
            item_nameValLbl.layer.borderWidth = 0;
            item_nameValLbl.textAlignment = NSTextAlignmentCenter;
            item_nameValLbl.numberOfLines = 1;
            item_nameValLbl.lineBreakMode = NSLineBreakByWordWrapping;
            item_nameValLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            
            uomValueLbl = [[UILabel alloc] init];
            uomValueLbl.backgroundColor = [UIColor clearColor];
            uomValueLbl.layer.borderWidth = 0;
            uomValueLbl.textAlignment = NSTextAlignmentCenter;
            uomValueLbl.numberOfLines = 1;
            uomValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemPriceValueLbl = [[UILabel alloc] init];
            itemPriceValueLbl.backgroundColor = [UIColor clearColor];
            itemPriceValueLbl.layer.borderWidth = 0;
            itemPriceValueLbl.textAlignment = NSTextAlignmentCenter;
            itemPriceValueLbl.numberOfLines = 1;
            itemPriceValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            qtyValueLbl = [[UILabel alloc] init];
            qtyValueLbl.backgroundColor = [UIColor clearColor];
            qtyValueLbl.layer.borderWidth = 0;
            qtyValueLbl.textAlignment = NSTextAlignmentCenter;
            qtyValueLbl.numberOfLines = 1;
            qtyValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            discountValLbl = [[UILabel alloc] init];
            discountValLbl.backgroundColor = [UIColor clearColor];
            discountValLbl.layer.borderWidth = 0;
            discountValLbl.textAlignment = NSTextAlignmentCenter;
            discountValLbl.numberOfLines = 1;
            discountValLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            costValueLbl = [[UILabel alloc] init];
            costValueLbl.backgroundColor = [UIColor clearColor];
            costValueLbl.layer.borderWidth = 0;
            costValueLbl.textAlignment = NSTextAlignmentCenter;
            costValueLbl.numberOfLines = 1;
            costValueLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            
            snoValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            skuIdValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            item_nameValLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            uomValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemPriceValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            qtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            discountValLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            costValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            [hlcell.contentView addSubview:snoValueLbl];
            [hlcell.contentView addSubview:skuIdValueLbl];
            [hlcell.contentView addSubview:item_nameValLbl];
            [hlcell.contentView addSubview:itemPriceValueLbl];
            [hlcell.contentView addSubview:uomValueLbl];
            [hlcell.contentView addSubview:qtyValueLbl];
            [hlcell.contentView addSubview:discountValLbl];
            [hlcell.contentView addSubview:costValueLbl];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                snoValueLbl.frame = CGRectMake(sNoLbl.frame.origin.x, 0, sNoLbl.frame.size.width, hlcell.frame.size.height);
                skuIdValueLbl.frame = CGRectMake(skuLbl.frame.origin.x, 0, skuLbl.frame.size.width, hlcell.frame.size.height);
                item_nameValLbl.frame = CGRectMake(itemLbl.frame.origin.x, 0, itemLbl.frame.size.width, hlcell.frame.size.height);
                uomValueLbl.frame = CGRectMake(uomLbl.frame.origin.x, 0, uomLbl.frame.size.width, hlcell.frame.size.height);
                itemPriceValueLbl.frame = CGRectMake(priceLbl.frame.origin.x, 0, priceLbl.frame.size.width, hlcell.frame.size.height);
                qtyValueLbl.frame = CGRectMake(qtyLbl.frame.origin.x, 0, qtyLbl.frame.size.width, hlcell.frame.size.height);
                discountValLbl.frame = CGRectMake(discLbl.frame.origin.x, 0, discLbl.frame.size.width, hlcell.frame.size.height);
                costValueLbl.frame = CGRectMake(costLbl.frame.origin.x, 0, costLbl.frame.size.width, hlcell.frame.size.height);
                
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView: hlcell andSubViews:YES fontSize:15.0f cornerRadius:0.0];
            }
            
            
            NSDictionary * localDictionary = orderItemListArray[indexPath.row];
            
            snoValueLbl.text   = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1)];
            skuIdValueLbl.text   = [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:ITEM_SKU] defaultReturn:@"--"];
            item_nameValLbl.text =  [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:ITEM_NAME] defaultReturn:@"--"];
            uomValueLbl.text  =  [self checkGivenValueIsNullOrNil:[localDictionary valueForKey:UOM] defaultReturn:@"--"];
            itemPriceValueLbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:Item_Price] defaultReturn:@"0.0"] floatValue]];
           qtyValueLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:CONFIRM_QUANTITY] defaultReturn:@"0.0"] floatValue]];
            discountValLbl.text       =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:DISCOUNT] defaultReturn:@"0.0"] floatValue]];
            costValueLbl.text =  [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[localDictionary valueForKey:ITEM_TOTAL_COST] defaultReturn:@"0.0"] floatValue]];
            
            
        }
            @catch(NSException * exception) {
                
            }
            @finally {
                hlcell.backgroundColor = [UIColor clearColor];
                hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
                return hlcell;
            }
            
        }
      else{
          return 0;
      }
}



-(void)mapViewMethodImplimentation{
    
    mapView.showsUserLocation = NO;
    [mapView setDelegate:self];

    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 17.4245;
    coordinate.longitude = 78.4511;
    
    CLLocationCoordinate2D coordinate2;
    coordinate2.latitude = 17.4375;
    coordinate2.longitude = 78.4482;
    
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coordinate;
    
    MKPointAnnotation *point2 = [[MKPointAnnotation alloc] init];
    point2.coordinate = coordinate2;


    [self showRouteFrom:point to:point2];
}

-(void) showRouteFrom: (MKPointAnnotation*) f to:(MKPointAnnotation*) t {

    if(routes)
    {
    [mapView removeAnnotations:[mapView annotations]];
    }

    [mapView addAnnotation:f];
    [mapView addAnnotation:t];

    routes = [self calculateRoutesFrom:f.coordinate to:t.coordinate];
    
    if(routes != nil && [routes count]){
        NSInteger numberOfSteps = routes.count;

        CLLocationCoordinate2D coordinates[numberOfSteps];
        for (NSInteger index = 0; index < numberOfSteps; index++)
        {
            CLLocation *location = [routes objectAtIndex:index];
            CLLocationCoordinate2D coordinate = location.coordinate;
            coordinates[index] = coordinate;
        }
        MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
        [mapView addOverlay:polyLine];
        [self centerMap];
    }

}





- (NSMutableArray *)decodePolyLine: (NSMutableString *)encoded
{
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\" options:NSLiteralSearch range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len)
    {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do
        {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do
        {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        //printf("[%f,", [latitude doubleValue]);
        //printf("%f]", [longitude doubleValue]);
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:loc];
    }
    return array;
}

-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t
{
    
    NSArray * returnAry;
    
    NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
    NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];

    NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@", saddr, daddr];
    NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
    //NSLog(@"api url: %@", apiUrl);
    NSError* error = nil;
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl encoding:NSASCIIStringEncoding error:&error];

    
//    NSString *encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1L];
    
    if(apiResponse != nil){
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"points:\\\"([^\\\"]*)\\\"" options:0 error:NULL];
        NSTextCheckingResult *match = [regex firstMatchInString:apiResponse options:0 range:NSMakeRange(0, [apiResponse length])];
        NSString *encodedPoints = [apiResponse substringWithRange:[match rangeAtIndex:1]];
        return [self decodePolyLine:[encodedPoints mutableCopy]];

    }
    else {
        
        return returnAry;
    }
}

-(void) centerMap
{
    MKCoordinateRegion region;
    CLLocationDegrees maxLat = -90.0;
    CLLocationDegrees maxLon = -180.0;
    CLLocationDegrees minLat = 90.0;
    CLLocationDegrees minLon = 180.0;
    for(int idx = 0; idx < routes.count; idx++)
    {
        CLLocation* currentLocation = [routes objectAtIndex:idx];
        if(currentLocation.coordinate.latitude > maxLat)
            maxLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.latitude < minLat)
            minLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.longitude > maxLon)
            maxLon = currentLocation.coordinate.longitude;
        if(currentLocation.coordinate.longitude < minLon)
            minLon = currentLocation.coordinate.longitude;
    }
    region.center.latitude     = (maxLat + minLat) / 2.0;
    region.center.longitude    = (maxLon + minLon) / 2.0;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;

    region.span.latitudeDelta  = ((maxLat - minLat)<0.0)?100.0:(maxLat - minLat);
    region.span.longitudeDelta = ((maxLon - minLon)<0.0)?100.0:(maxLon - minLon);
    [mapView setRegion:region animated:YES];
}












/**
 * @description         here we are checking whether the object is null or not
 * @date
 * @method       checkGivenValueIsNullOrNil
 * @author       ROJA
 * @param        NSString
 * @param        id
 * @return       id
 * @verified By
 * @verified On
 *
 */

- (id)checkGivenValueIsNullOrNil:(id)inputValue defaultReturn:(NSString *)returnStirng{
    
    
    @try {
        if ([inputValue isKindOfClass:[NSNull class]] || inputValue == nil) {
            return returnStirng;
        }
        else {
            return inputValue;
        }
    } @catch (NSException *exception) {
        return @"--";
    }
}


/**
 * @description          adding the  alertMessage's based on input
 * @date
 * @method       displayAlertMessage
 * @author       Roja
 * @param        NSString
 * @param        float
 * @param        float
 * @param        NSString
 * @param        float
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines {
    
    
    @try {
        AudioServicesPlayAlertSound(soundFileObject);
        
        if ([userAlertMessageLbl isDescendantOfView:self.view] ) {
            [userAlertMessageLbl removeFromSuperview];
            
        }
        
        userAlertMessageLbl = [[UILabel alloc] init];
        userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        userAlertMessageLbl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        userAlertMessageLbl.layer.cornerRadius = 5.0f;
        userAlertMessageLbl.text =  message;
        userAlertMessageLbl.textAlignment = NSTextAlignmentCenter;
        userAlertMessageLbl.numberOfLines = noOfLines;
        
        userAlertMessageLbl.tag = 2;
        
        if ([messageType caseInsensitiveCompare:@"SUCCESS"] == NSOrderedSame || [messageType isEqualToString:@"CART_RECORDS"]) {
            
            if([messageType isEqualToString:@"CART_RECORDS"]) {
                
                userAlertMessageLbl.tag = 2;
            }
            else
                
                userAlertMessageLbl.tag = 4;
            
            userAlertMessageLbl.textColor = [UIColor blackColor];
            
            if(soundStatus){
                
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        else{
            
            userAlertMessageLbl.textColor = [UIColor blackColor];
            
            if(soundStatus){
                SystemSoundID    soundFileObject1;
                NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
                self.soundFileURLRef = (__bridge CFURLRef) tapSound;
                AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                AudioServicesPlaySystemSound (soundFileObject1);
            }
        }
        
        yPosition = self.view.frame.size.height/2;
        
        userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
        
        [self.view addSubview:userAlertMessageLbl];
        fadeOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
        
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in displayAlertMessage---------%@",exception);
        NSLog(@"----exception while creating the useralertMesssageLbl------------%@",exception);
        
    }
}



/**
 * @description  removing alertMessage add in the  disPlayAlertMessage method
 * @date         18/11/2016
 * @method       removeAlertMessages
 * @author       Bhargav Ram
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)removeAlertMessages{
    @try {
        
        if(userAlertMessageLbl.tag == 4){
            
            [self backAction];
        }
        else if ([userAlertMessageLbl isDescendantOfView:self.view])
            [userAlertMessageLbl removeFromSuperview];
    }
    @catch (NSException *exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the customerWalOut in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
        
    }
    
}


/**
 * @description            here we are navigating back to home page.......
 * @date
 * @method       backAction
 * @author       Roja.K
 * @param
 * @param
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)backAction {
    
    //Play audio for button touch...
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
    }
}




@end
