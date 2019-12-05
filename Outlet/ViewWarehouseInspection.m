//
//  ViewWarehouseInspection.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 5/1/15.
//
//

#import "ViewWarehouseInspection.h"
#import "OmniHomePage.h"
#import "Global.h"
#import "shipmentInspectionServicesSvc.h"
#import "RequestHeader.h"

@interface ViewWarehouseInspection ()

@end

@implementation ViewWarehouseInspection
@synthesize soundFileObject,soundFileURLRef;
NSString *wareInspectionID_ = @"";

-(id) initWithInspectionID:(NSString *)inspectionID{
    
    wareInspectionID_ = [inspectionID copy];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    //ProgressBar creation...
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(150.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(200.0, -13.0, 300.0, 70.0)];
    titleLbl.text = @"Warehouse Invoice Details";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(10.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(45.0, -12.0, 200.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
    }
    
    self.navigationItem.titleView = titleView;
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setImage:[UIImage imageNamed:@"emails-letters.png"] forState:UIControlStateNormal];
    popButton.frame = CGRectMake(0, 0, 40.0, 40.0);
    [popButton addTarget:self action:@selector(popUpView) forControlEvents:UIControlEventTouchUpInside];
    
    sendButton =[[UIBarButtonItem alloc]init];
    sendButton.customView = popButton;
    sendButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem=sendButton;
    
    shipmentView = [[UIScrollView alloc] init];
    shipmentView.backgroundColor = [UIColor clearColor];
    shipmentView.bounces = FALSE;
    shipmentView.hidden = NO;

    po_ref = [[[UILabel alloc] init] autorelease];
    po_ref.text = @"PO Ref. :";
    po_ref.layer.masksToBounds = YES;
    po_ref.numberOfLines = 2;
    [po_ref setTextAlignment:NSTextAlignmentLeft];
    po_ref.font = [UIFont boldSystemFontOfSize:14.0];
    po_ref.textColor = [UIColor whiteColor];
    
    po_refValue = [[[UILabel alloc] init] autorelease];
    po_refValue.layer.masksToBounds = YES;
    po_refValue.text = @"*******";
    po_refValue.numberOfLines = 2;
    [po_refValue setTextAlignment:NSTextAlignmentLeft];
    po_refValue.font = [UIFont boldSystemFontOfSize:14.0];
    po_refValue.textColor = [UIColor whiteColor];
    
    shipment_note_ref = [[[UILabel alloc] init] autorelease];
    shipment_note_ref.text = @"Shipment Note Ref. :";
    shipment_note_ref.layer.masksToBounds = YES;
    shipment_note_ref.numberOfLines = 2;
    [shipment_note_ref setTextAlignment:NSTextAlignmentLeft];
    shipment_note_ref.font = [UIFont boldSystemFontOfSize:14.0];
    shipment_note_ref.textColor = [UIColor whiteColor];
    
    shipment_note_refValue = [[[UILabel alloc] init] autorelease];
    shipment_note_refValue.layer.masksToBounds = YES;
    shipment_note_refValue.text = @"*******";
    shipment_note_refValue.numberOfLines = 2;
    [shipment_note_refValue setTextAlignment:NSTextAlignmentLeft];
    shipment_note_refValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipment_note_refValue.textColor = [UIColor whiteColor];

    inspected_by = [[[UILabel alloc] init] autorelease];
    inspected_by.text = @"Inspected By :";
    inspected_by.layer.masksToBounds = YES;
    inspected_by.numberOfLines = 2;
    [inspected_by setTextAlignment:NSTextAlignmentLeft];
    inspected_by.font = [UIFont boldSystemFontOfSize:14.0];
    inspected_by.textColor = [UIColor whiteColor];
    
    inspected_byValue = [[[UILabel alloc] init] autorelease];
    inspected_byValue.layer.masksToBounds = YES;
    inspected_byValue.text = @"*******";
    inspected_byValue.numberOfLines = 2;
    [inspected_byValue setTextAlignment:NSTextAlignmentLeft];
    inspected_byValue.font = [UIFont boldSystemFontOfSize:14.0];
    inspected_byValue.textColor = [UIColor whiteColor];
    
    inspection_summary = [[[UILabel alloc] init] autorelease];
    inspection_summary.text = @"Inspected Summary :";
    inspection_summary.layer.masksToBounds = YES;
    inspection_summary.numberOfLines = 2;
    [inspection_summary setTextAlignment:NSTextAlignmentLeft];
    inspection_summary.font = [UIFont boldSystemFontOfSize:14.0];
    inspection_summary.textColor = [UIColor whiteColor];
    
    inspection_summaryValue = [[[UILabel alloc] init] autorelease];
    inspection_summaryValue.layer.masksToBounds = YES;
    inspection_summaryValue.text = @"*******";
    inspection_summaryValue.numberOfLines = 2;
    [inspection_summaryValue setTextAlignment:NSTextAlignmentLeft];
    inspection_summaryValue.font = [UIFont boldSystemFontOfSize:14.0];
    inspection_summaryValue.textColor = [UIColor whiteColor];
    
    received_on = [[[UILabel alloc] init] autorelease];
    received_on.text = @"Received On :";
    received_on.layer.masksToBounds = YES;
    received_on.numberOfLines = 2;
    [received_on setTextAlignment:NSTextAlignmentLeft];
    received_on.font = [UIFont boldSystemFontOfSize:14.0];
    received_on.textColor = [UIColor whiteColor];
    
    received_onValue = [[[UILabel alloc] init] autorelease];
    received_onValue.layer.masksToBounds = YES;
    received_onValue.text = @"*******";
    received_onValue.numberOfLines = 2;
    [received_onValue setTextAlignment:NSTextAlignmentLeft];
    received_onValue.font = [UIFont boldSystemFontOfSize:14.0];
    received_onValue.textColor = [UIColor whiteColor];

    inspection_status = [[[UILabel alloc] init] autorelease];
    inspection_status.text = @"Inspected Status :";
    inspection_status.layer.masksToBounds = YES;
    inspection_status.numberOfLines = 2;
    [inspection_status setTextAlignment:NSTextAlignmentLeft];
    inspection_status.font = [UIFont boldSystemFontOfSize:14.0];
    inspection_status.textColor = [UIColor whiteColor];
    
    inspection_statusValue = [[[UILabel alloc] init] autorelease];
    inspection_statusValue.layer.masksToBounds = YES;
    inspection_statusValue.text = @"*******";
    inspection_statusValue.numberOfLines = 2;
    [inspection_statusValue setTextAlignment:NSTextAlignmentLeft];
    inspection_statusValue.font = [UIFont boldSystemFontOfSize:14.0];
    inspection_statusValue.textColor = [UIColor whiteColor];
    
    remarks = [[[UILabel alloc] init] autorelease];
    remarks.text = @"Remarks :";
    remarks.layer.masksToBounds = YES;
    remarks.numberOfLines = 2;
    [remarks setTextAlignment:NSTextAlignmentLeft];
    remarks.font = [UIFont boldSystemFontOfSize:14.0];
    remarks.textColor = [UIColor whiteColor];
    
    remarksValue = [[[UILabel alloc] init] autorelease];
    remarksValue.layer.masksToBounds = YES;
    remarksValue.text = @"*******";
    remarksValue.numberOfLines = 2;
    [remarksValue setTextAlignment:NSTextAlignmentLeft];
    remarksValue.font = [UIFont boldSystemFontOfSize:14.0];
    remarksValue.textColor = [UIColor whiteColor];
    
    UILabel *label1 = [[[UILabel alloc] init] autorelease];
    label1.text = @"Item";
    label1.layer.cornerRadius = 12;
    [label1 setTextAlignment:NSTextAlignmentCenter];
    label1.layer.masksToBounds = YES;
    
    label1.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label1.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label5 = [[[UILabel alloc] init] autorelease];
    label5.text = @"Desc";
    label5.layer.cornerRadius = 12;
    [label5 setTextAlignment:NSTextAlignmentCenter];
    label5.layer.masksToBounds = YES;
    
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[[UILabel alloc] init] autorelease];
    label2.text = @"QTY";
    label2.layer.cornerRadius = 12;
    label2.layer.masksToBounds = YES;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label3 = [[[UILabel alloc] init] autorelease];
    label3.text = @"UOM";
    label3.layer.cornerRadius = 12;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Details";
    label4.layer.cornerRadius = 12;
    label4.layer.masksToBounds = YES;
    [label4 setTextAlignment:NSTextAlignmentCenter];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    
    itemTable = [[UITableView alloc] init];
    [itemTable setDataSource:self];
    [itemTable setDelegate:self];
    itemTable.backgroundColor = [UIColor clearColor];
    [itemTable setSeparatorColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2f]];
    itemArray = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        shipmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 200, self.view.frame.size.height);
        
        po_ref.font = [UIFont boldSystemFontOfSize:20];
        po_ref.frame = CGRectMake(10, 0.0, 200.0, 55);
        po_refValue.font = [UIFont boldSystemFontOfSize:20];
        po_refValue.frame = CGRectMake(250.0, 0.0, 200.0, 55);
        
        shipment_note_ref.font = [UIFont boldSystemFontOfSize:20];
        shipment_note_ref.frame = CGRectMake(460.0, 0.0, 200.0, 55);
        shipment_note_refValue.font = [UIFont boldSystemFontOfSize:20];
        shipment_note_refValue.frame = CGRectMake(700.0, 0.0, 200.0, 55);
        
        inspected_by.font = [UIFont boldSystemFontOfSize:20];
        inspected_by.frame = CGRectMake(10, 60.0, 200.0, 55);
        inspected_byValue.font = [UIFont boldSystemFontOfSize:20];
        inspected_byValue.frame = CGRectMake(250.0, 60.0, 200.0, 55);
        
        inspection_summary.font = [UIFont boldSystemFontOfSize:20];
        inspection_summary.frame = CGRectMake(460.0, 60.0, 200.0, 55);
        inspection_summaryValue.font = [UIFont boldSystemFontOfSize:20];
        inspection_summaryValue.frame = CGRectMake(700.0, 60.0, 200.0, 55);
        
        received_on.font = [UIFont boldSystemFontOfSize:20];
        received_on.frame = CGRectMake(10, 120.0, 200.0, 55);
        received_onValue.font = [UIFont boldSystemFontOfSize:20];
        received_onValue.frame = CGRectMake(250.0, 120.0, 200.0, 55);
        
        inspection_status.font = [UIFont boldSystemFontOfSize:20];
        inspection_status.frame = CGRectMake(460.0, 120.0, 200.0, 55);
        inspection_statusValue.font = [UIFont boldSystemFontOfSize:20];
        inspection_statusValue.frame = CGRectMake(700.0, 120.0, 200.0, 55);
        
        remarks.font = [UIFont boldSystemFontOfSize:20];
        remarks.frame = CGRectMake(10, 180.0, 200.0, 55);
        remarksValue.font = [UIFont boldSystemFontOfSize:20];
        remarksValue.frame = CGRectMake(250.0, 180.0, 200.0, 55);
        
        label1.frame = CGRectMake(10, 250.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        
        label5.frame = CGRectMake(161, 250.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        
        label2.frame = CGRectMake(312, 250.0, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        
        label3.frame = CGRectMake(463, 250.0, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        
        label4.frame = CGRectMake(614, 250.0, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        
        itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        itemTable.frame = CGRectMake(0, 300.0, 850.0, 500);


    }
        else{
            
            shipmentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            shipmentView.contentSize = CGSizeMake(self.view.frame.size.width + 250.0, 800.0);
            
            po_ref.font = [UIFont boldSystemFontOfSize:15];
            po_ref.frame = CGRectMake(5, 0.0, 150.0, 35);
            po_ref.backgroundColor = [UIColor clearColor];
            po_refValue.font = [UIFont boldSystemFontOfSize:15];
            po_refValue.frame = CGRectMake(165.0, 0.0, 150.0, 35.0);
            po_refValue.backgroundColor = [UIColor clearColor];
            
            shipment_note_ref.font = [UIFont boldSystemFontOfSize:15];
            shipment_note_ref.frame = CGRectMake(325, 0.0, 150.0, 35);
            shipment_note_ref.backgroundColor = [UIColor clearColor];
            shipment_note_refValue.font = [UIFont boldSystemFontOfSize:15];
            shipment_note_refValue.frame = CGRectMake(450.0, 0.0, 150.0, 35.0);
            shipment_note_refValue.backgroundColor = [UIColor clearColor];

            inspected_by.font = [UIFont boldSystemFontOfSize:15];
            inspected_by.frame = CGRectMake(5, 40.0, 150.0, 35);
            inspected_by.backgroundColor = [UIColor clearColor];
            inspected_byValue.font = [UIFont boldSystemFontOfSize:15];
            inspected_byValue.frame = CGRectMake(165.0, 40.0, 150.0, 35.0);
            inspected_byValue.backgroundColor = [UIColor clearColor];
            
            inspection_summary.font = [UIFont boldSystemFontOfSize:15];
            inspection_summary.frame = CGRectMake(325, 40.0, 150.0, 35);
            inspection_summary.backgroundColor = [UIColor clearColor];
            inspection_summaryValue.font = [UIFont boldSystemFontOfSize:15];
            inspection_summaryValue.frame = CGRectMake(450.0, 40.0, 150.0, 35.0);
            inspection_summaryValue.backgroundColor = [UIColor clearColor];
            
            received_on.font = [UIFont boldSystemFontOfSize:15];
            received_on.frame = CGRectMake(5, 80.0, 150.0, 35);
            received_on.backgroundColor = [UIColor clearColor];
            received_onValue.font = [UIFont boldSystemFontOfSize:15];
            received_onValue.frame = CGRectMake(165.0, 80.0, 150.0, 35.0);
            received_onValue.backgroundColor = [UIColor clearColor];
            
            inspection_status.font = [UIFont boldSystemFontOfSize:15];
            inspection_status.frame = CGRectMake(325, 80.0, 150.0, 35);
            inspection_status.backgroundColor = [UIColor clearColor];
            inspection_statusValue.font = [UIFont boldSystemFontOfSize:15];
            inspection_statusValue.frame = CGRectMake(450.0, 80.0, 150.0, 35.0);
            inspection_statusValue.backgroundColor = [UIColor clearColor];

            remarks.font = [UIFont boldSystemFontOfSize:15];
            remarks.frame = CGRectMake(5, 120.0, 150.0, 35);
            remarks.backgroundColor = [UIColor clearColor];
            remarksValue.font = [UIFont boldSystemFontOfSize:15];
            remarksValue.frame = CGRectMake(165.0, 120.0, 150.0, 35.0);
            remarksValue.backgroundColor = [UIColor clearColor];
            
            label1.frame = CGRectMake(0, 160.0, 60, 25);
            label1.font = [UIFont boldSystemFontOfSize:17];
            
            label5.frame = CGRectMake(61, 160.0, 60, 25);
            label5.font = [UIFont boldSystemFontOfSize:17];
            
            label2.frame = CGRectMake(122, 160.0, 60, 25);
            label2.font = [UIFont boldSystemFontOfSize:17];
            
            label3.frame = CGRectMake(183, 160.0, 60, 25);
            label3.font = [UIFont boldSystemFontOfSize:17];
            
            label4.frame = CGRectMake(244, 160.0, 60, 25);
            label4.font = [UIFont boldSystemFontOfSize:17];
            
            itemTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            itemTable.frame = CGRectMake(0, 190.0, 320.0, 300.0);
        }
    [shipmentView addSubview:po_ref];
    [shipmentView addSubview:po_refValue];
    [shipmentView addSubview:shipment_note_ref];
    [shipmentView addSubview:shipment_note_refValue];
    [shipmentView addSubview:inspected_by];
    [shipmentView addSubview:inspected_byValue];
    [shipmentView addSubview:inspection_summary];
    [shipmentView addSubview:inspection_summaryValue];
    [shipmentView addSubview:received_on];
    [shipmentView addSubview:received_onValue];
    [shipmentView addSubview:inspection_status];
    [shipmentView addSubview:inspection_statusValue];
    [shipmentView addSubview:remarks];
    [shipmentView addSubview:remarksValue];
    [shipmentView addSubview:label1];
    [shipmentView addSubview:label2];
    [shipmentView addSubview:label3];
    [shipmentView addSubview:label4];
    [shipmentView addSubview: label5];
    [shipmentView addSubview:itemTable];
    [self.view addSubview:shipmentView];
    [self getShipmentIDDetails];
}

-(void)getShipmentIDDetails{
    
    shipmentInspectionServicesSoapBinding *service = [[shipmentInspectionServicesSvc shipmentInspectionServicesSoapBinding] retain];
    shipmentInspectionServicesSvc_getInspectionDetails *aparams = [[shipmentInspectionServicesSvc_getInspectionDetails alloc] init];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"inspection_ref",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",wareInspectionID_],[RequestHeader getRequestHeader], nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    
    aparams.getInspectionDetailsRequest = normalStockString;
    shipmentInspectionServicesSoapBindingResponse *response = [service getInspectionDetailsUsingParameters:(shipmentInspectionServicesSvc_getInspectionDetails *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    NSError *e;
    
    NSDictionary *JSON1 ;
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[shipmentInspectionServicesSvc_getInspectionDetailsResponse class]]) {
            shipmentInspectionServicesSvc_getInspectionDetailsResponse *body = (shipmentInspectionServicesSvc_getInspectionDetailsResponse *)bodyPart;
            NSLog(@"%@",body.return_);
            JSON1 = [NSJSONSerialization JSONObjectWithData: [body.return_ dataUsingEncoding:NSUTF8StringEncoding]
                                                    options: NSJSONReadingMutableContainers
                                                      error: &e];
            NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
            
            if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Success"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
                NSArray *temp = [JSON1 objectForKey:@"itemsList"];
                for (int i = 0; i < [temp count]; i++) {
                    NSDictionary *dic = [temp objectAtIndex:i];
                    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@",[dic objectForKey:@"item_id"],@"#",[dic objectForKey:@"item_desc"],@"#",[dic objectForKey:@"quantity"],@"#",[dic objectForKey:@"UOM"],@"#",[dic objectForKey:@"inspection_details"]];
                    [itemArray addObject:str];
                }
                po_refValue.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"po_ref"]];
                shipment_note_refValue.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"shipment_note_ref"]];
                inspected_byValue.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"inspected_by"]];
                received_onValue.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"received_on"]];
                remarksValue.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"remarks"]];
                inspection_statusValue.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"inspection_status"]];
                inspection_summaryValue.text = [NSString stringWithFormat:@"%@",[JSON1 objectForKey:@"inspection_summary"]];
//                itemIdArray = [[NSMutableArray alloc] initWithArray:[JSON1 objectForKey:@"invoiceItems"]];
//                
//                json = [JSON1 objectForKey:@"invoice"];
//                orderIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"orderId"]];
//                shipmentIdValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentId"]];
//                shipmentNoteIdValue.text =[NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentNoteId"]];
//                customerNameValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"customerName"]];
//                buildingNoValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"buildingNo"]];
//                streetNameValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"streetName"]];
//                cityValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"city"]];
//                countryValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"country"]];
//                zip_codeValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"zip_code"]];
//                shipmentAgencyValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentAgency"]];
//                shipmentCostValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipmentCost"]];
//                insuranceCostValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"insuranceCost"]];
//                paymentTermsValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"paymentTerms"]];
//                invoiceDateValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"invoiceDate"]];
//                remarksValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"remarks"]];
//                subTotalData.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"totalItemCost"]];
//                taxData.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"tax"]];
//                totAmountData.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"totalItemCost"]];
                
                [itemTable reloadData];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To Load Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
    }
}

-(void)popUpView {
    AudioServicesPlaySystemSound (soundFileObject);
    PopOverViewController *popOverViewController = [[PopOverViewController alloc] init];
    
    UIView *categoriesView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 160.0, 100.0)];
    categoriesView.opaque = NO;
    categoriesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    categoriesView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    categoriesView.layer.borderWidth = 2.0f;
    [categoriesView setHidden:NO];
    CGFloat top = 0.0;
    
    NSMutableArray *folderStructure = [[NSMutableArray alloc] init];
    [folderStructure addObject:@"Home"];
    [folderStructure addObject:@"Edit Inspection"];
    [folderStructure addObject:@"Logout"];
    
    for (int i = 0; i < [folderStructure count]; i++) {
        UIButton *upload = [[UIButton alloc] init];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            categoriesView.frame = CGRectMake(0, 0, 230, 150.0);
            upload.frame = CGRectMake(-25, top, 280.0, 50.0);
        }
        else{
            upload.titleLabel.font = [UIFont systemFontOfSize:15.0f];
            upload.frame = CGRectMake(0.0, top, 160.0, 50.0);
        }
        upload.backgroundColor = [UIColor clearColor];
        upload.tag = i;
        [upload setTitle:[folderStructure objectAtIndex:i] forState:UIControlStateNormal];
        [upload setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [upload addTarget:self action:@selector(buttonClicked1:) forControlEvents:UIControlEventTouchUpInside];
        [[upload layer] setBorderWidth:0.5f];
        [[upload layer] setBorderColor:[UIColor grayColor].CGColor];
        top = top+50.0;
        [categoriesView addSubview:upload];
    }
    
    popOverViewController.view = categoriesView;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        popOverViewController.preferredContentSize =  CGSizeMake(categoriesView.frame.size.width, categoriesView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popOverViewController];
        
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        self.popOver = popover;
    }
    else {
        
        popOverViewController.contentSizeForViewInPopover = CGSizeMake(160.0, 150.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popOverViewController];
        // popover.contentViewController.view.alpha = 0.0;
        [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        self.popOver = popover;
    }
}

-(void) buttonClicked1:(UIButton*)sender
{
    [self.popOver dismissPopoverAnimated:YES];
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender.tag == 0) {
        
        [self.popOver dismissPopoverAnimated:YES];
        OmniHomePage *home = [[[OmniHomePage alloc] init] autorelease];
        [self.navigationController pushViewController:home animated:YES];
    }
    else if (sender.tag == 1) {
        
        //        if ([statusValue.text isEqualToString:@"Pending"]) {
        
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        
//        EditWarehouseInvoice *editReceipt = [[EditWarehouseInvoice alloc] initWithInvoiceID:wareInvoiceID_];
//        [self.navigationController pushViewController:editReceipt animated:YES];
        //        }
        //        else {
        //
        //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Issue cannot be edited" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //            [alert show];
        //
        //        }
    }
    else{
        [self.popOver dismissPopoverAnimated:YES];
        OmniHomePage *omniRetailerViewController = [[OmniHomePage alloc] init];
        [omniRetailerViewController logOut];
    }
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == itemTable){
        
        return [itemArray count];
    }
    else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == itemTable){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (indexPath.row == 0) {
                return 70.0;
            }
            else{
                return 50.0;
            }
            
        }
        else {
            return 150.0;
        }
        
    }
    else{
        return 0.0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"TableView";
    if (tableView == itemTable){
        if ([itemArray count] >= 1) {
            if ([hlcell.contentView subviews]){
                for (UIView *subview in [hlcell.contentView subviews]) {
                    [subview removeFromSuperview];
                }
            }
            
            if(hlcell == nil) {
                hlcell =  [[[UITableViewCell alloc]
                            initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
                hlcell.accessoryType = UITableViewCellAccessoryNone;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    hlcell.textLabel.font = [UIFont boldSystemFontOfSize:25];
                }
            }
            NSArray *temp = [[itemArray objectAtIndex:indexPath.row] componentsSeparatedByString:@"#"];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.separatorColor = [UIColor clearColor];
                
                UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(3, 0, 151, 50)] autorelease];
                label1.font = [UIFont systemFontOfSize:22.0];
                label1.layer.borderWidth = 1.5;
                label1.backgroundColor = [UIColor clearColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.numberOfLines = 2;
                label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label1.lineBreakMode = NSLineBreakByWordWrapping;
                label1.text = [temp objectAtIndex:0];
                label1.textColor = [UIColor whiteColor];
                
                UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(154, 0, 151, 50)] autorelease];
                label5.font = [UIFont systemFontOfSize:22.0];
                label5.layer.borderWidth = 1.5;
                label5.backgroundColor = [UIColor clearColor];
                label5.textAlignment = NSTextAlignmentCenter;
                label5.numberOfLines = 2;
                label5.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label5.lineBreakMode = NSLineBreakByWordWrapping;
                label5.text = [temp objectAtIndex:1];
                label5.textColor = [UIColor whiteColor];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(305, 0, 150, 50)] autorelease];
                label2.font = [UIFont systemFontOfSize:22.0];
                label2.backgroundColor =  [UIColor clearColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [temp objectAtIndex:2];
                label2.textColor = [UIColor whiteColor];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor clearColor];
                qtyChange.frame = CGRectMake(456, 0, 151, 50);
                
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[temp objectAtIndex:3] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:22.0];
                CALayer * layer = [qtyChange layer];
                [qtyChange setEnabled:NO];
                
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:0.0];
                [layer setBorderWidth:1.5];
                [layer setBorderColor:[[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0] CGColor]];
                qtyChange.enabled = NO;
                
                
                UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(607, 0, 150, 50)] autorelease];
                label4.font = [UIFont systemFontOfSize:22.0];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor clearColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                label4.textColor = [UIColor whiteColor];
                NSString *str = [temp objectAtIndex:4];
                label4.text = str;
                
                
                [hlcell.contentView addSubview:label1];
                [hlcell.contentView addSubview:label2];
                [hlcell.contentView addSubview:label5];
                [hlcell.contentView addSubview:qtyChange];
                [hlcell.contentView addSubview:label4];
                
            }
            else{
                
                // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.separatorColor = [UIColor clearColor];
                
                UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 68, 34)] autorelease];
                label1.font = [UIFont systemFontOfSize:13.0];
                label1.backgroundColor = [UIColor whiteColor];
                label1.textAlignment = NSTextAlignmentCenter;
                label1.numberOfLines = 2;
                label1.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label1.lineBreakMode = NSLineBreakByWordWrapping;
                label1.text = [temp objectAtIndex:1];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(66, 0, 68, 34)] autorelease];
                label2.font = [UIFont systemFontOfSize:13.0];
                label2.backgroundColor =  [UIColor whiteColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [temp objectAtIndex:2];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor whiteColor];
                qtyChange.frame = CGRectMake(132, 0, 72, 34);
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[temp objectAtIndex:3] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:14.0];
                CALayer * layer = [qtyChange layer];
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:0.0];
                [layer setBorderWidth:1.5];
                [layer setBorderColor:[[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0] CGColor]];
                
                
                UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(202, 0, 70, 34)] autorelease];
                label4.font = [UIFont systemFontOfSize:13.0];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor whiteColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                NSString *str = [temp objectAtIndex:4];
                label4.text = [NSString stringWithFormat:@"%@%@",str,@".0"];
                
                
                
                
                [hlcell.contentView addSubview:label1];
                [hlcell.contentView addSubview:label2];
                [hlcell.contentView addSubview:qtyChange];
                [hlcell.contentView addSubview:label4];
            }
            
        }
        hlcell.backgroundColor = [UIColor clearColor];
        
        [hlcell setTag:indexPath.row];
        
    }
    return hlcell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
