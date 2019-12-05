//
//  ViewWareHousePurchaseOrder.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import "ViewWareHousePurchaseOrder.h"
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "PopOverViewController.h"
#import "OmniHomePage.h"
#import "WHPurchaseOrders.h"
#import "EditWareHousePurchaseOrder.h"
#import "RequestHeader.h"

@interface ViewWareHousePurchaseOrder ()

@end

@implementation ViewWareHousePurchaseOrder

@synthesize soundFileURLRef,soundFileObject,popOver;

NSString *wareHouzPurchaseOrderID = @"";

-(id) initWithorderID:(NSString *)orderID
{
    wareHouzPurchaseOrderID = [orderID copy];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Audio Sound load url......
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
    self.soundFileURLRef = (CFURLRef) [tapSound retain];
    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
    
    self.navigationController.navigationBarHidden = NO;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 600.0, 45.0)];
    titleView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_200.png"]];
    logoView.backgroundColor = [UIColor clearColor];
    logoView.frame = CGRectMake(150.0, 0.0, 45.0, 45.0);
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(200.0, -13.0, 300.0, 70.0)];
    titleLbl.text = @"Purchase Order Details";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0f];
    [titleView addSubview:logoView];
    [titleView addSubview:titleLbl];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }
    else{
        logoView.frame = CGRectMake(20.0, 7.0, 30.0, 30.0);
        titleLbl.frame = CGRectMake(55.0, -12.0, 200.0, 70.0);
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12.0f];
    }
    
    self.navigationItem.titleView = titleView;

    
    //main view bakgroung setting...
    self.view.backgroundColor = [UIColor blackColor];
    
    popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [popButton setImage:[UIImage imageNamed:@"emails-letters.png"] forState:UIControlStateNormal];
    popButton.frame = CGRectMake(0, 0, 40.0, 40.0);
    [popButton addTarget:self action:@selector(popUpView) forControlEvents:UIControlEventTouchUpInside];
    
    sendButton =[[UIBarButtonItem alloc]init];
    sendButton.customView = popButton;
    sendButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem=sendButton;
    
    createReceiptView = [[UIScrollView alloc] init];
    createReceiptView.backgroundColor = [UIColor clearColor];
    createReceiptView.bounces = FALSE;
    createReceiptView.hidden = NO;
    
    UILabel *receiptRefNo = [[[UILabel alloc] init] autorelease];
    receiptRefNo.text = @"PO Order ID :";
    receiptRefNo.layer.masksToBounds = YES;
    receiptRefNo.numberOfLines = 2;
    [receiptRefNo setTextAlignment:NSTextAlignmentLeft];
    receiptRefNo.font = [UIFont boldSystemFontOfSize:14.0];
    receiptRefNo.textColor = [UIColor whiteColor];
    
    receiptRefNoValue = [[[UILabel alloc] init] autorelease];
    receiptRefNoValue.layer.masksToBounds = YES;
    receiptRefNoValue.text = @"*******";
    receiptRefNoValue.numberOfLines = 2;
    [receiptRefNoValue setTextAlignment:NSTextAlignmentLeft];
    receiptRefNoValue.font = [UIFont boldSystemFontOfSize:14.0];
    receiptRefNoValue.textColor = [UIColor whiteColor];
    
    UILabel *supplierID = [[[UILabel alloc] init] autorelease];
    supplierID.text = @"Supplier ID :";
    supplierID.layer.masksToBounds = YES;
    supplierID.numberOfLines = 2;
    [supplierID setTextAlignment:NSTextAlignmentLeft];
    supplierID.font = [UIFont boldSystemFontOfSize:14.0];
    supplierID.textColor = [UIColor whiteColor];
    
    supplierIDValue = [[[UILabel alloc] init] autorelease];
    supplierIDValue.layer.masksToBounds = YES;
    supplierIDValue.text = @"*******";
    supplierIDValue.numberOfLines = 2;
    [supplierIDValue setTextAlignment:NSTextAlignmentLeft];
    supplierIDValue.font = [UIFont boldSystemFontOfSize:14.0];
    supplierIDValue.textColor = [UIColor whiteColor];
    
    UILabel *supplierName = [[[UILabel alloc] init] autorelease];
    supplierName.text = @"Supplier Name :";
    supplierName.layer.masksToBounds = YES;
    supplierName.numberOfLines = 2;
    [supplierName setTextAlignment:NSTextAlignmentLeft];
    supplierName.font = [UIFont boldSystemFontOfSize:14.0];
    supplierName.textColor = [UIColor whiteColor];
    
    supplierNameValue = [[[UILabel alloc] init] autorelease];
    supplierNameValue.layer.masksToBounds = YES;
    supplierNameValue.text = @"**********";
    supplierNameValue.numberOfLines = 2;
    [supplierNameValue setTextAlignment:NSTextAlignmentLeft];
    supplierNameValue.font = [UIFont boldSystemFontOfSize:14.0];
    supplierNameValue.textColor = [UIColor whiteColor];
    
    UILabel *location = [[[UILabel alloc] init] autorelease];
    location.text = @"Supplier Contact Name :";
    location.layer.masksToBounds = YES;
    location.numberOfLines = 2;
    [location setTextAlignment:NSTextAlignmentLeft];
    location.font = [UIFont boldSystemFontOfSize:14.0];
    location.textColor = [UIColor whiteColor];
    
    locationValue = [[[UILabel alloc] init] autorelease];
    locationValue.layer.masksToBounds = YES;
    locationValue.text = @"**********";
    locationValue.numberOfLines = 2;
    [locationValue setTextAlignment:NSTextAlignmentLeft];
    locationValue.font = [UIFont boldSystemFontOfSize:14.0];
    locationValue.textColor = [UIColor whiteColor];
    
    UILabel *deliveredBY = [[[UILabel alloc] init] autorelease];
    deliveredBY.text = @"Delivery Date :";
    deliveredBY.layer.masksToBounds = YES;
    deliveredBY.numberOfLines = 2;
    [deliveredBY setTextAlignment:NSTextAlignmentLeft];
    deliveredBY.font = [UIFont boldSystemFontOfSize:14.0];
    deliveredBY.textColor = [UIColor whiteColor];
    
    deliveredBYValue = [[[UILabel alloc] init] autorelease];
    deliveredBYValue.layer.masksToBounds = YES;
    deliveredBYValue.text = @"**********";
    deliveredBYValue.numberOfLines = 2;
    [deliveredBYValue setTextAlignment:NSTextAlignmentLeft];
    deliveredBYValue.font = [UIFont boldSystemFontOfSize:14.0];
    deliveredBYValue.textColor = [UIColor whiteColor];
    
    UILabel *inspectedBY = [[[UILabel alloc] init] autorelease];
    inspectedBY.text = @"Shipment Location :";
    inspectedBY.layer.masksToBounds = YES;
    inspectedBY.numberOfLines = 2;
    [inspectedBY setTextAlignment:NSTextAlignmentLeft];
    inspectedBY.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedBY.textColor = [UIColor whiteColor];
    
    inspectedBYValue = [[[UILabel alloc] init] autorelease];
    inspectedBYValue.layer.masksToBounds = YES;
    inspectedBYValue.text = @"*********";
    inspectedBYValue.numberOfLines = 2;
    [inspectedBYValue setTextAlignment:NSTextAlignmentLeft];
    inspectedBYValue.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedBYValue.textColor = [UIColor whiteColor];
    
    UILabel *date = [[[UILabel alloc] init] autorelease];
    date.text = @"Shipment City :";
    date.layer.masksToBounds = YES;
    date.numberOfLines = 2;
    [date setTextAlignment:NSTextAlignmentLeft];
    date.font = [UIFont boldSystemFontOfSize:14.0];
    date.textColor = [UIColor whiteColor];
    
    dateValue = [[[UILabel alloc] init] autorelease];
    dateValue.layer.masksToBounds = YES;
    dateValue.text = @"*********";
    dateValue.numberOfLines = 2;
    [dateValue setTextAlignment:NSTextAlignmentLeft];
    dateValue.font = [UIFont boldSystemFontOfSize:14.0];
    dateValue.textColor = [UIColor whiteColor];
    
    UILabel *poRef = [[[UILabel alloc] init] autorelease];
    poRef.text = @"Shipment Street :";
    poRef.layer.masksToBounds = YES;
    poRef.numberOfLines = 2;
    [poRef setTextAlignment:NSTextAlignmentLeft];
    poRef.font = [UIFont boldSystemFontOfSize:14.0];
    poRef.textColor = [UIColor whiteColor];
    
    poRefValue = [[[UILabel alloc] init] autorelease];
    poRefValue.layer.masksToBounds = YES;
    poRefValue.text = @"**********";
    poRefValue.numberOfLines = 2;
    [poRefValue setTextAlignment:NSTextAlignmentLeft];
    poRefValue.font = [UIFont boldSystemFontOfSize:14.0];
    poRefValue.textColor = [UIColor whiteColor];
    
    UILabel *shipment = [[[UILabel alloc] init] autorelease];
    shipment.text = @"Shipment Mode :";
    shipment.layer.masksToBounds = YES;
    shipment.numberOfLines = 2;
    [shipment setTextAlignment:NSTextAlignmentLeft];
    shipment.font = [UIFont boldSystemFontOfSize:14.0];
    shipment.textColor = [UIColor whiteColor];
    
    shipmentValue = [[[UILabel alloc] init] autorelease];
    shipmentValue.layer.masksToBounds = YES;
    shipmentValue.text = @"*********";
    shipmentValue.numberOfLines = 2;
    [shipmentValue setTextAlignment:NSTextAlignmentLeft];
    shipmentValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentValue.textColor = [UIColor whiteColor];
    
    UILabel *order_sub_by = [[[UILabel alloc] init] autorelease];
    order_sub_by.text = @"Order Submitted By :";
    order_sub_by.layer.masksToBounds = YES;
    order_sub_by.numberOfLines = 2;
    [order_sub_by setTextAlignment:NSTextAlignmentLeft];
    order_sub_by.font = [UIFont boldSystemFontOfSize:14.0];
    order_sub_by.textColor = [UIColor whiteColor];
    
    orderSubmittedByValue = [[[UILabel alloc] init] autorelease];
    orderSubmittedByValue.layer.masksToBounds = YES;
    orderSubmittedByValue.text = @"*********";
    orderSubmittedByValue.numberOfLines = 2;
    [orderSubmittedByValue setTextAlignment:NSTextAlignmentLeft];
    orderSubmittedByValue.font = [UIFont boldSystemFontOfSize:14.0];
    orderSubmittedByValue.textColor = [UIColor whiteColor];
    
    UILabel *shipping_terms = [[[UILabel alloc] init] autorelease];
    shipping_terms.text = @"Shipping Terms :";
    shipping_terms.layer.masksToBounds = YES;
    shipping_terms.numberOfLines = 2;
    [shipping_terms setTextAlignment:NSTextAlignmentLeft];
    shipping_terms.font = [UIFont boldSystemFontOfSize:14.0];
    shipping_terms.textColor = [UIColor whiteColor];
    
    shippingTermsValue = [[[UILabel alloc] init] autorelease];
    shippingTermsValue.layer.masksToBounds = YES;
    shippingTermsValue.text = @"*********";
    shippingTermsValue.numberOfLines = 2;
    [shippingTermsValue setTextAlignment:NSTextAlignmentLeft];
    shippingTermsValue.font = [UIFont boldSystemFontOfSize:14.0];
    shippingTermsValue.textColor = [UIColor whiteColor];
    
    UILabel *order_app_by = [[[UILabel alloc] init] autorelease];
    order_app_by.text = @"Order Approved By :";
    order_app_by.layer.masksToBounds = YES;
    order_app_by.numberOfLines = 2;
    [order_app_by setTextAlignment:NSTextAlignmentLeft];
    order_app_by.font = [UIFont boldSystemFontOfSize:14.0];
    order_app_by.textColor = [UIColor whiteColor];
    
    orderAppBy = [[[UILabel alloc] init] autorelease];
    orderAppBy.layer.masksToBounds = YES;
    orderAppBy.text = @"*********";
    orderAppBy.numberOfLines = 2;
    [orderAppBy setTextAlignment:NSTextAlignmentLeft];
    orderAppBy.font = [UIFont boldSystemFontOfSize:14.0];
    orderAppBy.textColor = [UIColor whiteColor];
    
    UILabel *creditTerms = [[[UILabel alloc] init] autorelease];
    creditTerms.text = @"Credit Terms :";
    creditTerms.layer.masksToBounds = YES;
    creditTerms.numberOfLines = 2;
    [creditTerms setTextAlignment:NSTextAlignmentLeft];
    creditTerms.font = [UIFont boldSystemFontOfSize:14.0];
    creditTerms.textColor = [UIColor whiteColor];
    
    creditTermsValue = [[[UILabel alloc] init] autorelease];
    creditTermsValue.layer.masksToBounds = YES;
    creditTermsValue.text = @"*********";
    creditTermsValue.numberOfLines = 2;
    [creditTermsValue setTextAlignment:NSTextAlignmentLeft];
    creditTermsValue.font = [UIFont boldSystemFontOfSize:14.0];
    creditTermsValue.textColor = [UIColor whiteColor];
    
    UILabel *payTerms = [[[UILabel alloc] init] autorelease];
    payTerms.text = @"Payment Terms :";
    payTerms.layer.masksToBounds = YES;
    payTerms.numberOfLines = 2;
    [payTerms setTextAlignment:NSTextAlignmentLeft];
    payTerms.font = [UIFont boldSystemFontOfSize:14.0];
    payTerms.textColor = [UIColor whiteColor];
    
    payTermsValue = [[[UILabel alloc] init] autorelease];
    payTermsValue.layer.masksToBounds = YES;
    payTermsValue.text = @"*********";
    payTermsValue.numberOfLines = 2;
    [payTermsValue setTextAlignment:NSTextAlignmentLeft];
    payTermsValue.font = [UIFont boldSystemFontOfSize:14.0];
    payTermsValue.textColor = [UIColor whiteColor];
    
    UILabel *label2 = [[[UILabel alloc] init] autorelease];
    label2.text = @"Item Id";
    label2.layer.cornerRadius = 14;
    label2.layer.masksToBounds = YES;
    label2.numberOfLines = 2;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.font = [UIFont boldSystemFontOfSize:14.0];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    
    UILabel *label11 = [[[UILabel alloc] init] autorelease];
    label11.text = @"Item Name";
    label11.layer.cornerRadius = 14;
    label11.layer.masksToBounds = YES;
    label11.numberOfLines = 2;
    [label11 setTextAlignment:NSTextAlignmentCenter];
    label11.font = [UIFont boldSystemFontOfSize:14.0];
    label11.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label11.textColor = [UIColor whiteColor];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"Price";
    label3.layer.cornerRadius = 14;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.font = [UIFont boldSystemFontOfSize:14.0];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Quantity";
    label4.layer.cornerRadius = 14;
    label4.layer.masksToBounds = YES;
    [label4 setTextAlignment:NSTextAlignmentCenter];
    label4.font = [UIFont boldSystemFontOfSize:14.0];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    
    UILabel *label5 = [[[UILabel alloc] init] autorelease];
    label5.text = @"Cost";
    label5.layer.cornerRadius = 14;
    label5.layer.masksToBounds = YES;
    [label5 setTextAlignment:NSTextAlignmentCenter];
    label5.font = [UIFont boldSystemFontOfSize:14.0];
    label5.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label5.textColor = [UIColor whiteColor];
    
    UILabel *label12 = [[[UILabel alloc] init] autorelease];
    label12.text = @"Make";
    label12.layer.cornerRadius = 14;
    label12.layer.masksToBounds = YES;
    [label12 setTextAlignment:NSTextAlignmentCenter];
    label12.font = [UIFont boldSystemFontOfSize:14.0];
    label12.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label12.textColor = [UIColor whiteColor];
    
    UILabel *label8 = [[[UILabel alloc] init] autorelease];
    label8.text = @"Model";
    label8.layer.cornerRadius = 14;
    label8.layer.masksToBounds = YES;
    [label8 setTextAlignment:NSTextAlignmentCenter];
    label8.font = [UIFont boldSystemFontOfSize:14.0];
    label8.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label8.textColor = [UIColor whiteColor];
    
    UILabel *label9 = [[[UILabel alloc] init] autorelease];
    label9.text = @"Color";
    label9.layer.cornerRadius = 14;
    label9.layer.masksToBounds = YES;
    [label9 setTextAlignment:NSTextAlignmentCenter];
    label9.font = [UIFont boldSystemFontOfSize:14.0];
    label9.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label9.textColor = [UIColor whiteColor];
    
    UILabel *label10 = [[[UILabel alloc] init] autorelease];
    label10.text = @"Size";
    label10.layer.cornerRadius = 14;
    label10.layer.masksToBounds = YES;
    [label10 setTextAlignment:NSTextAlignmentCenter];
    label10.font = [UIFont boldSystemFontOfSize:14.0];
    label10.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label10.textColor = [UIColor whiteColor];
    
    /** UIScrollView Design */
    scrollView = [[UIScrollView alloc] init];
    scrollView.hidden = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = FALSE;
    
    // Table for storing the items ..
    cartTable = [[UITableView alloc] init];
    cartTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    cartTable.backgroundColor = [UIColor clearColor];
    [cartTable setDataSource:self];
    [cartTable setDelegate:self];
    
    UILabel *label6 = [[[UILabel alloc] init] autorelease];
    label6.text = @"Total Quantity";
    label6.layer.cornerRadius = 14;
    label6.layer.masksToBounds = YES;
    [label6 setTextAlignment:NSTextAlignmentLeft];
    label6.font = [UIFont boldSystemFontOfSize:14.0];
    label6.textColor = [UIColor whiteColor];
    
    UILabel *label7 = [[[UILabel alloc] init] autorelease];
    label7.text = @"Total Cost";
    label7.layer.cornerRadius = 14;
    label7.layer.masksToBounds = YES;
    [label7 setTextAlignment:NSTextAlignmentLeft];
    label7.font = [UIFont boldSystemFontOfSize:14.0];
    label7.textColor = [UIColor whiteColor];
    
    totalQuantity = [[[UILabel alloc] init] autorelease];
    totalQuantity.text = @"0";
    totalQuantity.layer.cornerRadius = 14;
    totalQuantity.layer.masksToBounds = YES;
    [totalQuantity setTextAlignment:NSTextAlignmentLeft];
    totalQuantity.font = [UIFont boldSystemFontOfSize:14.0];
    totalQuantity.textColor = [UIColor whiteColor];
    
    totalCost = [[[UILabel alloc] init] autorelease];
    totalCost.text = @"0.0";
    totalCost.layer.cornerRadius = 14;
    totalCost.layer.masksToBounds = YES;
    [totalCost setTextAlignment:NSTextAlignmentLeft];
    totalCost.font = [UIFont boldSystemFontOfSize:12.0];
    totalCost.textColor = [UIColor whiteColor];
    
    itemIdArray = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        createReceiptView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 900);
        
        receiptRefNo.font = [UIFont boldSystemFontOfSize:20];
        receiptRefNo.frame = CGRectMake(10, 0.0, 200.0, 55);
        receiptRefNoValue.font = [UIFont boldSystemFontOfSize:20];
        receiptRefNoValue.frame = CGRectMake(250.0, 0.0, 200.0, 55);
        supplierID.font = [UIFont boldSystemFontOfSize:20];
        supplierID.frame = CGRectMake(10, 60.0, 200.0, 55);
        supplierIDValue.font = [UIFont boldSystemFontOfSize:20];
        supplierIDValue.frame = CGRectMake(250.0, 60.0, 200.0, 55);
        supplierName.font = [UIFont boldSystemFontOfSize:20];
        supplierName.frame = CGRectMake(10, 120.0, 200.0, 55);
        supplierNameValue.font = [UIFont boldSystemFontOfSize:20];
        supplierNameValue.frame = CGRectMake(250.0, 120.0, 200.0, 55);
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(10, 180.0, 200, 55);
        locationValue.font = [UIFont boldSystemFontOfSize:20];
        locationValue.frame = CGRectMake(250.0, 180.0, 200, 55);
        deliveredBY.font = [UIFont boldSystemFontOfSize:20];
        deliveredBY.frame = CGRectMake(460.0, 0.0, 200, 55);
        deliveredBYValue.font = [UIFont boldSystemFontOfSize:20];
        deliveredBYValue.frame = CGRectMake(700.0, 0.0, 200, 55);
        inspectedBY.font = [UIFont boldSystemFontOfSize:20];
        inspectedBY.frame = CGRectMake(460.0, 60, 200, 55);
        inspectedBYValue.font = [UIFont boldSystemFontOfSize:20];
        inspectedBYValue.frame = CGRectMake(700.0, 60, 200.0, 55);
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake(460.0, 120.0, 200.0, 55);
        dateValue.font = [UIFont boldSystemFontOfSize:20];
        dateValue.frame = CGRectMake(700.0, 120.0, 200.0, 55);
        poRef.font = [UIFont boldSystemFontOfSize:20];
        poRef.frame = CGRectMake(460.0, 180.0, 200.0, 55);
        poRefValue.font = [UIFont boldSystemFontOfSize:20];
        poRefValue.frame = CGRectMake(700.0, 180.0, 200.0, 55);
        shipment.font = [UIFont boldSystemFontOfSize:20];
        shipment.frame = CGRectMake(10, 240.0, 200.0, 55);
        shipmentValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentValue.frame = CGRectMake(250.0, 240.0, 200.0, 55);
        order_sub_by.font = [UIFont boldSystemFontOfSize:20];
        order_sub_by.frame = CGRectMake(460.0, 240.0, 200.0, 55.0);
        orderSubmittedByValue.font = [UIFont boldSystemFontOfSize:20];
        orderSubmittedByValue.frame = CGRectMake(700.0, 240.0, 200.0, 55.0);
        shipping_terms.font = [UIFont boldSystemFontOfSize:20];
        shipping_terms.frame = CGRectMake(10, 300.0, 200.0, 55.0);
        shippingTermsValue.font = [UIFont boldSystemFontOfSize:20];
        shippingTermsValue.frame = CGRectMake(250.0, 300.0, 200.0, 55.0);
        order_app_by.font = [UIFont boldSystemFontOfSize:20];
        order_app_by.frame = CGRectMake(460.0, 300.0, 200.0, 55.0);
        orderAppBy.font = [UIFont boldSystemFontOfSize:20];
        orderAppBy.frame = CGRectMake(700.0, 300.0, 200.0, 55.0);
        creditTerms.font = [UIFont boldSystemFontOfSize:20];
        creditTerms.frame = CGRectMake(10.0, 360.0, 200.0, 55.0);
        creditTermsValue.font = [UIFont boldSystemFontOfSize:20];
        creditTermsValue.frame = CGRectMake(250.0, 360.0, 200.0, 55.0);
        payTerms.font = [UIFont boldSystemFontOfSize:20];
        payTerms.frame = CGRectMake(460.0, 360.0, 200.0, 55.0);
        payTermsValue.font = [UIFont boldSystemFontOfSize:20];
        payTermsValue.frame = CGRectMake(700.0, 360.0, 200.0, 55.0);
        
        
        label2.font = [UIFont boldSystemFontOfSize:20];
        label2.frame = CGRectMake(10, 420.0, 90, 55);
        label11.font = [UIFont boldSystemFontOfSize:20];
        label11.frame = CGRectMake(103, 420.0, 90, 55);
        label3.font = [UIFont boldSystemFontOfSize:20];
        label3.frame = CGRectMake(195, 420.0, 90, 55);
        label4.font = [UIFont boldSystemFontOfSize:20];
        label4.frame = CGRectMake(288, 420.0, 90, 55);
        label5.font = [UIFont boldSystemFontOfSize:20];
        label5.frame = CGRectMake(381, 420.0, 110, 55);
        label12.font = [UIFont boldSystemFontOfSize:20];
        label12.frame = CGRectMake(494, 420.0, 110, 55);
        label8.font = [UIFont boldSystemFontOfSize:20];
        label8.frame = CGRectMake(607, 420.0, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:20];
        label9.frame = CGRectMake(720.0, 420.0, 110, 55);
        label10.font = [UIFont boldSystemFontOfSize:20];
        label10.frame = CGRectMake(833.0, 420.0, 110, 55);
        
        scrollView.frame = CGRectMake(10, 480.0, 980.0, 300.0);
        scrollView.contentSize = CGSizeMake(778, 1500);
        cartTable.frame = CGRectMake(0, 0, 980.0,250.0);
        
        label6.font = [UIFont boldSystemFontOfSize:20];
        label6.frame = CGRectMake(10.0, 790, 200, 55.0);
        
        label7.font = [UIFont boldSystemFontOfSize:20];
        label7.frame = CGRectMake(10.0, 855, 200, 55);
        
        totalQuantity.font = [UIFont boldSystemFontOfSize:20];
        totalQuantity.frame = CGRectMake(580.0, 790, 200, 55);
        
        totalCost.font = [UIFont boldSystemFontOfSize:20];
        totalCost.frame = CGRectMake(580.0, 855, 200, 55);
    }
    else {
        
        createReceiptView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 310, 580);
        
        receiptRefNo.font = [UIFont boldSystemFontOfSize:15];
        [receiptRefNo setBackgroundColor:[UIColor clearColor]];
        receiptRefNo.frame = CGRectMake(5, 0.0, 150.0, 35);
        receiptRefNoValue.font = [UIFont boldSystemFontOfSize:15];
        receiptRefNoValue.frame = CGRectMake(165.0, 0.0, 150.0, 35);
        [receiptRefNoValue setBackgroundColor:[UIColor clearColor]];
        supplierID.font = [UIFont boldSystemFontOfSize:15];
        supplierID.frame = CGRectMake(5, 45.0, 150.0, 35);
        [supplierID setBackgroundColor:[UIColor clearColor]];
        supplierIDValue.font = [UIFont boldSystemFontOfSize:15];
        supplierIDValue.frame = CGRectMake(165.0, 45.0, 150.0, 35);
        [supplierIDValue setBackgroundColor:[UIColor clearColor]];
        supplierName.font = [UIFont boldSystemFontOfSize:15];
        supplierName.frame = CGRectMake(5, 85.0, 150.0, 35);
        [supplierName setBackgroundColor:[UIColor clearColor]];
        supplierNameValue.font = [UIFont boldSystemFontOfSize:15];
        supplierNameValue.frame = CGRectMake(165.0, 85.0, 150.0, 35);
        [supplierNameValue setBackgroundColor:[UIColor clearColor]];
        location.font = [UIFont boldSystemFontOfSize:15];
        location.frame = CGRectMake(5, 125.0, 150.0, 35);
        [location setBackgroundColor:[UIColor clearColor]];
        locationValue.font = [UIFont boldSystemFontOfSize:15];
        locationValue.frame = CGRectMake(165.0, 125.0, 150.0, 35);
        [locationValue setBackgroundColor:[UIColor clearColor]];
        
        deliveredBY.font = [UIFont boldSystemFontOfSize:15];
        deliveredBY.frame = CGRectMake(325, 0.0, 150.0, 35);
        [deliveredBY setBackgroundColor:[UIColor clearColor]];
        deliveredBYValue.font = [UIFont boldSystemFontOfSize:15];
        deliveredBYValue.frame = CGRectMake(450.0, 0.0, 150.0, 35);
        [deliveredBYValue setBackgroundColor:[UIColor clearColor]];
        inspectedBY.font = [UIFont boldSystemFontOfSize:15];
        inspectedBY.frame = CGRectMake(325, 45.0, 150.0, 35);
        [inspectedBY setBackgroundColor:[UIColor clearColor]];
        inspectedBYValue.font = [UIFont boldSystemFontOfSize:15];
        inspectedBYValue.frame = CGRectMake(450.0, 45.0, 150.0, 35);
        [inspectedBYValue setBackgroundColor:[UIColor clearColor]];
        date.font = [UIFont boldSystemFontOfSize:15];
        date.frame = CGRectMake(325, 85.0, 150.0, 35);
        [date setBackgroundColor:[UIColor clearColor]];
        dateValue.font = [UIFont boldSystemFontOfSize:15];
        dateValue.frame = CGRectMake(450.0, 85.0, 150.0, 35);
        [dateValue setBackgroundColor:[UIColor clearColor]];
        poRef.font = [UIFont boldSystemFontOfSize:15];
        poRef.frame = CGRectMake(325, 125.0, 125.0, 35);
        [poRef setBackgroundColor:[UIColor clearColor]];
        poRefValue.font = [UIFont boldSystemFontOfSize:15];
        poRefValue.frame = CGRectMake(450.0, 125.0, 150.0, 35);
        [poRefValue setBackgroundColor:[UIColor clearColor]];
        shipment.font = [UIFont boldSystemFontOfSize:15];
        shipment.frame = CGRectMake(5, 165.0, 150.0, 35);
        [shipment setBackgroundColor:[UIColor clearColor]];
        shipmentValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentValue.frame = CGRectMake(165.0, 165.0, 150.0, 35);
        [shipmentValue setBackgroundColor:[UIColor clearColor]];
        status.hidden = YES;
        statusValue.hidden = YES;
        status.font = [UIFont boldSystemFontOfSize:15];
        status.frame = CGRectMake(325.0, 165.0, 200.0, 55.0);
        [status setBackgroundColor:[UIColor clearColor]];
        
        statusValue.font = [UIFont boldSystemFontOfSize:15];
        statusValue.frame = CGRectMake(450.0, 165.0, 150.0, 55);
        [statusValue setBackgroundColor:[UIColor clearColor]];
        
        
        
        label2.font = [UIFont boldSystemFontOfSize:15];
        label2.frame = CGRectMake(10, 230.0, 90, 35);
        label11.font = [UIFont boldSystemFontOfSize:15];
        label11.frame = CGRectMake(103, 230.0, 90, 35);
        label3.font = [UIFont boldSystemFontOfSize:15];
        label3.frame = CGRectMake(195, 230.0, 90, 35);
        label4.font = [UIFont boldSystemFontOfSize:15];
        label4.frame = CGRectMake(288, 230.0, 90, 35);
        label5.font = [UIFont boldSystemFontOfSize:15];
        label5.frame = CGRectMake(381, 230.0, 110, 35);
        // label12.font = [UIFont boldSystemFontOfSize:20];
        // label12.frame = CGRectMake(494, 300.0, 110, 55);
        // label8.font = [UIFont boldSystemFontOfSize:20];
        //  label8.frame = CGRectMake(607, 300.0, 110, 55);
        label9.font = [UIFont boldSystemFontOfSize:15];
        label9.frame = CGRectMake(494, 230.0, 110, 35);
        label10.font = [UIFont boldSystemFontOfSize:15];
        label10.frame = CGRectMake(607, 230.0, 110, 35);
        
        scrollView.frame = CGRectMake(10, 270.0, 980.0, 230.0);
        scrollView.contentSize = CGSizeMake(778, 1500);
        cartTable.frame = CGRectMake(0, 0, 980.0,230.0);
        
        label6.font = [UIFont boldSystemFontOfSize:15];
        label6.frame = CGRectMake(10.0, 420.0, 150, 35.0);
        [label6 setBackgroundColor:[UIColor clearColor]];
        
        label7.font = [UIFont boldSystemFontOfSize:15];
        label7.frame = CGRectMake(10.0,465.0, 150, 35);
        [label7 setBackgroundColor:[UIColor clearColor]];
        
        totalQuantity.font = [UIFont boldSystemFontOfSize:15];
        totalQuantity.frame = CGRectMake(210.0, 420.0, 150, 35);
        [totalQuantity setBackgroundColor:[UIColor clearColor]];
        
        totalCost.font = [UIFont boldSystemFontOfSize:15];
        totalCost.frame = CGRectMake(210.0, 460.0, 150, 35);
        [totalCost setBackgroundColor:[UIColor clearColor]];
    }
    [createReceiptView addSubview:receiptRefNo];
    [createReceiptView addSubview:receiptRefNoValue];
    [createReceiptView addSubview:supplierID];
    [createReceiptView addSubview:supplierIDValue];
    [createReceiptView addSubview:supplierName];
    [createReceiptView addSubview:supplierNameValue];
    [createReceiptView addSubview:location];
    [createReceiptView addSubview:locationValue];
    [createReceiptView addSubview:deliveredBY];
    [createReceiptView addSubview:deliveredBYValue];
    [createReceiptView addSubview:inspectedBY];
    [createReceiptView addSubview:inspectedBYValue];
    [createReceiptView addSubview:date];
    [createReceiptView addSubview:dateValue];
    [createReceiptView addSubview:poRef];
    [createReceiptView addSubview:poRefValue];
    [createReceiptView addSubview:shipment];
    [createReceiptView addSubview:shipmentValue];
    [createReceiptView addSubview:order_sub_by];
    [createReceiptView addSubview:orderSubmittedByValue];
    [createReceiptView addSubview:shipping_terms];
    [createReceiptView addSubview:shippingTermsValue];
    [createReceiptView addSubview:order_app_by];
    [createReceiptView addSubview:orderAppBy];
    [createReceiptView addSubview:creditTerms];
    [createReceiptView addSubview:creditTermsValue];
    [createReceiptView addSubview:payTerms];
    [createReceiptView addSubview:payTermsValue];
    [createReceiptView addSubview:label2];
    [createReceiptView addSubview:label3];
    [createReceiptView addSubview:label4];
    [createReceiptView addSubview:label5];
    [createReceiptView addSubview:label8];
    [createReceiptView addSubview:label9];
    [createReceiptView addSubview:label10];
    [createReceiptView addSubview:label11];
    [createReceiptView addSubview:label12];
    [createReceiptView addSubview:label6];
    [createReceiptView addSubview:label7];
    [createReceiptView addSubview:totalQuantity];
    [createReceiptView addSubview:totalCost];
    [scrollView addSubview:cartTable];
    [createReceiptView addSubview:scrollView];
    [self.view addSubview:createReceiptView];
    
    
    
    //ProgressBar creation...
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    HUD.delegate = self;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
    HUD.mode = MBProgressHUDModeCustomView;
    // Show the HUD
    [HUD show:YES];
    [HUD setHidden:NO];
    
    WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
    WHPurchaseOrders_getPurchaseOrderDetails *aparams = [[WHPurchaseOrders_getPurchaseOrderDetails alloc] init];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"pO_Ref",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",wareHouzPurchaseOrderID],[RequestHeader getRequestHeader], nil];
    NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
    
    NSError * err_;
    NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
    NSString * normalStockString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
    //        aparams.userID = user_name;
    //        aparams.orderDateTime = dateString;
    //        aparams.deliveryDate = dueDate.text;
    //        aparams.deliveryTime = time.text;
    //        aparams.ordererEmail = email.text;
    //        aparams.ordererMobile = phNo.text;
    //        aparams.ordererAddress = address.text;
    //        aparams.orderTotalPrice = totAmountData.text;
    //        aparams.shipmentCharge = shipCharges.text;
    //        aparams.shipmentMode = shipoMode.text;
    //        aparams.paymentMode = paymentMode.text;
    //        aparams.orderItems = str;
    aparams.orderDetails = normalStockString;
    WHPurchaseOrdersSoapBindingResponse *response = [service getPurchaseOrderDetailsUsingParameters:(WHPurchaseOrders_getPurchaseOrderDetails *)aparams];
    
    NSArray *responseBodyParts =  response.bodyParts;
    
    for (id bodyPart in responseBodyParts) {
        if ([bodyPart isKindOfClass:[WHPurchaseOrders_getPurchaseOrderDetailsResponse class]]) {
            WHPurchaseOrders_getPurchaseOrderDetailsResponse *body = (WHPurchaseOrders_getPurchaseOrderDetailsResponse *)bodyPart;
            //printf("\nresponse=%s",body.return_);
            if (body.return_ == NULL) {
                
                [HUD setHidden:YES];
                //nextButton.backgroundColor = [UIColor lightGrayColor];
                //                firstButton.enabled = NO;
                //                lastButton.enabled = NO;
                //                nextButton.enabled = NO;
                //                recStart.text  = @"0";
                //                recEnd.text  = @"0";
                //                totalRec.text  = @"0";
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Ordered Items Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                
                [self getPreviousOrdersHandler:body.return_];
            }
            
        }
    }
}

-(void)popUpView {
    //Play Audio for button touch....
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
    [folderStructure addObject:@"Edit Order Details"];
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
        
        //        if (version >= 8.0) {
        //
        //            //         popOverViewController.preferredContentSize = CGSizeMake(100.0, 150.0);
        //            //         UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popOverViewController];
        //            //          [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        //            //         self.popOver = popover;
        //
        //            action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Home",@"New Billing",@"Return Item",@"Exchange Item",@"Logout",@"Cancel", nil];
        //            [action showFromBarButtonItem:sendButton animated:YES];
        //        }
        //        else {
        popOverViewController.contentSizeForViewInPopover = CGSizeMake(160.0, 150.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:popOverViewController];
        // popover.contentViewController.view.alpha = 0.0;
        [[[popover contentViewController]  view] setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        self.popOver = popover;
        //        }
    }
    
    
}

-(void) buttonClicked1:(UIButton*)sender
{
    [self.popOver dismissPopoverAnimated:YES];
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if (sender.tag == 0) {
        
        //        AudioServicesPlaySystemSound (soundFileObject);
        [self.popOver dismissPopoverAnimated:YES];
        OmniHomePage *home = [[[OmniHomePage alloc] init] autorelease];
        [self.navigationController pushViewController:home animated:YES];
    }
    else if (sender.tag == 1) {
        self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
        EditWareHousePurchaseOrder *po = [[EditWareHousePurchaseOrder alloc] initWithorderID:wareHouzPurchaseOrderID];
        [self.navigationController pushViewController:po animated:YES];
    }
    else{
        [self.popOver dismissPopoverAnimated:YES];
        AudioServicesPlaySystemSound (soundFileObject);
        OmniHomePage *omniRetailerViewController = [[OmniHomePage alloc] init];
        [omniRetailerViewController logOut];
    }
}



- (void) getPreviousOrdersHandler: (NSString *) value {
    
    //	// Handle errors
    //	if([value isKindOfClass:[NSError class]]) {
    //		//NSLog(@"%@", value);
    //		return;
    //	}
    //
    //	// Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		//NSLog(@"%@", value);
    //		return;
    //	}
    //
    
    [HUD setHidden:YES];
    
    // Do something with the NSString* result
    NSString* result = [value copy];
    
    NSError *e;
    
    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
    
    NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
    
    if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Order Details"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        json = [JSON1 objectForKey:@"whPurchaseOrder"];
        receiptRefNoValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"PO_Ref"]];
        supplierIDValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"supplier_Id"]];
        supplierNameValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"supplier_name"]];
        locationValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"supplier_contact_name"]];
        deliveredBYValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"delivery_due_date"]];
        inspectedBYValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipping_address_location"]];
        dateValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipping_address_city"]];
        poRefValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipping_address_street"]];
        shipmentValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipping_mode"]];
        orderSubmittedByValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"order_submitted_by"]];
        shippingTermsValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"shipping_terms"]];
        orderAppBy.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"order_approved_by"]];
        creditTermsValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"credit_terms"]];
        payTermsValue.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"payment_terms"]];
        totalQuantity.text = [NSString stringWithFormat:@"%@",@"2"];
        totalCost.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"total_po_value"]];
        
        NSArray *temp = [JSON1 objectForKey:@"itemDetails"];
        
        itemIdArray = [[NSMutableArray alloc] initWithArray:temp];
        
        [cartTable reloadData];
    }
    else{
        
        //        count2 = NO;
        //        changeNum--;
        
        //nextButton.backgroundColor = [UIColor lightGrayColor];
        nextButton.enabled =  NO;
        
        //previousButton.backgroundColor = [UIColor grayColor];
        previousButton.enabled =  YES;
        
        firstButton.enabled = YES;
        lastButton.enabled = NO;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed To Load Data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemIdArray count];
}


//heigth for tableviewcell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (tableView == cartTable) {
            return 66.0;
        }
        else {
            return 45.0;
        }
    }
    else {
        if (tableView == cartTable) {
            return 33.0;
        }
        
        else {
            return 28.0;
        }
    }
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorColor = [UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0];
    
    
    static NSString *hlCellID = @"hlCellID";
    
    UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
    static NSString *MyIdentifier = @"MyIdentifier";
    MyIdentifier = @"TableView";
    
    if (tableView == cartTable){
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        if ([hlcell.contentView subviews]){
            for (UIView *subview in [hlcell.contentView subviews]) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] autorelease];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        //
        
        NSDictionary *temp = [itemIdArray objectAtIndex:indexPath.row];
        
        UILabel *item_code = [[[UILabel alloc] init] autorelease];
        item_code.layer.borderWidth = 1.5;
        item_code.font = [UIFont systemFontOfSize:13.0];
        item_code.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_code.backgroundColor = [UIColor blackColor];
        item_code.textColor = [UIColor whiteColor];
        
        item_code.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"itemId"]];
        item_code.textAlignment=NSTextAlignmentCenter;
        item_code.adjustsFontSizeToFitWidth = YES;
        //name.adjustsFontSizeToFitWidth = YES;
        
        UILabel *item_description = [[[UILabel alloc] init] autorelease];
        item_description.layer.borderWidth = 1.5;
        item_description.font = [UIFont systemFontOfSize:13.0];
        item_description.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        item_description.backgroundColor = [UIColor blackColor];
        item_description.textColor = [UIColor whiteColor];
        
        item_description.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"itemDesc"]];
        item_description.textAlignment=NSTextAlignmentCenter;
        item_description.adjustsFontSizeToFitWidth = YES;
        
        UILabel *price = [[[UILabel alloc] init] autorelease];
        price.layer.borderWidth = 1.5;
        price.font = [UIFont systemFontOfSize:13.0];
        price.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        price.backgroundColor = [UIColor blackColor];
        price.text = [NSString stringWithFormat:@"%.2f",[[temp objectForKey:@"itemPrice"] floatValue]];
        price.textColor = [UIColor whiteColor];
        price.textAlignment=NSTextAlignmentCenter;
        //price.adjustsFontSizeToFitWidth = YES;
        
        
        UIButton *qtyButton = [[[UIButton alloc] init] autorelease];
        [qtyButton setTitle:[NSString stringWithFormat:@"%d",[[temp objectForKey:@"quantity"] integerValue]] forState:UIControlStateNormal];
        qtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        qtyButton.layer.borderWidth = 1.5;
        [qtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [qtyButton addTarget:self action:@selector(changeQuantity:) forControlEvents:UIControlEventTouchUpInside];
        qtyButton.layer.masksToBounds = YES;
        qtyButton.tag = indexPath.row;
        qtyButton.userInteractionEnabled = NO;
        
        
        UILabel *cost = [[[UILabel alloc] init] autorelease];
        cost.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        cost.layer.borderWidth = 1.5;
        cost.font = [UIFont systemFontOfSize:13.0];
        cost.backgroundColor = [UIColor blackColor];
        cost.text = [NSString stringWithFormat:@"%.02f", [[temp objectForKey:@"totalCost"] floatValue]];
        cost.textColor = [UIColor whiteColor];
        cost.textAlignment=NSTextAlignmentCenter;
        //cost.adjustsFontSizeToFitWidth = YES;
        
        UILabel *make = [[[UILabel alloc] init] autorelease];
        make.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        make.layer.borderWidth = 1.5;
        make.font = [UIFont systemFontOfSize:13.0];
        make.backgroundColor = [UIColor blackColor];
        make.text = [temp objectForKey:@"make"];
        make.textColor = [UIColor whiteColor];
        make.textAlignment=NSTextAlignmentCenter;
        //make.adjustsFontSizeToFitWidth = YES;
        
        UILabel *supplied = [[[UILabel alloc] init] autorelease];
        supplied.layer.borderWidth = 1.5;
        supplied.font = [UIFont systemFontOfSize:13.0];
        supplied.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        supplied.backgroundColor = [UIColor blackColor];
        supplied.textColor = [UIColor whiteColor];
        
        supplied.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"model"]];
        supplied.textAlignment=NSTextAlignmentCenter;
        //supplied.adjustsFontSizeToFitWidth = YES;
        
        UILabel *received = [[[UILabel alloc] init] autorelease];
        received.layer.borderWidth = 1.5;
        received.font = [UIFont systemFontOfSize:13.0];
        received.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        received.backgroundColor = [UIColor blackColor];
        received.textColor = [UIColor whiteColor];
        
        received.text = [NSString stringWithFormat:@"%@",[temp objectForKey:@"color"]];
        received.textAlignment=NSTextAlignmentCenter;
        //received.adjustsFontSizeToFitWidth = YES;
        
        UIButton *rejectQtyButton = [[[UIButton alloc] init] autorelease];
        [rejectQtyButton setTitle:[NSString stringWithFormat:@"%@",[temp objectForKey:@"size"]] forState:UIControlStateNormal];
        rejectQtyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        rejectQtyButton.layer.borderWidth = 1.5;
        [rejectQtyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rejectQtyButton addTarget:self action:@selector(changeRejectQuantity:) forControlEvents:UIControlEventTouchUpInside];
        rejectQtyButton.layer.masksToBounds = YES;
        rejectQtyButton.tag = indexPath.row;
        rejectQtyButton.userInteractionEnabled = NO;
        
        //        rejectedQty = [[[UITextField alloc] init] autorelease];
        //        rejectedQty.textAlignment = NSTextAlignmentCenter;
        //        rejectedQty.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
        //        rejectedQty.layer.borderWidth = 1.5;
        //        rejectedQty.font = [UIFont systemFontOfSize:13.0];
        //        rejectedQty.frame = CGRectMake(176, 0, 58, 34);
        //        rejectedQty.backgroundColor = [UIColor blackColor];
        //        rejectedQty.text = [temp objectAtIndex:5];
        //        rejectedQty.textColor = [UIColor whiteColor];
        //        [rejectedQty addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidBegin];
        //        rejectedQty.tag = indexPath.row;
        //        rejectedQty.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //        rejectedQty.adjustsFontSizeToFitWidth = YES;
        //        rejectedQty.delegate = self;
        //        [rejectedQty resignFirstResponder];
        
        
        [hlcell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            //skid.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
            item_code.font = [UIFont fontWithName:@"Helvetica" size:22];
            item_code.frame = CGRectMake(0, 0, 90, 56);
            item_description.font = [UIFont fontWithName:@"Helvetica" size:22];
            item_description.frame = CGRectMake(93, 0, 90, 56);
            price.font = [UIFont fontWithName:@"Helvetica" size:25];
            price.frame = CGRectMake(185, 0, 90, 56);
            qtyButton.frame = CGRectMake(278, 0, 90, 56);
            cost.font = [UIFont fontWithName:@"Helvetica" size:25];
            cost.frame = CGRectMake(371, 0, 110, 56);
            make.font = [UIFont fontWithName:@"Helvetica" size:25];
            make.frame = CGRectMake(484, 0, 110, 56);
            supplied.font = [UIFont fontWithName:@"Helvetica" size:25];
            supplied.frame = CGRectMake(597, 0, 110, 56);
            received.font = [UIFont fontWithName:@"Helvetica" size:25];
            received.frame = CGRectMake(710.0, 0, 110, 56);
            rejectQtyButton.frame = CGRectMake(823.0, 0, 110, 56);
            
        }
        else {
            
            item_code.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            item_code.frame = CGRectMake(0, 0, 90, 35);
            item_description.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            item_description.frame = CGRectMake(93, 0, 90, 35);
            price.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            price.frame = CGRectMake(185, 0, 90, 35);
            qtyButton.frame = CGRectMake(278, 0, 90, 35);
            cost.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            cost.frame = CGRectMake(371, 0, 110, 35);
            
            make.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            make.frame = CGRectMake(484, 0, 110, 35);
            supplied.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            supplied.frame = CGRectMake(597, 0, 110, 35);
            
            received.font = [UIFont fontWithName:@"ArialRoundedMT" size:13];
            received.frame = CGRectMake(710, 0, 110, 35);
            rejectQtyButton.frame = CGRectMake(823, 0, 110, 35);
            
        }
        
        //        if (flag == false) {
        //
        //            NSLog(@"%@",dealoroffersTxt);
        //            NSLog(@"%.2f",[dealoroffersTxt.text floatValue]);
        //
        //            if ([subtotalTxt.text length] > 0) {
        //
        //                subtotalTxt.text = [NSString stringWithFormat:@"%.02f", [subtotalTxt.text floatValue] + [total.text floatValue]];
        //                if ([cartItem count] == indexPath.row +1) {
        //                    subtotalTxt.text = [NSString stringWithFormat:@"%.02f",[subtotalTxt.text floatValue] - [dealoroffersTxt.text floatValue]];
        //                }
        //            }
        //            else {
        //
        //                subtotalTxt.text = [NSString stringWithFormat:@"%.02f", [subtotalTxt.text floatValue] + [total.text floatValue] - [giftVoucherTxt.text floatValue]];
        //                if ([cartItem count] == indexPath.row +1) {
        //                    subtotalTxt.text = [NSString stringWithFormat:@"%.02f",[subtotalTxt.text floatValue] - [dealoroffersTxt.text floatValue]];
        //                }
        //
        //            }
        //
        //            taxTxt.text = [NSString stringWithFormat:@"%.02f", ([subtotalTxt.text floatValue] / 100) * 0.0f];
        //
        //            totalTxt.text = [NSString stringWithFormat:@"%.02f", [subtotalTxt.text floatValue] + [taxTxt.text floatValue]];
        //        }
        //        else{
        //
        //            taxTxt.text = [NSString stringWithFormat:@"%.02f", ([subtotalTxt.text floatValue] / 100) * 0.0f];
        //
        //            totalTxt.text = [NSString stringWithFormat:@"%.02f", [subtotalTxt.text floatValue] + [taxTxt.text floatValue]];
        //
        //
        //            NSLog(@" %d",[cartItem count]);
        //            NSLog(@" %d",indexPath.row);
        //
        //            if([cartItem count]-1 == indexPath.row){
        //
        //                flag = false;
        //            }
        //        }
        
        
        
        [hlcell setBackgroundColor:[UIColor clearColor]];
        [hlcell.contentView addSubview:item_code];
        [hlcell.contentView addSubview:item_description];
        [hlcell.contentView addSubview:price];
        [hlcell.contentView addSubview:qtyButton];
        [hlcell.contentView addSubview:cost];
        [hlcell.contentView addSubview:make];
        [hlcell .contentView addSubview:supplied];
        [hlcell.contentView addSubview:received];
        [hlcell.contentView addSubview:rejectQtyButton];
        //
        
        
    }
    
    
    return hlcell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    // cell background color...
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
