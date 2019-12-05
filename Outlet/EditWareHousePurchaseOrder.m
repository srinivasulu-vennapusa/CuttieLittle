//
//  EditWareHousePurchaseOrder.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 4/17/15.
//
//

#import "EditWareHousePurchaseOrder.h"
#import "Global.h"
#import <QuartzCore/QuartzCore.h>
#import "PopOverViewController.h"
#import "OmniHomePage.h"
#import "WHPurchaseOrders.h"
#import "SkuServiceSvc.h"
#import "ViewWareHousePurchaseOrder.h"

@interface EditWareHousePurchaseOrder ()

@end

@implementation EditWareHousePurchaseOrder
@synthesize soundFileURLRef,soundFileObject,popOver;

NSString *wareEditPurchaseOrderID = @"";
BOOL wareNewItem___ = YES;

-(id) initWithorderID:(NSString *)orderID
{
    wareEditPurchaseOrderID = [orderID copy];
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
    titleLbl.text = @"Edit Purchase Order";
    titleLbl.textColor = [UIColor blackColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:25.0f];
    titleLbl.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:22.0];
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
    
    // MutabileArray's initialization....
    skuIdArray = [[NSMutableArray alloc] init];
    ItemArray = [[NSMutableArray alloc] init];
    ItemDiscArray = [[NSMutableArray alloc] init];
    priceArray = [[NSMutableArray alloc] init];
    QtyArray = [[NSMutableArray alloc] init];
    totalArray = [[NSMutableArray alloc] init];
    totalQtyArray = [[NSMutableArray alloc] init];
    
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
    
    receiptRefNoValue = [[[UITextField alloc] init] autorelease];
    receiptRefNoValue.layer.masksToBounds = YES;
    receiptRefNoValue.text = @"*******";
    [receiptRefNoValue setTextAlignment:NSTextAlignmentLeft];
    receiptRefNoValue.font = [UIFont boldSystemFontOfSize:14.0];
    receiptRefNoValue.borderStyle = UITextBorderStyleRoundedRect;
    receiptRefNoValue.textColor = [UIColor blackColor];
    receiptRefNoValue.backgroundColor = [UIColor whiteColor];
    receiptRefNoValue.userInteractionEnabled = NO;
    
    
    UILabel *supplierID = [[[UILabel alloc] init] autorelease];
    supplierID.text = @"Supplier ID :";
    supplierID.layer.masksToBounds = YES;
    supplierID.numberOfLines = 2;
    [supplierID setTextAlignment:NSTextAlignmentLeft];
    supplierID.font = [UIFont boldSystemFontOfSize:14.0];
    supplierID.textColor = [UIColor whiteColor];
    
    supplierIDValue = [[[UITextField alloc] init] autorelease];
    supplierIDValue.layer.masksToBounds = YES;
    supplierIDValue.text = @"*******";
    [supplierIDValue setTextAlignment:NSTextAlignmentLeft];
    supplierIDValue.font = [UIFont boldSystemFontOfSize:14.0];
    supplierIDValue.textColor = [UIColor whiteColor];
    supplierIDValue.borderStyle = UITextBorderStyleRoundedRect;
    supplierIDValue.textColor = [UIColor blackColor];
    supplierIDValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *supplierName = [[[UILabel alloc] init] autorelease];
    supplierName.text = @"Supplier Name :";
    supplierName.layer.masksToBounds = YES;
    supplierName.numberOfLines = 2;
    [supplierName setTextAlignment:NSTextAlignmentLeft];
    supplierName.font = [UIFont boldSystemFontOfSize:14.0];
    supplierName.textColor = [UIColor whiteColor];
    
    supplierNameValue = [[[UITextField alloc] init] autorelease];
    supplierNameValue.layer.masksToBounds = YES;
    supplierNameValue.text = @"**********";
    [supplierNameValue setTextAlignment:NSTextAlignmentLeft];
    supplierNameValue.font = [UIFont boldSystemFontOfSize:14.0];
    supplierNameValue.textColor = [UIColor whiteColor];
    supplierNameValue.borderStyle = UITextBorderStyleRoundedRect;
    supplierNameValue.textColor = [UIColor blackColor];
    supplierNameValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *location = [[[UILabel alloc] init] autorelease];
    location.text = @"Supplier Contact Name :";
    location.layer.masksToBounds = YES;
    location.numberOfLines = 2;
    [location setTextAlignment:NSTextAlignmentLeft];
    location.font = [UIFont boldSystemFontOfSize:14.0];
    location.textColor = [UIColor whiteColor];
    
    locationValue = [[[UITextField alloc] init] autorelease];
    locationValue.layer.masksToBounds = YES;
    locationValue.text = @"**********";
    [locationValue setTextAlignment:NSTextAlignmentLeft];
    locationValue.font = [UIFont boldSystemFontOfSize:14.0];
    locationValue.textColor = [UIColor whiteColor];
    locationValue.borderStyle = UITextBorderStyleRoundedRect;
    locationValue.textColor = [UIColor blackColor];
    locationValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *deliveredBY = [[[UILabel alloc] init] autorelease];
    deliveredBY.text = @"Delivery Date :";
    deliveredBY.layer.masksToBounds = YES;
    deliveredBY.numberOfLines = 2;
    [deliveredBY setTextAlignment:NSTextAlignmentLeft];
    deliveredBY.font = [UIFont boldSystemFontOfSize:14.0];
    deliveredBY.textColor = [UIColor whiteColor];
    
    deliveredBYValue = [[[UITextField alloc] init] autorelease];
    deliveredBYValue.layer.masksToBounds = YES;
    deliveredBYValue.text = @"**********";
    [deliveredBYValue setTextAlignment:NSTextAlignmentLeft];
    deliveredBYValue.font = [UIFont boldSystemFontOfSize:14.0];
    deliveredBYValue.textColor = [UIColor whiteColor];
    deliveredBYValue.borderStyle = UITextBorderStyleRoundedRect;
    deliveredBYValue.textColor = [UIColor blackColor];
    deliveredBYValue.backgroundColor = [UIColor whiteColor];
    
    dueDateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageDD = [UIImage imageNamed:@"combo.png"];
    [dueDateButton setBackgroundImage:buttonImageDD forState:UIControlStateNormal];
    [dueDateButton addTarget:self
                      action:@selector(dueDateButtonPressed:) forControlEvents:UIControlEventTouchDown];
    
    
    UILabel *inspectedBY = [[[UILabel alloc] init] autorelease];
    inspectedBY.text = @"Shipment Location :";
    inspectedBY.layer.masksToBounds = YES;
    inspectedBY.numberOfLines = 2;
    [inspectedBY setTextAlignment:NSTextAlignmentLeft];
    inspectedBY.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedBY.textColor = [UIColor whiteColor];
    
    inspectedBYValue = [[[UITextField alloc] init] autorelease];
    inspectedBYValue.layer.masksToBounds = YES;
    inspectedBYValue.text = @"*********";
    [inspectedBYValue setTextAlignment:NSTextAlignmentLeft];
    inspectedBYValue.font = [UIFont boldSystemFontOfSize:14.0];
    inspectedBYValue.textColor = [UIColor whiteColor];
    inspectedBYValue.borderStyle = UITextBorderStyleRoundedRect;
    inspectedBYValue.textColor = [UIColor blackColor];
    inspectedBYValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *date = [[[UILabel alloc] init] autorelease];
    date.text = @"Shipment City :";
    date.layer.masksToBounds = YES;
    date.numberOfLines = 2;
    [date setTextAlignment:NSTextAlignmentLeft];
    date.font = [UIFont boldSystemFontOfSize:14.0];
    date.textColor = [UIColor whiteColor];
    
    dateValue = [[[UITextField alloc] init] autorelease];
    dateValue.layer.masksToBounds = YES;
    dateValue.text = @"*********";
    [dateValue setTextAlignment:NSTextAlignmentLeft];
    dateValue.font = [UIFont boldSystemFontOfSize:14.0];
    dateValue.textColor = [UIColor whiteColor];
    dateValue.borderStyle = UITextBorderStyleRoundedRect;
    dateValue.textColor = [UIColor blackColor];
    dateValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *poRef = [[[UILabel alloc] init] autorelease];
    poRef.text = @"Shipment Street :";
    poRef.layer.masksToBounds = YES;
    poRef.numberOfLines = 2;
    [poRef setTextAlignment:NSTextAlignmentLeft];
    poRef.font = [UIFont boldSystemFontOfSize:14.0];
    poRef.textColor = [UIColor whiteColor];
    
    poRefValue = [[[UITextField alloc] init] autorelease];
    poRefValue.layer.masksToBounds = YES;
    poRefValue.text = @"**********";
    [poRefValue setTextAlignment:NSTextAlignmentLeft];
    poRefValue.font = [UIFont boldSystemFontOfSize:14.0];
    poRefValue.textColor = [UIColor whiteColor];
    poRefValue.borderStyle = UITextBorderStyleRoundedRect;
    poRefValue.textColor = [UIColor blackColor];
    poRefValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *shipment = [[[UILabel alloc] init] autorelease];
    shipment.text = @"Shipment Mode :";
    shipment.layer.masksToBounds = YES;
    shipment.numberOfLines = 2;
    [shipment setTextAlignment:NSTextAlignmentLeft];
    shipment.font = [UIFont boldSystemFontOfSize:14.0];
    shipment.textColor = [UIColor whiteColor];
    
    shipmentValue = [[[UITextField alloc] init] autorelease];
    shipmentValue.layer.masksToBounds = YES;
    shipmentValue.text = @"*********";
    [shipmentValue setTextAlignment:NSTextAlignmentLeft];
    shipmentValue.font = [UIFont boldSystemFontOfSize:14.0];
    shipmentValue.textColor = [UIColor whiteColor];
    shipmentValue.borderStyle = UITextBorderStyleRoundedRect;
    shipmentValue.textColor = [UIColor blackColor];
    shipmentValue.backgroundColor = [UIColor whiteColor];
    
    shipoModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageSM = [UIImage imageNamed:@"combo.png"];
    [shipoModeButton setBackgroundImage:buttonImageSM forState:UIControlStateNormal];
    [shipoModeButton addTarget:self action:@selector(shipoModeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *order_sub_by = [[[UILabel alloc] init] autorelease];
    order_sub_by.text = @"Order Submitted By :";
    order_sub_by.layer.masksToBounds = YES;
    order_sub_by.numberOfLines = 2;
    [order_sub_by setTextAlignment:NSTextAlignmentLeft];
    order_sub_by.font = [UIFont boldSystemFontOfSize:14.0];
    order_sub_by.textColor = [UIColor whiteColor];
    
    orderSubmittedByValue = [[[UITextField alloc] init] autorelease];
    orderSubmittedByValue.layer.masksToBounds = YES;
    orderSubmittedByValue.text = @"*********";
    [orderSubmittedByValue setTextAlignment:NSTextAlignmentLeft];
    orderSubmittedByValue.font = [UIFont boldSystemFontOfSize:14.0];
    orderSubmittedByValue.textColor = [UIColor whiteColor];
    orderSubmittedByValue.borderStyle = UITextBorderStyleRoundedRect;
    orderSubmittedByValue.textColor = [UIColor blackColor];
    orderSubmittedByValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *shipping_terms = [[[UILabel alloc] init] autorelease];
    shipping_terms.text = @"Shipping Terms :";
    shipping_terms.layer.masksToBounds = YES;
    shipping_terms.numberOfLines = 2;
    [shipping_terms setTextAlignment:NSTextAlignmentLeft];
    shipping_terms.font = [UIFont boldSystemFontOfSize:14.0];
    shipping_terms.textColor = [UIColor whiteColor];
    
    shippingTermsValue = [[[UITextField alloc] init] autorelease];
    shippingTermsValue.layer.masksToBounds = YES;
    shippingTermsValue.text = @"*********";
    [shippingTermsValue setTextAlignment:NSTextAlignmentLeft];
    shippingTermsValue.font = [UIFont boldSystemFontOfSize:14.0];
    shippingTermsValue.textColor = [UIColor whiteColor];
    shippingTermsValue.borderStyle = UITextBorderStyleRoundedRect;
    shippingTermsValue.textColor = [UIColor blackColor];
    shippingTermsValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *order_app_by = [[[UILabel alloc] init] autorelease];
    order_app_by.text = @"Order Approved By :";
    order_app_by.layer.masksToBounds = YES;
    order_app_by.numberOfLines = 2;
    [order_app_by setTextAlignment:NSTextAlignmentLeft];
    order_app_by.font = [UIFont boldSystemFontOfSize:14.0];
    order_app_by.textColor = [UIColor whiteColor];
    
    orderAppBy = [[[UITextField alloc] init] autorelease];
    orderAppBy.layer.masksToBounds = YES;
    orderAppBy.text = @"*********";
    [orderAppBy setTextAlignment:NSTextAlignmentLeft];
    orderAppBy.font = [UIFont boldSystemFontOfSize:14.0];
    orderAppBy.textColor = [UIColor whiteColor];
    orderAppBy.borderStyle = UITextBorderStyleRoundedRect;
    orderAppBy.textColor = [UIColor blackColor];
    orderAppBy.backgroundColor = [UIColor whiteColor];
    
    UILabel *creditTerms = [[[UILabel alloc] init] autorelease];
    creditTerms.text = @"Credit Terms :";
    creditTerms.layer.masksToBounds = YES;
    creditTerms.numberOfLines = 2;
    [creditTerms setTextAlignment:NSTextAlignmentLeft];
    creditTerms.font = [UIFont boldSystemFontOfSize:14.0];
    creditTerms.textColor = [UIColor whiteColor];
    
    creditTermsValue = [[[UITextField alloc] init] autorelease];
    creditTermsValue.layer.masksToBounds = YES;
    creditTermsValue.text = @"*********";
    [creditTermsValue setTextAlignment:NSTextAlignmentLeft];
    creditTermsValue.font = [UIFont boldSystemFontOfSize:14.0];
    creditTermsValue.textColor = [UIColor whiteColor];
    creditTermsValue.borderStyle = UITextBorderStyleRoundedRect;
    creditTermsValue.textColor = [UIColor blackColor];
    creditTermsValue.backgroundColor = [UIColor whiteColor];
    
    UILabel *payTerms = [[[UILabel alloc] init] autorelease];
    payTerms.text = @"Payment Terms :";
    payTerms.layer.masksToBounds = YES;
    payTerms.numberOfLines = 2;
    [payTerms setTextAlignment:NSTextAlignmentLeft];
    payTerms.font = [UIFont boldSystemFontOfSize:14.0];
    payTerms.textColor = [UIColor whiteColor];
    
    payTermsValue = [[[UITextField alloc] init] autorelease];
    payTermsValue.layer.masksToBounds = YES;
    payTermsValue.text = @"*********";
    [payTermsValue setTextAlignment:NSTextAlignmentLeft];
    payTermsValue.font = [UIFont boldSystemFontOfSize:14.0];
    payTermsValue.textColor = [UIColor whiteColor];
    
    payTermsValue.borderStyle = UITextBorderStyleRoundedRect;
    payTermsValue.textColor = [UIColor blackColor];
    payTermsValue.backgroundColor = [UIColor whiteColor];
    
    /** SearchBarItem*/
    searchItem = [[UITextField alloc] init];
    searchItem.borderStyle = UITextBorderStyleRoundedRect;
    searchItem.textColor = [UIColor blackColor];
    searchItem.placeholder = @"Enter Item";
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchItem.backgroundColor = [UIColor whiteColor];
    searchItem.autocorrectionType = UITextAutocorrectionTypeNo;
    searchItem.keyboardType = UIKeyboardTypeDefault;
    searchItem.returnKeyType = UIReturnKeyDone;
    [scrollView addSubview:searchItem];
    searchItem.delegate = self;
    
    
    /** Search Button*/
    searchBtton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchDown];
    [searchBtton setTitle:@"Search" forState:UIControlStateNormal];
    searchBtton.backgroundColor = [UIColor grayColor];
    
    
    /**table header labels */
    
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
    label2.text = @"Price";
    label2.layer.cornerRadius = 12;
    label2.layer.masksToBounds = YES;
    [label2 setTextAlignment:NSTextAlignmentCenter];
    label2.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label2.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label3 = [[[UILabel alloc] init] autorelease];
    label3.text = @"Qty";
    label3.layer.cornerRadius = 12;
    label3.layer.masksToBounds = YES;
    [label3 setTextAlignment:NSTextAlignmentCenter];
    label3.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label3.textColor = [UIColor whiteColor];
    //[self.view addSubview:scrollView];
    
    UILabel *label4 = [[[UILabel alloc] init] autorelease];
    label4.text = @"Total";
    label4.layer.cornerRadius = 12;
    label4.layer.masksToBounds = YES;
    [label4 setTextAlignment:NSTextAlignmentCenter];
    label4.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
    label4.textColor = [UIColor whiteColor];
    
    //serchOrderItemTable creation...
    serchOrderItemTable = [[UITableView alloc] init];
    serchOrderItemTable.layer.borderWidth = 1.0;
    serchOrderItemTable.layer.cornerRadius = 4.0;
    serchOrderItemTable.layer.borderColor = [UIColor blackColor].CGColor;
    serchOrderItemTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [serchOrderItemTable setDataSource:self];
    [serchOrderItemTable setDelegate:self];
    serchOrderItemTable.bounces = FALSE;
    
    
    
    
    //OrderItemTable creation...
    orderItemsTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 150)];
    ;
    orderItemsTable.backgroundColor  = [UIColor clearColor];
    //orderItemsTable.layer.borderColor = [UIColor grayColor].CGColor;
    //orderItemsTable.layer.borderWidth = 1.0;
    orderItemsTable.layer.cornerRadius = 4.0;
    orderItemsTable.bounces = TRUE;
    [orderItemsTable setDataSource:self];
    [orderItemsTable setDelegate:self];
    
    // ShipModeTableview cration....
    shipModeTable = [[UITableView alloc]init];
    shipModeTable.layer.borderWidth = 1.0;
    shipModeTable.layer.cornerRadius = 10.0;
    shipModeTable.bounces = FALSE;
    shipModeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    shipModeTable.layer.borderColor = [UIColor blackColor].CGColor;
    [shipModeTable setDataSource:self];
    [shipModeTable setDelegate:self];
    
    //Followings are SubTotal,Tax,TotalAmount labels creation...
    UILabel *subTotal = [[[UILabel alloc] init] autorelease];
    subTotal.text = @"Sub Total";
    subTotal.textColor = [UIColor whiteColor];
    subTotal.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    UILabel *tax = [[[UILabel alloc] init] autorelease];
    
    
    tax.text = @"Tax 8.25%";
    tax.textColor = [UIColor whiteColor];
    tax.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    UILabel *totAmount = [[[UILabel alloc] init] autorelease];
    totAmount.text = @"Total Bill";
    totAmount.textColor = [UIColor whiteColor];
    totAmount.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    // Disply ActualData of SubTotal,Tax,TotalAmount labels creation...
    subTotalData = [[[UILabel alloc] init] autorelease];
    subTotalData.text = @"0.00";
    subTotalData.textColor = [UIColor whiteColor];
    subTotalData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    taxData = [[[UILabel alloc] init] autorelease];
    taxData.text = @"0.00";
    taxData.textColor = [UIColor whiteColor];
    taxData.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:scrollView];
    
    
    totAmountData = [[[UILabel alloc] init] autorelease];
    totAmountData.text = @"0.00";
    totAmountData.textColor = [UIColor whiteColor];
    totAmountData.backgroundColor = [UIColor clearColor];
    
    /** Order Button */
    orderButton = [[UIButton alloc] init];
    [orderButton addTarget:self
                    action:@selector(orderButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [orderButton setTitle:@"Update" forState:UIControlStateNormal];
    orderButton.layer.cornerRadius = 3.0f;
    orderButton.backgroundColor = [UIColor grayColor];
    [orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //[self.view addSubview:orderButton];
    
    
    /** Create CancelButton */
    cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 3.0f;
    cancelButton.backgroundColor = [UIColor grayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    itemIdArray = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        createReceiptView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 900);
        
        receiptRefNo.font = [UIFont boldSystemFontOfSize:20];
        receiptRefNo.frame = CGRectMake(10, 0.0, 200.0, 55);
        receiptRefNoValue.font = [UIFont boldSystemFontOfSize:20];
        receiptRefNoValue.frame = CGRectMake(250.0, 0.0, 200.0, 40);
        supplierID.font = [UIFont boldSystemFontOfSize:20];
        supplierID.frame = CGRectMake(10, 60.0, 200.0, 55);
        supplierIDValue.font = [UIFont boldSystemFontOfSize:20];
        supplierIDValue.frame = CGRectMake(250.0, 60.0, 200.0, 40);
        supplierName.font = [UIFont boldSystemFontOfSize:20];
        supplierName.frame = CGRectMake(10, 120.0, 200.0, 55);
        supplierNameValue.font = [UIFont boldSystemFontOfSize:20];
        supplierNameValue.frame = CGRectMake(250.0, 120.0, 200.0, 40);
        location.font = [UIFont boldSystemFontOfSize:20];
        location.frame = CGRectMake(10, 180.0, 200, 55);
        locationValue.font = [UIFont boldSystemFontOfSize:20];
        locationValue.frame = CGRectMake(250.0, 180.0, 200, 40);
        deliveredBY.font = [UIFont boldSystemFontOfSize:20];
        deliveredBY.frame = CGRectMake(460.0, 0.0, 200, 55);
        deliveredBYValue.font = [UIFont boldSystemFontOfSize:20];
        deliveredBYValue.frame = CGRectMake(700.0, 0.0, 200, 40);
        dueDateButton.frame = CGRectMake(900, -5.0, 55, 55);
        inspectedBY.font = [UIFont boldSystemFontOfSize:20];
        inspectedBY.frame = CGRectMake(460.0, 60, 200, 55);
        inspectedBYValue.font = [UIFont boldSystemFontOfSize:20];
        inspectedBYValue.frame = CGRectMake(700.0, 60, 200.0, 40);
        date.font = [UIFont boldSystemFontOfSize:20];
        date.frame = CGRectMake(460.0, 120.0, 200.0, 55);
        dateValue.font = [UIFont boldSystemFontOfSize:20];
        dateValue.frame = CGRectMake(700.0, 120.0, 200.0, 40);
        poRef.font = [UIFont boldSystemFontOfSize:20];
        poRef.frame = CGRectMake(460.0, 180.0, 200.0, 55);
        poRefValue.font = [UIFont boldSystemFontOfSize:20];
        poRefValue.frame = CGRectMake(700.0, 180.0, 200.0, 40);
        shipment.font = [UIFont boldSystemFontOfSize:20];
        shipment.frame = CGRectMake(10, 240.0, 200.0, 55);
        shipmentValue.font = [UIFont boldSystemFontOfSize:20];
        shipmentValue.frame = CGRectMake(250.0, 240.0, 200.0, 40);
        shipoModeButton.frame = CGRectMake(410, 235, 50, 55);
        order_sub_by.font = [UIFont boldSystemFontOfSize:20];
        order_sub_by.frame = CGRectMake(460.0, 240.0, 200.0, 55.0);
        orderSubmittedByValue.font = [UIFont boldSystemFontOfSize:20];
        orderSubmittedByValue.frame = CGRectMake(700.0, 240.0, 200.0, 40);
        shipping_terms.font = [UIFont boldSystemFontOfSize:20];
        shipping_terms.frame = CGRectMake(10, 300.0, 200.0, 55.0);
        shippingTermsValue.font = [UIFont boldSystemFontOfSize:20];
        shippingTermsValue.frame = CGRectMake(250.0, 300.0, 200.0, 40);
        order_app_by.font = [UIFont boldSystemFontOfSize:20];
        order_app_by.frame = CGRectMake(460.0, 300.0, 200.0, 55.0);
        orderAppBy.font = [UIFont boldSystemFontOfSize:20];
        orderAppBy.frame = CGRectMake(700.0, 300.0, 200.0, 40);
        creditTerms.font = [UIFont boldSystemFontOfSize:20];
        creditTerms.frame = CGRectMake(10.0, 360.0, 200.0, 55.0);
        creditTermsValue.font = [UIFont boldSystemFontOfSize:20];
        creditTermsValue.frame = CGRectMake(250.0, 360.0, 200.0, 40);
        payTerms.font = [UIFont boldSystemFontOfSize:20];
        payTerms.frame = CGRectMake(460.0, 360.0, 200.0, 55.0);
        payTermsValue.font = [UIFont boldSystemFontOfSize:20];
        payTermsValue.frame = CGRectMake(700.0, 360.0, 200.0, 40);
        
        searchItem.frame = CGRectMake(10, 430, 400, 40);
        searchItem.font = [UIFont systemFontOfSize:20.0];
        [createReceiptView addSubview:searchItem];
        
        searchBtton.frame = CGRectMake(420, 430, 110, 40);
        searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        searchBtton.layer.cornerRadius = 22.0f;
        [createReceiptView addSubview:searchBtton];
        
        
        label1.frame = CGRectMake(10, 480.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label1];
        
        label5.frame = CGRectMake(161, 480.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label5];
        
        label2.frame = CGRectMake(312, 480.0, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label2];
        
        label3.frame = CGRectMake(463, 480.0, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label3];
        
        label4.frame = CGRectMake(614, 480.0, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label4];
        
        serchOrderItemTable.frame = CGRectMake(10, 470, 400, 300);
        serchOrderItemTable.hidden = YES;
        
        
        // orderTableScrollView.frame = CGRectMake(0, 262, 770, 380);
        // orderTableScrollView.contentSize = CGSizeMake(320,150);
        // [scrollView addSubview:orderTableScrollView];
        
        
        orderItemsTable.frame = CGRectMake(10, 525, 840, 200);
        orderItemsTable.hidden = YES;
        
        subTotal.frame = CGRectMake(10,730,300,40);
        subTotal.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:subTotal];
        
        tax.frame = CGRectMake(10,775,300,40);
        tax.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:tax];
        
        totAmount.frame = CGRectMake(10,820,300,40);
        totAmount.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:totAmount];
        
        shipModeTable.frame = CGRectMake(200, 260, 340, 270);
        shipModeTable.hidden = YES;
        
        subTotalData.frame = CGRectMake(500,730,200,40);
        subTotalData.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:subTotalData];
        
        taxData.frame = CGRectMake(500,775,300,40);
        taxData.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:taxData];
        
        totAmountData.frame = CGRectMake(500,820,300,40);
        totAmountData.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:totAmountData];
        
        orderButton.frame = CGRectMake(30, 870, 350, 50);
        orderButton.layer.cornerRadius = 22.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        cancelButton.frame = CGRectMake(390, 870, 350, 50);
        cancelButton.layer.cornerRadius = 22.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
    }
    else {
        createReceiptView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        createReceiptView.contentSize = CGSizeMake(self.view.frame.size.width + 500, 900);
        
        receiptRefNo.font = [UIFont boldSystemFontOfSize:15];
        receiptRefNo.frame = CGRectMake(10, 0.0, 200.0, 35);
        receiptRefNoValue.font = [UIFont boldSystemFontOfSize:15];
        receiptRefNoValue.frame = CGRectMake(250.0, 0.0, 200.0, 35);
        supplierID.font = [UIFont boldSystemFontOfSize:15];
        supplierID.frame = CGRectMake(10, 60.0, 200.0, 35);
        supplierIDValue.font = [UIFont boldSystemFontOfSize:15];
        supplierIDValue.frame = CGRectMake(250.0, 60.0, 200.0, 35);
        supplierName.font = [UIFont boldSystemFontOfSize:15];
        supplierName.frame = CGRectMake(10, 120.0, 200.0, 35);
        supplierNameValue.font = [UIFont boldSystemFontOfSize:15];
        supplierNameValue.frame = CGRectMake(250.0, 120.0, 200.0, 35);
        location.font = [UIFont boldSystemFontOfSize:15];
        location.frame = CGRectMake(10, 180.0, 200, 35);
        locationValue.font = [UIFont boldSystemFontOfSize:15];
        locationValue.frame = CGRectMake(250.0, 180.0, 200, 35);
        deliveredBY.font = [UIFont boldSystemFontOfSize:15];
        deliveredBY.frame = CGRectMake(460.0, 0.0, 200, 35);
        deliveredBYValue.font = [UIFont boldSystemFontOfSize:15];
        deliveredBYValue.frame = CGRectMake(700.0, 0.0, 200, 35);
        dueDateButton.frame = CGRectMake(900, -5.0, 55, 35);
        inspectedBY.font = [UIFont boldSystemFontOfSize:15];
        inspectedBY.frame = CGRectMake(460.0, 60, 200, 35);
        inspectedBYValue.font = [UIFont boldSystemFontOfSize:15];
        inspectedBYValue.frame = CGRectMake(700.0, 60, 200.0, 35);
        date.font = [UIFont boldSystemFontOfSize:15];
        date.frame = CGRectMake(460.0, 120.0, 200.0, 35);
        dateValue.font = [UIFont boldSystemFontOfSize:15];
        dateValue.frame = CGRectMake(700.0, 120.0, 200.0, 35);
        poRef.font = [UIFont boldSystemFontOfSize:15];
        poRef.frame = CGRectMake(460.0, 180.0, 200.0, 35);
        poRefValue.font = [UIFont boldSystemFontOfSize:15];
        poRefValue.frame = CGRectMake(700.0, 180.0, 200.0, 35);
        shipment.font = [UIFont boldSystemFontOfSize:15];
        shipment.frame = CGRectMake(10, 240.0, 200.0, 35);
        shipmentValue.font = [UIFont boldSystemFontOfSize:15];
        shipmentValue.frame = CGRectMake(250.0, 240.0, 200.0, 35);
        shipoModeButton.frame = CGRectMake(410, 235, 50, 35);
        order_sub_by.font = [UIFont boldSystemFontOfSize:15];
        order_sub_by.frame = CGRectMake(460.0, 240.0, 200.0, 35);
        orderSubmittedByValue.font = [UIFont boldSystemFontOfSize:15];
        orderSubmittedByValue.frame = CGRectMake(700.0, 240.0, 200.0, 35);
        shipping_terms.font = [UIFont boldSystemFontOfSize:15];
        shipping_terms.frame = CGRectMake(10, 300.0, 200.0, 35);
        shippingTermsValue.font = [UIFont boldSystemFontOfSize:15];
        shippingTermsValue.frame = CGRectMake(250.0, 300.0, 200.0, 35);
        order_app_by.font = [UIFont boldSystemFontOfSize:15];
        order_app_by.frame = CGRectMake(460.0, 300.0, 200.0, 35);
        orderAppBy.font = [UIFont boldSystemFontOfSize:15];
        orderAppBy.frame = CGRectMake(700.0, 300.0, 200.0, 35);
        creditTerms.font = [UIFont boldSystemFontOfSize:15];
        creditTerms.frame = CGRectMake(10.0, 360.0, 200.0, 35);
        creditTermsValue.font = [UIFont boldSystemFontOfSize:15];
        creditTermsValue.frame = CGRectMake(250.0, 360.0, 200.0, 35);
        payTerms.font = [UIFont boldSystemFontOfSize:15];
        payTerms.frame = CGRectMake(460.0, 360.0, 200.0, 35);
        payTermsValue.font = [UIFont boldSystemFontOfSize:15];
        payTermsValue.frame = CGRectMake(700.0, 360.0, 200.0, 40);
        
        searchItem.frame = CGRectMake(10, 430, 400, 40);
        searchItem.font = [UIFont systemFontOfSize:20.0];
        [createReceiptView addSubview:searchItem];
        
        searchBtton.frame = CGRectMake(420, 430, 110, 40);
        searchBtton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0f];
        searchBtton.layer.cornerRadius = 22.0f;
        [createReceiptView addSubview:searchBtton];
        
        
        label1.frame = CGRectMake(10, 480.0, 150, 40);
        label1.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label1];
        
        label5.frame = CGRectMake(161, 480.0, 150, 40);
        label5.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label5];
        
        label2.frame = CGRectMake(312, 480.0, 150, 40);
        label2.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label2];
        
        label3.frame = CGRectMake(463, 480.0, 150, 40);
        label3.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label3];
        
        label4.frame = CGRectMake(614, 480.0, 150, 40);
        label4.font = [UIFont boldSystemFontOfSize:20.0];
        [createReceiptView addSubview:label4];
        
        serchOrderItemTable.frame = CGRectMake(10, 470, 400, 300);
        serchOrderItemTable.hidden = YES;
        
        
        // orderTableScrollView.frame = CGRectMake(0, 262, 770, 380);
        // orderTableScrollView.contentSize = CGSizeMake(320,150);
        // [scrollView addSubview:orderTableScrollView];
        
        
        orderItemsTable.frame = CGRectMake(10, 525, 840, 200);
        orderItemsTable.hidden = YES;
        
        subTotal.frame = CGRectMake(10,730,300,40);
        subTotal.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:subTotal];
        
        tax.frame = CGRectMake(10,775,300,40);
        tax.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:tax];
        
        totAmount.frame = CGRectMake(10,820,300,40);
        totAmount.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:totAmount];
        
        shipModeTable.frame = CGRectMake(200, 260, 340, 270);
        shipModeTable.hidden = YES;
        
        subTotalData.frame = CGRectMake(500,730,200,40);
        subTotalData.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:subTotalData];
        
        taxData.frame = CGRectMake(500,775,300,40);
        taxData.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:taxData];
        
        totAmountData.frame = CGRectMake(500,820,300,40);
        totAmountData.font = [UIFont boldSystemFontOfSize:20];
        [createReceiptView addSubview:totAmountData];
        
        orderButton.frame = CGRectMake(30, 870, 350, 50);
        orderButton.layer.cornerRadius = 22.0f;
        orderButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        cancelButton.frame = CGRectMake(390, 870, 350, 50);
        cancelButton.layer.cornerRadius = 22.0f;
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        
        
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
    [createReceiptView addSubview:dueDateButton];
    [createReceiptView addSubview:inspectedBY];
    [createReceiptView addSubview:inspectedBYValue];
    [createReceiptView addSubview:date];
    [createReceiptView addSubview:dateValue];
    [createReceiptView addSubview:poRef];
    [createReceiptView addSubview:poRefValue];
    [createReceiptView addSubview:shipment];
    [createReceiptView addSubview:shipmentValue];
    [createReceiptView addSubview:shipoModeButton];
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
    [createReceiptView addSubview:serchOrderItemTable];
    [createReceiptView addSubview:orderItemsTable];
    [createReceiptView addSubview:subTotal];
    [createReceiptView addSubview:tax];
    [createReceiptView addSubview:totAmount];
    [createReceiptView addSubview:subTotalData];
    [createReceiptView addSubview:taxData];
    [createReceiptView addSubview:totAmountData];
    [createReceiptView addSubview:orderButton];
    [createReceiptView addSubview:cancelButton];
    [createReceiptView addSubview:shipModeTable];
    [self.view addSubview:createReceiptView];
    
    WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
    WHPurchaseOrders_getPurchaseOrderDetails *aparams = [[WHPurchaseOrders_getPurchaseOrderDetails alloc] init];
    NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    NSArray *str_ = [time_ componentsSeparatedByString:@" "];
    NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
    NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
    
    NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
    NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"pO_Ref",@"requestHeader", nil];
    
    NSArray *loyaltyObjects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",wareEditPurchaseOrderID],dictionary, nil];
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
        subTotalData.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"total_po_value"] floatValue]];
        taxData.text = [NSString stringWithFormat:@"%d",[[json objectForKey:@"total_tax"] integerValue]];
        totAmountData.text = [NSString stringWithFormat:@"%.02f",[[json objectForKey:@"total_po_value"] floatValue]];
        
        NSArray *temp = [JSON1 objectForKey:@"itemDetails"];
        for (int i = 0 ; i < [temp count]; i++) {
            NSDictionary*details =  [temp objectAtIndex:i];
            [ItemArray addObject:[NSString stringWithFormat:@"%@",[details objectForKey:@"itemDesc"]]];
            [priceArray addObject:[NSString stringWithFormat:@"%.02f",[[details objectForKey:@"itemPrice"] floatValue]]];
            [QtyArray addObject:[NSString stringWithFormat:@"%d",[[details objectForKey:@"quantity"] integerValue]]];
            [totalArray addObject:[NSString stringWithFormat:@"%.02f",[[details objectForKey:@"totalCost"] floatValue]]];
        }
        //itemIdArray = [[NSMutableArray alloc] initWithArray:temp];
        orderItemsTable.hidden = NO;
        [orderItemsTable reloadData];
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


//SearchItem TextFieldDidChange handler....
- (void)textFieldDidChange:(UITextField *)textField {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    NSString *value = [searchItem.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([value length] == 0){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Order Item" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        searchItem.text = nil;
        
    }
    else{
        
        seardhOrderItem = searchItem.text;
        // Create the service
        //        SDZSkuService* service = [SDZSkuService service];
        //        service.logging = YES;
        //
        //        // Returns NSString*.
        //        [service searchProduct:self action:@selector(searchProductHandler:) searchCriteria: seardhOrderItem];
        
        SkuServiceSoapBinding *service = [[SkuServiceSvc SkuServiceSoapBinding] retain];
        SkuServiceSvc_searchProduct *aparams = [[SkuServiceSvc_searchProduct alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time_ componentsSeparatedByString:@" "];
        NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        NSArray *keys = [NSArray arrayWithObjects:@"searchCriteria",@"requestHeader", nil];
        NSArray *objects = [NSArray arrayWithObjects:seardhOrderItem,dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        aparams.searchCriteria = salesReportJsonString;
        
        SkuServiceSoapBindingResponse *response = [service searchProductUsingParameters:(SkuServiceSvc_searchProduct *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_searchProductResponse class]]) {
                SkuServiceSvc_searchProductResponse *body = (SkuServiceSvc_searchProductResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                [self searchProductHandler:body.return_];
            }
        }
    }
}



// Handle the response from searchProduct.
- (void) searchProductHandler: (NSString *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		NSLog(@"%@", value);
    //		return;
    //	}
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    NSLog(@"%@",result);
    
    if ([result length] >= 1) {
        
        NSError *e;
        
        NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                              options: NSJSONReadingMutableContainers
                                                                error: &e];
        
        NSArray *tempItems = [JSON1 objectForKey:@"skuIds"];
        
        // serchOrderItemArray initialization...
        serchOrderItemArray = [[NSMutableArray alloc] init];
        
        for (int i=0; i<[tempItems count]; i++) {
            
            [serchOrderItemArray addObject:[tempItems objectAtIndex:i]];
        }
        
        scrollView.scrollEnabled = NO;
        orderButton.enabled = NO;
        cancelButton.enabled = NO;
        //timeButton.enabled = NO;
        searchItem.enabled = NO;
        searchBtton.enabled = NO;
        
        orderItemsTable.userInteractionEnabled = FALSE;
        
        serchOrderItemTable.hidden = NO;
        [self.view bringSubviewToFront:serchOrderItemTable];
        
        [serchOrderItemTable reloadData];
        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Order Items found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        searchItem.text = nil;
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
    [folderStructure addObject:@"Logout"];
    
    for (int i = 0; i < [folderStructure count]; i++) {
        UIButton *upload = [[UIButton alloc] init];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            categoriesView.frame = CGRectMake(0, 0, 230, 100.0);
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
    else{
        [self.popOver dismissPopoverAnimated:YES];
        AudioServicesPlaySystemSound (soundFileObject);
        OmniHomePage *omniRetailerViewController = [[OmniHomePage alloc] init];
        [omniRetailerViewController logOut];
    }
}


/** Table started.... */

#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == serchOrderItemTable){
        
        return [serchOrderItemArray count];
    }
    else if(tableView == orderItemsTable){
        
        return [ItemArray count];
    }
    else if (tableView == shipModeTable) {
        return [shipmodeList count];
    }
    else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == serchOrderItemTable) {
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(25, 3, 400, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:25.0];
            
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select OrderItem";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(350, 4, 30, 30);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        else{
            
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(25, 3, 150, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:17.0];
            
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select OrderItem";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(185, 4, 28, 28);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        
    }
    else if(tableView == shipModeTable){
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 255, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:22.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select The ShipMode";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(300, 4, 30, 30);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
        }
        else{
            
            UIView* headerView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 69.0)] autorelease];
            headerView.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0];
            
            UILabel *label1 = [[[UILabel alloc] initWithFrame:CGRectMake(8, 3, 175, 30)] autorelease];
            label1.font = [UIFont boldSystemFontOfSize:17.0];
            label1.backgroundColor = [UIColor clearColor];
            label1.text = @"Select The ShipMode";
            label1.textColor = [UIColor whiteColor];
            [headerView addSubview:label1];
            
            UIButton *closeBtn = [[[UIButton alloc] init] autorelease];
            [closeBtn addTarget:self action:@selector(serchOrderItemTableCancel:) forControlEvents:UIControlEventTouchUpInside];
            closeBtn.frame = CGRectMake(185, 4, 28, 28);
            UIImage *image = [UIImage imageNamed:@"go-back-icon.png"];
            [closeBtn setBackgroundImage:image	forState:UIControlStateNormal];
            [headerView addSubview:closeBtn];
            
            return headerView;
            
        }
        
    }
    
    else{
        return  NO;
    }
}

//Customize HeightForHeaderInSection ...
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == serchOrderItemTable) {
        return 35.0;
    }
    else if(tableView == shipModeTable){
        
        return 35.0;
    }
    else{
        return 0;
    }
}

//Customize eightForRowAtIndexPath ...
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == orderstockTable) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            return 140.0;
        }
        else {
            return 98.0;
        }
        
    }
    else{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            return 52;
        }
        else{
            
            return 33;
            
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.frame = CGRectZero;
    }
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    if(tableView == serchOrderItemTable){
        
        NSDictionary *json = [serchOrderItemArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[json objectForKey:@"skuId"]];
    }
    else if (tableView == shipModeTable){
        
        cell.textLabel.text = [shipmodeList objectAtIndex:indexPath.row];
    }
    else if(tableView == orderItemsTable){
        
        if ([ItemArray count] >= 1) {
            
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
                label1.text = [ItemArray objectAtIndex:(indexPath.row)];
                label1.textColor = [UIColor whiteColor];
                
                UILabel *label5 = [[[UILabel alloc] initWithFrame:CGRectMake(154, 0, 151, 50)] autorelease];
                label5.font = [UIFont systemFontOfSize:22.0];
                label5.layer.borderWidth = 1.5;
                label5.backgroundColor = [UIColor clearColor];
                label5.textAlignment = NSTextAlignmentCenter;
                label5.numberOfLines = 2;
                label5.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label5.lineBreakMode = NSLineBreakByWordWrapping;
                label5.text = [ItemArray objectAtIndex:(indexPath.row)];
                label5.textColor = [UIColor whiteColor];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(305, 0, 150, 50)] autorelease];
                label2.font = [UIFont systemFontOfSize:22.0];
                label2.backgroundColor =  [UIColor clearColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [priceArray objectAtIndex:(indexPath.row)];
                label2.textColor = [UIColor whiteColor];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor clearColor];
                qtyChange.frame = CGRectMake(456, 0, 151, 50);
                
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[QtyArray objectAtIndex:(indexPath.row)] forState:UIControlStateNormal];
                [qtyChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                qtyChange.titleLabel.font = [UIFont systemFontOfSize:22.0];
                CALayer * layer = [qtyChange layer];
                [layer setMasksToBounds:YES];
                [layer setCornerRadius:0.0];
                [layer setBorderWidth:1.5];
                [layer setBorderColor:[[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0] CGColor]];
                
                
                UILabel *label4 = [[[UILabel alloc] initWithFrame:CGRectMake(607, 0, 150, 50)] autorelease];
                label4.font = [UIFont systemFontOfSize:22.0];
                label4.layer.borderWidth = 1.5;
                label4.backgroundColor = [UIColor clearColor];
                label4.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label4.textAlignment = NSTextAlignmentCenter;
                label4.textColor = [UIColor whiteColor];
                NSString *str = [totalArray objectAtIndex:(indexPath.row)];
                label4.text = str;
                
                // close button to close the view ..
                delButton = [[[UIButton alloc] init] autorelease];
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = [indexPath row];
                delButton.frame = CGRectMake(767, 2, 45, 45);
                [delButton setBackgroundImage:image	forState:UIControlStateNormal];
                
                
                [cell.contentView addSubview:label1];
                [cell.contentView addSubview:label2];
                [cell.contentView addSubview:label5];
                [cell.contentView addSubview:qtyChange];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:delButton];
                
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
                label1.text = [ItemArray objectAtIndex:(indexPath.row)];
                
                UILabel *label2 = [[[UILabel alloc] initWithFrame:CGRectMake(66, 0, 68, 34)] autorelease];
                label2.font = [UIFont systemFontOfSize:13.0];
                label2.backgroundColor =  [UIColor whiteColor];
                label2.layer.borderWidth = 1.5;
                label2.textAlignment = NSTextAlignmentCenter;
                label2.numberOfLines = 2;
                label2.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1.0].CGColor;
                label2.text = [priceArray objectAtIndex:(indexPath.row)];
                
                
                qtyChange = [UIButton buttonWithType:UIButtonTypeCustom];
                [qtyChange addTarget:self action:@selector(qtyChangePressed:) forControlEvents:UIControlEventTouchDown];
                qtyChange.tag = indexPath.row;
                qtyChange.backgroundColor =  [UIColor whiteColor];
                qtyChange.frame = CGRectMake(132, 0, 72, 34);
                qtyChange.layer.cornerRadius = 0;
                [qtyChange setTitle:[QtyArray objectAtIndex:(indexPath.row)] forState:UIControlStateNormal];
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
                NSString *str = [totalArray objectAtIndex:(indexPath.row)];
                label4.text = [NSString stringWithFormat:@"%@%@",str,@".0"];
                
                // close button to close the view ..
                delButton = [[[UIButton alloc] init] autorelease];
                [delButton addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                UIImage *image = [UIImage imageNamed:@"delete.png"];
                delButton.tag = [indexPath row];
                delButton.frame = CGRectMake(274, 7, 22, 22);
                [delButton setBackgroundImage:image	forState:UIControlStateNormal];
                
                
                
                [cell.contentView addSubview:label1];
                [cell.contentView addSubview:label2];
                [cell.contentView addSubview:qtyChange];
                [cell.contentView addSubview:label4];
                [cell.contentView addSubview:delButton];
            }
            
        }
        cell.backgroundColor = [UIColor clearColor];
        
        [cell setTag:indexPath.row];
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    else{
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    // cell background color...
    UITableViewCell* theCell = [tableView cellForRowAtIndexPath:indexPath];
    theCell.contentView.backgroundColor=[UIColor colorWithRed:255.0/255.0 green:232.0/255.0 blue:124.0/255.0 alpha:1.0];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView == serchOrderItemTable){
        orderButton.enabled = YES;
        cancelButton.enabled = YES;
        searchItem.text = @"";
        serchOrderItemTable.hidden = YES;
        NSDictionary *json = [serchOrderItemArray objectAtIndex:indexPath.row];
        // Create the service
        //        SDZSkuService* service = [SDZSkuService service];
        //        service.logging = YES;
        //
        //        // Returns NSString*.
        //        [service getSkuIDForGivenProductName:self action:@selector(getSkuIDForGivenProductNameHandler:) productName: [serchOrderItemArray objectAtIndex:indexPath.row]];
        SkuServiceSoapBinding *service = [[SkuServiceSvc SkuServiceSoapBinding] retain];
        SkuServiceSvc_getSkuIDForGivenProductName *aparams = [[SkuServiceSvc_getSkuIDForGivenProductName alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str = [time_ componentsSeparatedByString:@" "];
        NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
        NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        
        NSArray *keys = [NSArray arrayWithObjects:@"product",@"requestHeader", nil];
        NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[json objectForKey:@"skuId"]],dictionary_, nil];
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        aparams.productName = salesReportJsonString;
        
        SkuServiceSoapBindingResponse *response = [service getSkuIDForGivenProductNameUsingParameters:(SkuServiceSvc_getSkuIDForGivenProductName *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuIDForGivenProductNameResponse class]]) {
                SkuServiceSvc_getSkuIDForGivenProductNameResponse *body = (SkuServiceSvc_getSkuIDForGivenProductNameResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                [self getSkuIDForGivenProductNameHandler:body.return_];
            }
        }
    }
    else if (tableView == shipModeTable) {
        shipmentValue.text = [shipmodeList objectAtIndex:indexPath.row];
        shipModeTable.hidden = YES;
        orderButton.enabled = YES;
        cancelButton.enabled = YES;
    }
}

- (void) getSkuIDForGivenProductNameHandler: (id) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //    if([value isKindOfClass:[SoapFault class]]) {
    //        NSLog(@"%@", value);
    //        return;
    //    }
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    NSLog(@" %@",result);
    
    if([result length] >= 1) {
        
        NSError *e;
        
        NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                              options: NSJSONReadingMutableContainers
                                                                error: &e];
        
        NSArray *temp = [JSON1 objectForKey:@"skuIds"];
        if ([temp count] > 0) {
            NSDictionary *json =  [temp objectAtIndex:0];
            result = [NSString stringWithFormat:@"%@",[json objectForKey:@"skuId"]];
            
            if ([skuIdArray count] == 0) {
                [skuIdArray addObject:result];
            }
            else{
                
                for (int i=0; i<=[skuIdArray count]-1; i++) {
                    NSString *str1  = [skuIdArray objectAtIndex:i];
                    if ([str1 isEqualToString:result]) {
                        wareNewItem___ = NO;
                    }
                }
                if (wareNewItem___ == YES) {
                    
                    [skuIdArray addObject:result];
                }
                else{
                    
                    wareNewItem___ = YES;
                }
            }
            
            // Create the service
            //            SDZSkuService* service = [SDZSkuService service];
            //            service.logging = YES;
            //
            //            // Returns NSString*.
            //            [service getSkuDetails:self action:@selector(getSkuDetailsHandler:) skuID: result];
            
            SkuServiceSoapBinding *service = [[SkuServiceSvc SkuServiceSoapBinding] retain];
            SkuServiceSvc_getSkuDetails *aparams = [[SkuServiceSvc_getSkuDetails alloc] init];
            NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
            NSArray *str = [time_ componentsSeparatedByString:@" "];
            NSString *date = [[[str objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
            NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
            
            NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date, nil];
            NSDictionary *dictionary_ = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
            
            NSArray *keys = [NSArray arrayWithObjects:@"skuId",@"requestHeader", nil];
            NSArray *objects = [NSArray arrayWithObjects:result,dictionary_, nil];
            
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            aparams.skuID = salesReportJsonString;
            
            SkuServiceSoapBindingResponse *response = [service getSkuDetailsUsingParameters:(SkuServiceSvc_getSkuDetails *)aparams];
            
            NSArray *responseBodyParts =  response.bodyParts;
            
            for (id bodyPart in responseBodyParts) {
                if ([bodyPart isKindOfClass:[SkuServiceSvc_getSkuDetailsResponse class]]) {
                    SkuServiceSvc_getSkuDetailsResponse *body = (SkuServiceSvc_getSkuDetailsResponse *)bodyPart;
                    //printf("\nresponse=%s",body.return_);
                    [self getSkuDetailsHandler:body.return_];
                }
            }
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to get Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Product Not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        searchItem.text = nil;
    }
}


// Handle the response from getSkuDetails.
- (void) getSkuDetailsHandler: (NSString *) value {
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        return;
    }
    
    // Handle faults
    //	if([value isKindOfClass:[SoapFault class]]) {
    //		NSLog(@"%@", value);
    //		return;
    //	}
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    NSError *e;
    
    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
    NSDictionary *JSON2 = [JSON1 objectForKey:@"responseHeader"];
    
    if ([[JSON2 objectForKey:@"responseMessage"] isEqualToString:@"SUCCESS"] && [[JSON2 objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        NSString *itemStr = [JSON1 objectForKey:@"productName"];
        //        NSArray *tempItems = [result componentsSeparatedByString:@"#"];
        
        if ([ItemArray count] == 0) {
            
            //            for (int i=0; i<[tempItems count]/4; i++) {
            
            [ItemArray addObject:[JSON1 objectForKey:@"productName"]];
            [ItemDiscArray addObject:[JSON1 objectForKey:@"description"]];
            [totalQtyArray addObject:[JSON1 objectForKey:@"quantity"]];
            [priceArray addObject:[JSON1 objectForKey:@"price"]];
            [QtyArray addObject:@"1"];
            [totalArray addObject:[NSString stringWithFormat:@"%.02f", [[JSON1 objectForKey:@"price"] floatValue]*[[QtyArray objectAtIndex:0] intValue]]];
            //            }
        }
        else
        {
            for (int i=0; i<=[ItemArray count]-1; i++) {
                
                //NSString *str1  = [tempItems objectAtIndex:0];
                NSString *str2  = [ItemArray objectAtIndex:i];
                
                if ([str2 isEqualToString:itemStr]) {
                    wareNewItem___ = NO;
                    
                }
            }
            
            if (wareNewItem___ == YES) {
                
                //                for (int i=0; i<[tempItems count]/4; i++) {
                
                [ItemArray addObject:[JSON1 objectForKey:@"productName"]];
                [ItemDiscArray addObject:[JSON1 objectForKey:@"description"]];
                [totalQtyArray addObject:[JSON1 objectForKey:@"quantity"]];
                [priceArray addObject:[JSON1 objectForKey:@"price"]];
                [QtyArray addObject:@"1"];
                [totalArray addObject:[NSString stringWithFormat:@"%.02f", [[JSON1 objectForKey:@"price"] floatValue]*[[QtyArray objectAtIndex:0] intValue]]];
                //                }
            }
            else{
                
                for (int i=0; i<=[ItemArray count]-1; i++) {
                    
                    //                       NSString *str1  = [tempItems objectAtIndex:0];
                    NSString *str2  = [ItemArray objectAtIndex:i];
                    
                    if ([str2 isEqualToString:itemStr]) {
                        
                        NSLog(@"%@",[QtyArray objectAtIndex:i]);
                        
                        NSLog(@" %d",[[QtyArray objectAtIndex:i] intValue] + 1);
                        
                        if ([[QtyArray objectAtIndex:i] intValue] + 1 > [[totalQtyArray objectAtIndex:i] intValue]) {
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                            [alert show];
                            [alert release];
                            
                            qtyFeild.text = nil;
                        }
                        else{
                            
                            [QtyArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",[[QtyArray objectAtIndex:i] intValue] + 1]];
                            
                            wareNewItem___ = YES;
                            [self displayOrdersData];
                        }
                    }
                }
            }
        }
        
        
        
        totalAmount = 0.0;
        
        for (int i=0; i<[totalArray count]; i++) {
            totalAmount = totalAmount + [[totalArray objectAtIndex:i] intValue];
        }
        
        subTotalData.text = [NSString stringWithFormat:@"%d%@", totalAmount,@".0"];
        taxData.text = [NSString stringWithFormat:@"%.2lf", totalAmount/8.25f];
        totAmountData.text = [NSString stringWithFormat:@"%.2lf", totalAmount+(totalAmount/8.25f)];
        
        orderItemsTable.hidden = NO;
        //[self.view bringSubviewToFront:orderItemsTable];
        [orderItemsTable reloadData];
        
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Failed to get Details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

//DisplayOrdersData handler
-(void)displayOrdersData{
    
    totalAmount = 0.0;
    
    for (int i=0; i<[ItemArray count]; i++) {
        
        [totalArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d", [[priceArray objectAtIndex:i] intValue]*[[QtyArray objectAtIndex:i] intValue]]];
        // qtyChangeDisplyView.hidden = YES;
        
        totalAmount = totalAmount + [[totalArray objectAtIndex:i] intValue];
        [orderItemsTable reloadData];
    }
    
    subTotalData.text = [NSString stringWithFormat:@"%d%@", totalAmount,@".0"];
    taxData.text = [NSString stringWithFormat:@"%.2lf", totalAmount/8.25f];
    totAmountData.text = [NSString stringWithFormat:@"%.2lf", totalAmount+(totalAmount/8.25f)];
}

// qtyChangeClick handler...
- (IBAction)qtyChangePressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    scrollView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    //timeButton.enabled = NO;
    searchItem.enabled = NO;
    searchBtton.enabled = NO;
    orderItemsTable.userInteractionEnabled = FALSE;
    
    qtyOrderPosition = [sender tag];
    
    qtyChangeDisplyView = [[[UIView alloc]init] autorelease];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        qtyChangeDisplyView.frame = CGRectMake(200, 300, 375, 300);
    }
    else{
        qtyChangeDisplyView.frame = CGRectMake(75, 68, 175, 200);
    }
    qtyChangeDisplyView.layer.borderWidth = 2.0;
    qtyChangeDisplyView.layer.cornerRadius = 10.0;
    qtyChangeDisplyView.layer.masksToBounds = YES;
    qtyChangeDisplyView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index29" ofType:@"jpg"];
    //    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:filePath]];
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //
    //        img.frame = CGRectMake(0, 0, 375, 300);
    //    }
    //    else{
    //        img.frame = CGRectMake(0, 0, 175, 200);
    //    }
    //    [qtyChangeDisplyView addSubview:img];
    qtyChangeDisplyView.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    [self.view addSubview:qtyChangeDisplyView];
    
    
    // a label on top of the view ..
    UILabel *topbar = [[[UILabel alloc] init] autorelease];
    topbar.backgroundColor = [UIColor grayColor];
    topbar.text = @"    Enter Quantity";
    topbar.backgroundColor = [UIColor blackColor];
    [topbar setTextAlignment:NSTextAlignmentCenter];
    topbar.textColor = [UIColor whiteColor];
    topbar.textAlignment = NSTextAlignmentLeft;
    
    
    
    UILabel *availQty = [[[UILabel alloc] init] autorelease];
    availQty.text = @"Available Qty :";
    availQty.backgroundColor = [UIColor clearColor];
    availQty.textColor = [UIColor blackColor];
    
    
    UILabel *unitPrice = [[[UILabel alloc] init] autorelease];
    unitPrice.text = @"Unit Price       :";
    unitPrice.backgroundColor = [UIColor clearColor];
    unitPrice.textColor = [UIColor blackColor];
    
    
    
    UILabel *availQtyData = [[[UILabel alloc] init] autorelease];
    availQtyData.text = [QtyArray objectAtIndex:[sender tag]];
    availQtyData.backgroundColor = [UIColor clearColor];
    availQtyData.textColor = [UIColor blackColor];
    
    
    UILabel *unitPriceData = [[[UILabel alloc] init] autorelease];
    unitPriceData.text = [priceArray objectAtIndex:[sender tag]];
    unitPriceData.backgroundColor = [UIColor clearColor];
    unitPriceData.textColor = [UIColor blackColor];
    
    
    
    qtyFeild = [[UITextField alloc] init];
    qtyFeild.borderStyle = UITextBorderStyleRoundedRect;
    qtyFeild.textColor = [UIColor blackColor];
    qtyFeild.placeholder = @"Enter Qty";
    qtyFeild.backgroundColor = [UIColor whiteColor];
    qtyFeild.autocorrectionType = UITextAutocorrectionTypeNo;
    qtyFeild.keyboardType = UIKeyboardTypeDefault;
    qtyFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    qtyFeild.returnKeyType = UIReturnKeyDone;
    qtyFeild.delegate = self;
    [qtyFeild becomeFirstResponder];
    
    /** ok Button for qtyChangeDisplyView....*/
    okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[okButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    [okButton addTarget:self
                 action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    okButton.backgroundColor = [UIColor grayColor];
    
    
    /** CancelButton for qtyChangeDisplyView....*/
    qtyCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[qtyCancelButton setImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [qtyCancelButton addTarget:self
                        action:@selector(QtyCancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
    [qtyCancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    qtyCancelButton.backgroundColor = [UIColor grayColor];
    
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        topbar.frame = CGRectMake(0, 0, 375, 40);
        topbar.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQty.frame = CGRectMake(10,50,200,40);
        availQty.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPrice.frame = CGRectMake(10,100,200,40);
        unitPrice.font = [UIFont boldSystemFontOfSize:25];
        
        
        availQtyData.frame = CGRectMake(200,50,250,40);
        availQtyData.font = [UIFont boldSystemFontOfSize:25];
        
        
        unitPriceData.frame = CGRectMake(200,100,2500,40);
        unitPriceData.font = [UIFont boldSystemFontOfSize:25];
        
        
        qtyFeild.frame = CGRectMake(110, 160, 150, 40);
        qtyFeild.font = [UIFont systemFontOfSize:25.0];
        
        
        okButton.frame = CGRectMake(20, 230, 165, 45);
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        okButton.layer.cornerRadius = 20.0f;
        
        qtyCancelButton.frame = CGRectMake(190, 230, 165, 45);
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        qtyCancelButton.layer.cornerRadius = 20.0f;
        
    }
    else{
        topbar.frame = CGRectMake(0, 0, 175, 30);
        topbar.font = [UIFont boldSystemFontOfSize:17];
        
        availQty.frame = CGRectMake(10,40,100,30);
        availQty.font = [UIFont boldSystemFontOfSize:14];
        
        unitPrice.frame = CGRectMake(10,70,100,30);
        unitPrice.font = [UIFont boldSystemFontOfSize:14];
        
        availQtyData.frame = CGRectMake(115,40,60,30);
        availQtyData.font = [UIFont boldSystemFontOfSize:14];
        
        unitPriceData.frame = CGRectMake(115,70,60,30);
        unitPriceData.font = [UIFont boldSystemFontOfSize:14];
        
        qtyFeild.frame = CGRectMake(36, 107, 100, 30);
        qtyFeild.font = [UIFont systemFontOfSize:17.0];
        
        okButton.frame = CGRectMake(10, 150, 75, 30);
        okButton.layer.cornerRadius = 14.0f;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        qtyCancelButton.frame = CGRectMake(90, 150, 75, 30);
        qtyCancelButton.layer.cornerRadius = 14.0f;
        qtyCancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
    }
    
    
    [qtyChangeDisplyView addSubview:topbar];
    [qtyChangeDisplyView addSubview:availQty];
    [qtyChangeDisplyView addSubview:unitPrice];
    [qtyChangeDisplyView addSubview:availQtyData];
    [qtyChangeDisplyView addSubview:unitPriceData];
    [qtyChangeDisplyView addSubview:qtyFeild];
    [qtyChangeDisplyView addSubview:okButton];
    [qtyChangeDisplyView addSubview:qtyCancelButton];
}



// okButtonPressed handler for quantity changed..
- (IBAction)okButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    NSString *str = qtyFeild.text;
    //NSString *candidate = qtyFeild.text;
    NSString *value = [qtyFeild.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    // PhoNumber validation...
    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    //BOOL isNumber = [decimalTest evaluateWithObject:[qtyFeild text]];
    BOOL isNumber = [decimalTest evaluateWithObject:qtyFeild.text];
    
    int qty = [str intValue];
    
//    if (qty >= [[totalQtyArray objectAtIndex:qtyOrderPosition] intValue]+1 ){
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Quantity Should be Less than or Equal to  Availble Quantity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        
//        qtyFeild.text = nil;
//        qtyChangeDisplyView.hidden = NO;
//        
//    }
    if([value isEqualToString:@"0"] || !isNumber){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        qtyFeild.text = NO;
    }
    //    else if(!isNumber){
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Quantity." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        [QtyArray replaceObjectAtIndex:qtyOrderPosition withObject:qtyFeild.text];
        //[qtyChangeDisplyView removeFromSuperview];
        qtyChangeDisplyView.hidden = YES;
        
        
        
        [self displayOrdersData];
    }
    
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    //timeButton.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}





// cancelButtonPressed handler quantity changed view cancel..
- (IBAction)QtyCancelButtonPressed:(id)sender {
    
    AudioServicesPlaySystemSound (soundFileObject);
    qtyChangeDisplyView.hidden = YES;
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    // timeButton.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    // timeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
}

-(IBAction) dueDateButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    scrollView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    
    //pickerview creation....
    
    pickView = [[UIView alloc] init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        pickView.frame = CGRectMake(220, 200, 320, 400);
    }
    else{
        pickView.frame = CGRectMake(0, 0, 320, 460);
    }
    
    pickView.backgroundColor = [UIColor blackColor];
    pickView.layer.cornerRadius = 5.0f;
    
    //pickerframe creation...
    CGRect pickerFrame = CGRectMake(0,50,0,0);
    myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    myPicker.backgroundColor = [UIColor whiteColor];
    //Current Date...
    NSDate *now = [NSDate date];
    [myPicker setDate:now animated:YES];
    
    UIButton  *pickButton = [[UIButton alloc] init];
    [pickButton setImage:[UIImage imageNamed:@"OK.png"] forState:UIControlStateNormal];
    pickButton.frame = CGRectMake(105, 327, 120, 35);
    pickButton.backgroundColor = [UIColor clearColor];
    pickButton.layer.masksToBounds = YES;
    [pickButton addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    //[pickButton setTitle:@"OK" forState:UIControlStateNormal];
    pickButton.layer.borderColor = [UIColor blackColor].CGColor;
    pickButton.layer.borderWidth = 0.5f;
    pickButton.layer.cornerRadius = 12;
    //pickButton.layer.masksToBounds = YES;
    [pickView addSubview:myPicker];
    [pickView addSubview:pickButton];
    [self.view addSubview:pickView];
    
    [pickView release];
    
}

-(IBAction)getDate:(id)sender
{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    //Date Formate Setting...
    NSDateFormatter *sdayFormat = [[NSDateFormatter alloc] init];
    [sdayFormat setDateFormat:@"yyyy/MM/dd hh:mmaa"];
    NSString *dateString = [sdayFormat stringFromDate:myPicker.date];
    
    NSComparisonResult result = [myPicker.date compare:[NSDate date]];
    
    if(result==NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Invalid Date Selectione" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else {
        
        NSArray *temp =[dateString componentsSeparatedByString:@" "];
        NSLog(@" %@",temp);
        
        [deliveredBYValue setText:[temp objectAtIndex:0]];
        [pickView removeFromSuperview];
        
        scrollView.scrollEnabled = YES;
        orderButton.enabled = YES;
        cancelButton.enabled = YES;
    }
}

-(IBAction) shipoModeButtonPressed:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    scrollView.scrollEnabled = NO;
    orderButton.enabled = NO;
    cancelButton.enabled = NO;
    //timeButton.enabled = NO;
    
    shipmodeList = [[NSMutableArray alloc] init];
    [shipmodeList addObject:@"Rail"];
    [shipmodeList addObject:@"Flight"];
    [shipmodeList addObject:@"Express"];
    [shipmodeList addObject:@"Ordinary"];
    
    shipModeTable.hidden = NO;
    [self.view bringSubviewToFront:shipModeTable];
    [shipModeTable reloadData];
    
}

// Handle serchOrderItemTableCancel Pressed....
-(IBAction) serchOrderItemTableCancel:(id) sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    searchItem.text = nil;
    serchOrderItemTable.hidden = YES;
    shipModeTable.hidden = YES;
    
    scrollView.scrollEnabled = YES;
    orderButton.enabled = YES;
    cancelButton.enabled = YES;
    //timeButton.enabled = YES;
    searchItem.enabled = YES;
//    searchBtton.enabled = YES;
    dueDateButton.enabled = YES;
    // timeButton.enabled = YES;
    shipoModeButton.enabled = YES;
    orderItemsTable.userInteractionEnabled = TRUE;
    
}

- (void) orderButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    // PhoNumber validation...
    //    NSString *decimalRegex = @"[0-9]+([.]([0-9]+)?)?"; // @"[0-9]+[.][0-9]+";
    //    NSPredicate *decimalTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", decimalRegex];
    //    BOOL isNumber = [decimalTest evaluateWithObject:[phNo text]];
    //
    //
    //    // email validation...
    //    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //    BOOL isMail = [emailTest evaluateWithObject:[email text]];
    
    NSString *locationValue_ = [receiptRefNoValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *customerNameValue = [supplierIDValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *executiveNameValue = [supplierNameValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *dueDateValue = [locationValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipment_locationValue = [deliveredBYValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipment_cityValue = [inspectedBYValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipment_streetValue = [dateValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipoModeValue = [poRefValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipmentIDValue = [shipmentValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *shipChargesValue = [orderSubmittedByValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *saleLocationValue = [shippingTermsValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *paymentModeValue = [orderAppBy.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *paymentTypeValue = [creditTermsValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *paymentTermsValue = [payTermsValue.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    shipment_locationValue = [shipment_locationValue stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    if ([ItemArray count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Add Items to Cart" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if([locationValue_ length] == 0 || [customerNameValue length] == 0 || [executiveNameValue length] == 0 || [dueDateValue length] == 0 ||     [shipment_locationValue length] == 0 || [shipment_cityValue length] == 0 || [shipment_streetValue length] == 0  || [shipoModeValue length] == 0 ||            [shipmentIDValue length] == 0 || [shipChargesValue length] == 0 || [saleLocationValue length] == 0 ||            [paymentModeValue length] == 0 || [paymentTypeValue length] == 0 || [paymentTermsValue length] == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Fields couldn't be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    //    else if (!isNumber){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter Valid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    //    else if (!isMail){
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Enter valid mail ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //    }
    else{
        HUD.labelText = @" Placing the order..";
        [HUD setHidden:NO];
        
        
        //        SDZOrderService* service = [SDZOrderService service];
        //        service.logging = YES;
        //
        //        // Returns BOOL.
        //         [service createOrder:self action:@selector(createOrderHandler:) userID:user_name orderDateTime: dateString deliveryDate: dueDate.text deliveryTime: time.text ordererEmail: email.text ordererMobile:phNo.text ordererAddress: address.text orderTotalPrice: totAmountData.text shipmentCharge: shipCharges.text shipmentMode:shipoMode.text paymentMode: paymentMode.text orderItems: str];
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (int i = 0; i < [ItemArray count]; i++) {
            NSArray *keys = [NSArray arrayWithObjects:@"itemId", @"itemPrice",@"quantity",@"item_name",@"size",@"color",@"model",@"make",@"totalCost",@"itemDesc",@"poRef",@"poItemId", nil];
            NSArray *objects = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[QtyArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],@"35",@"blue",@"NA",@"NA",[NSString stringWithFormat:@"%@",[totalArray objectAtIndex:i]],[NSString stringWithFormat:@"%@",[ItemArray objectAtIndex:i]],@"1000 ",@"1234", nil];
            NSDictionary *itemsDic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            
            [items addObject:itemsDic];
        }
        
        WHPurchaseOrdersSoapBinding *service = [[WHPurchaseOrders WHPurchaseOrdersSoapBinding] retain];
        WHPurchaseOrders_updatePurchaseOrder *aparams = [[WHPurchaseOrders_updatePurchaseOrder alloc] init];
        NSString *time_ = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
        NSArray *str_ = [time_ componentsSeparatedByString:@" "];
        NSString *date_ = [[[str_ objectAtIndex:0] componentsSeparatedByString:@","] objectAtIndex:0];
        NSArray *headerKeys = [NSArray arrayWithObjects:@"accessKey", @"customerId",@"applicationName",@"userName",@"correlationId",@"dateTime", nil];
        
        NSArray *headerObjects = [NSArray arrayWithObjects:custID,custID,@"omniRetailer",mail_,@"-",date_, nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:headerObjects forKeys:headerKeys];
        //        {"pO_Ref":"POID10004","po_Ref":"123456","supplier_Id":"sanju","supplier_name":"sanju","supplier_contact_name":"sanjana","Order_submitted_by":"sanju","Order_approved_by":"king","shipping_address":"hyd","shipping_mode":"flight","shipping_cost":100,"shipping_terms":"lklkasjdflkjas;dlkfj","delivery_due_date":"2015/04/01","credit_terms":"kjsafjasdhf","payment_terms":"payment terms","products_cost":1000,"total_tax":10000,"total_po_value":65545,"remarks":"good or bad","shipping_address_street":"hyd","shipping_address_location":"hyd","shipping_address_city":"hyd","purchaseItems":[{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"},{"itemId":"5445","itemPrice":"45454","quantity":"5","item_name":"jsdkljas","size":"35","color":"jkf","model":"iasdf","make":"kjdshkjsdf","totalCost":"6544","itemDesc":"ksdfsakjdfh","poRef":"1000","poItemId":"13213"}],"requestHeader":{"correlationId":"-","dateTime":"3/30/15","accessKey":"CID8995420","customerId":"CID8995420","applicationName":"omniRetailer","userName":"chandrasekhar.reddy@technolabssoftware.com"}}
        NSArray *loyaltyKeys = [NSArray arrayWithObjects:@"pO_Ref",@"supplier_Id", @"supplier_name",@"supplier_contact_name",@"Order_submitted_by",@"Order_approved_by",@"shipping_address",@"shipping_address_street",@"shipping_address_location",@"shipping_address_city",@"shipping_mode",@"shipping_cost",@"shipping_terms",@"delivery_due_date",@"credit_terms",@"payment_terms",@"products_cost",@"total_tax",@"total_po_value",@"remarks",@"whPurchaseItems",@"requestHeader", nil];
        
        NSArray *loyaltyObjects = [NSArray arrayWithObjects:wareEditPurchaseOrderID,customerNameValue,executiveNameValue,dueDateValue,shipChargesValue,paymentModeValue,shipment_cityValue,shipment_streetValue,shipoModeValue,shipmentIDValue,saleLocationValue,@"200.0",saleLocationValue,shipment_locationValue,paymentTermsValue,totAmountData.text,subTotalData.text,taxData.text,totAmountData.text,@"good",items,dictionary, nil];
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
        WHPurchaseOrdersSoapBindingResponse *response = [service updatePurchaseOrderUsingParameters:(WHPurchaseOrders_updatePurchaseOrder *)aparams];
        
        NSArray *responseBodyParts =  response.bodyParts;
        
        for (id bodyPart in responseBodyParts) {
            if ([bodyPart isKindOfClass:[WHPurchaseOrders_updatePurchaseOrderResponse class]]) {
                WHPurchaseOrders_updatePurchaseOrderResponse *body = (WHPurchaseOrders_updatePurchaseOrderResponse *)bodyPart;
                //printf("\nresponse=%s",body.return_);
                [self createOrderHandler:body.return_];
            }
        }
        
    }
    // Show the HUD
    
    //    }
}

// Handle the response from createOrder.
- (void) createOrderHandler: (NSString *) value {
    
    // Do something with the BOOL result
    NSString *result = [value copy];
    
    // hiding the HUD ..
    [HUD setHidden:YES];
    
    NSError *e;
    
    NSDictionary *JSON1 = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
    
    NSDictionary *json = [JSON1 objectForKey:@"responseHeader"];
    
    if ([[json objectForKey:@"responseMessage"] isEqualToString:@"Order updated Succesfully"] && [[json objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        
        NSString *status_ = [NSString stringWithFormat:@"%@%@%@%@",@"Successfully Updated Ordered",@"\n",@"Order ID :",[JSON1 objectForKey:@"orderId"]];
        wareEditPurchaseOrderID = [[JSON1 objectForKey:@"orderId"] copy];
        SystemSoundID	soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"mp3"];
        self.soundFileURLRef = (CFURLRef) [tapSound retain];
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        //        NSString *receiptID = [JSON objectForKey:@"receipt_id"];
        //        receipt = [receiptID copy];
        UIAlertView *successAlertView  = [[UIAlertView alloc] init];
        [successAlertView setDelegate:self];
        [successAlertView setTitle:@"Success"];
        [successAlertView setMessage:status_];
        [successAlertView addButtonWithTitle:@"OPEN ORDER"];
        [successAlertView addButtonWithTitle:@"NEW ORDER"];
        
        [successAlertView show];
        
        
        //        customerCode.text = nil;
        //        customerName.text = nil;
        //        address.text = nil;
        //        customerName.text = nil;
        //        address.text= nil;
        //        phNo.text = nil;
        //        email.text = nil;
        //        dueDate.text= nil;
        //        time.text = nil;
        //        shipCharges.text = nil;
        //        paymentMode.text = nil;
        //        shipoMode.text = nil;
        //        executiveName.text = nil;
        //        orderDate.text = nil;
        //        shipment_city.text = nil;
        //        shipment_location.text = nil;
        //        shipment_street.text = nil;
        //        billing_city.text = nil;
        //        billing_location.text = nil;
        //        billing_street.text = nil;
        //        customer_city.text = nil;
        //        customer_location.text = nil;
        //        customer_street.text = nil;
        //        orderChannel.text = nil;
        //        orderDeliveryType.text = nil;
        //        shipmentID.text = nil;
        //        shipCharges.text = nil;
        //        saleLocation.text = nil;
        //        paymentType.text  = nil;
        
        [skuIdArray removeAllObjects];
        [ItemDiscArray removeAllObjects];
        [totalArray removeAllObjects];
        [QtyArray removeAllObjects];
        [ItemArray removeAllObjects];
        [totalQtyArray removeAllObjects];
        
        subTotalData.text = @"0.00";
        taxData.text = @"0.00";
        totAmountData.text = @"0.00";
        
        [orderItemsTable reloadData];
        
    }
    else{
        SystemSoundID	soundFileObject1;
        NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"beep-01a" withExtension: @"wav"];
        self.soundFileURLRef = (CFURLRef) [tapSound retain];
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
        AudioServicesPlaySystemSound (soundFileObject1);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Failed Placing Order" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    if ([alertView.title isEqualToString:@"Success"]) {
        if (buttonIndex == 0) {
            self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
            self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
            
            ViewWareHousePurchaseOrder *vpo = [[ViewWareHousePurchaseOrder alloc] initWithorderID:wareEditPurchaseOrderID];
            [self.navigationController pushViewController:vpo animated:YES];
        }
        else{
            alertView.hidden = YES;
        }
    }
}

- (void) cancelButtonPressed:(id) sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    [self.navigationController popViewControllerAnimated:YES];
}

// DelButton handler...
- (IBAction)delButtonPressed:(id)sender {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        [ItemDiscArray removeObjectAtIndex:[sender tag]];
        [ItemArray removeObjectAtIndex:[sender tag]];
        [priceArray removeObjectAtIndex:[sender tag]];
        [QtyArray removeObjectAtIndex:[sender tag]];
        [totalArray removeObjectAtIndex:[sender tag]];
        [totalQtyArray removeObjectAtIndex:[sender tag]];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception.name);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Problem occured while processing" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    //delButton.tag
   // [skuIdArray removeObjectAtIndex:[sender tag]];

    [orderItemsTable reloadData];
    
    [self displayOrdersData];
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
