//
//  ReceiptGoodsProcurement.m
//  OmniRetailer
//
//  Created by Chandrasekhar on 2/19/15.
//
//

#import "ReceiptGoodsProcurement.h"
#import "RawMaterialServiceSvc.h"
#import "StockReceiptServiceSvc.h"
#import "MaterialTransferReciepts.h"
#import "OpenStockReceipt.h"
#import "Global.h"
#import "SkuServiceSvc.h"
#import "UtilityMasterServiceSvc.h"
#import "OmniHomePage.h"
#import "StockIssueServiceSvc.h"
#import "RequestHeader.h"

@interface MaterialTransferReciepts ()

@end

@implementation MaterialTransferReciepts

@synthesize soundFileURLRef,soundFileObject;
@synthesize receiptId;


NSString *businessFlow = @"";

#pragma  -mark start of ViewLifeCycle mehods....

/**
 * @description  it is one of ViewLifeCylce Method which will be executed first when class(view) is called..
 * @date
 * @method       ViewDidLoad
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments....
 *
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @try {
        
        // calling super call method....
        [super viewDidLoad];
        
        // Do any additional setup after loading the view.
       
        // setting the background colour of the self.view....
        self.view.backgroundColor = [UIColor blackColor];
        
        //reading os version of the build installed device and storing....
        version = [UIDevice currentDevice].systemVersion.floatValue;
        
        //here we reading the DeviceOrientaion....
        currentOrientation = [UIDevice currentDevice].orientation;
        
        //setting sound from sound file....
        NSURL * tapSound   = [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];
        self.soundFileURLRef = (__bridge CFURLRef) tapSound;
        AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject);
        
        //creation of progress/processing bar and adding it to slef.navigationController....
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        // Regiser for HUD callbacks so we can remove it from the window at the right time
        HUD.delegate = self;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pending.gif"]];
        HUD.mode = MBProgressHUDModeCustomView;
        
        //creation of createReceiptView....
        createReceiptView = [[UIView alloc] init];
        createReceiptView.backgroundColor = [UIColor blackColor];
        createReceiptView.layer.borderWidth = 1.0f;
        createReceiptView.layer.cornerRadius = 10.0f;
        createReceiptView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        /*Creation of UILabel for headerDisplay.......*/
        //creating line  UILabel which will display at topOfThe  billingView.......
        UILabel * headerNameLbl = [[UILabel alloc] init];
        headerNameLbl.layer.cornerRadius = 10.0f;
        headerNameLbl.layer.masksToBounds = YES;
        
        headerNameLbl.textAlignment = NSTextAlignmentCenter;
        headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
        
        //it is regard's to the view borderwidth and color setting....
        CALayer * bottomBorder = [CALayer layer];
        bottomBorder.opacity = 5.0f;
        bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
        [headerNameLbl.layer addSublayer:bottomBorder];
        
        
        /*Creation of UIButton for providing user to get th info.......*/
        /*Creation of UIButon used in this page*/
        UIImage * summaryInfoImg;
        UIButton * summaryInfoBtn;
        
        //image used for summary info....
        summaryInfoImg = [UIImage imageNamed:@"summaryInfo.png"];
        
        //creation of summary info....
        summaryInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [summaryInfoBtn setBackgroundImage:summaryInfoImg forState:UIControlStateNormal];
        [summaryInfoBtn addTarget:self
                           action:@selector(displaySummaryInfo:) forControlEvents:UIControlEventTouchDown];
        summaryInfoBtn.hidden = YES;
        
        /*Creation of CustomTextFields....*/
        /*Creation of CustomTextFields used in this page*/
        
        //used in first collum....
        location = [[CustomTextField alloc] init];
        location.delegate = self;
        location.placeholder = NSLocalizedString(@"from_location", nil);
        location.userInteractionEnabled  = NO;
        [location awakeFromNib];
        
        //used in second column....
        issueRef = [[CustomTextField alloc] init];
        issueRef.delegate = self;
        issueRef.placeholder = NSLocalizedString(@"issue_ref_no", nil);
        issueRef.autocorrectionType = UITextAutocorrectionTypeNo;
        issueRef.clearButtonMode = UITextFieldViewModeWhileEditing;
        issueRef.returnKeyType = UIReturnKeyDone;
        [issueRef addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [issueRef awakeFromNib];

        //used in second column....
        toOutletTxt = [[CustomTextField alloc] init];
        toOutletTxt.delegate = self;
        toOutletTxt.placeholder = NSLocalizedString(@"shipped_from", nil);
        toOutletTxt.userInteractionEnabled  = NO;
        [toOutletTxt awakeFromNib];
        
        //used in second column....
        requestRefTxt = [[CustomTextField alloc] init];
        requestRefTxt.delegate = self;
        requestRefTxt.placeholder = NSLocalizedString(@"request_ref_no", nil);
        requestRefTxt.userInteractionEnabled  = NO;
        [requestRefTxt awakeFromNib];
        
        //used in second column....
        deliveredBy = [[CustomTextField alloc] init];
        deliveredBy.delegate = self;
        deliveredBy.placeholder = NSLocalizedString(@"Delivered By",nil);
       //deliveredBy.userInteractionEnabled  = NO;
        [deliveredBy awakeFromNib];
        
        date = [[CustomTextField alloc] init];
        date.delegate = self;
        date.placeholder = NSLocalizedString(@"select_date",nil);
        date.userInteractionEnabled  = NO;
        [date awakeFromNib];
        
        inspectedBy = [[CustomTextField alloc] init];
        inspectedBy.delegate = self;
        inspectedBy.placeholder = NSLocalizedString(@"inspectced_by",nil);
       //inspectedBy.userInteractionEnabled  = NO;
        [inspectedBy awakeFromNib];
        
        
        shippedBy = [[CustomTextField alloc] init];
        shippedBy.delegate = self;
        shippedBy.placeholder = NSLocalizedString(@"shipped_by",nil);
        //shippedBy.userInteractionEnabled  = NO;
        [shippedBy awakeFromNib];

        receivedByTxt = [[CustomTextField alloc] init];
        receivedByTxt.delegate = self;
        receivedByTxt.placeholder = NSLocalizedString(@"received_By",nil);
        receivedByTxt.text = firstName;
        receivedByTxt.userInteractionEnabled  = NO;
        [receivedByTxt awakeFromNib];

        shipmentModeTxt = [[CustomTextField alloc] init];
        shipmentModeTxt.delegate = self;
        shipmentModeTxt.placeholder = NSLocalizedString(@"shipment_mode",nil);
        shipmentModeTxt.userInteractionEnabled  = NO;
        [shipmentModeTxt awakeFromNib];


        UIImage *dropDown_Img = [UIImage imageNamed:@"arrow_1.png"];
        UIImage *calendar_Img = [UIImage imageNamed:@"Calandar_Icon.png"];

        UIButton * selecToLocBtn;
        UIButton * dateBtn;
        UIButton * shipmentModeBtn;

        selectFromLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectFromLocBtn setBackgroundImage:dropDown_Img forState:UIControlStateNormal];
        [selectFromLocBtn addTarget:self action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchUpInside];
        
        selecToLocBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selecToLocBtn setBackgroundImage:dropDown_Img forState:UIControlStateNormal];
        [selecToLocBtn addTarget:self action:@selector(populateLocationsTable:) forControlEvents:UIControlEventTouchUpInside];

        dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [dateBtn setBackgroundImage:calendar_Img forState:UIControlStateNormal];
        [dateBtn addTarget:self action:@selector(DateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

        shipmentModeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shipmentModeBtn setBackgroundImage:dropDown_Img forState:UIControlStateNormal];
        [shipmentModeBtn addTarget:self action:@selector(getShipmentModes:) forControlEvents:UIControlEventTouchUpInside];
        
        //used for identification purpose....
        selectFromLocBtn.tag = 2;
        selecToLocBtn.tag = 4;
        
        searchItem = [[UITextField alloc] init];
        searchItem.borderStyle = UITextBorderStyleRoundedRect;
        searchItem.textColor = [UIColor blackColor];
        searchItem.font = [UIFont systemFontOfSize:18.0];
        searchItem.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
        searchItem.clearButtonMode = UITextFieldViewModeWhileEditing;
        searchItem.autocorrectionType = UITextAutocorrectionTypeNo;
        searchItem.layer.borderColor = [UIColor whiteColor].CGColor;
        searchItem.delegate = self;
        searchItem.placeholder = NSLocalizedString(@"search_sku",nil) ;
        [searchItem addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIImage * productListImg;
        productListImg  = [UIImage imageNamed:@"btn_list.png"];
        
        selectCategoriesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectCategoriesBtn setBackgroundImage:productListImg forState:UIControlStateNormal];
        [selectCategoriesBtn addTarget:self  action:@selector(validatingCategoriesList:) forControlEvents:UIControlEventTouchDown];

        /* creation of header label: */
        sNoLbl = [[CustomLabel alloc] init];
        [sNoLbl awakeFromNib];
        
        sKuidLbl = [[CustomLabel alloc] init];
        [sKuidLbl awakeFromNib];
        
        descLbl = [[CustomLabel alloc] init];
        [descLbl awakeFromNib];

        uomLbl = [[CustomLabel alloc] init];
        [uomLbl awakeFromNib];
        
        priceLbll = [[CustomLabel alloc] init];
        [priceLbll awakeFromNib];
        
        requestedQtyLbl = [[CustomLabel alloc] init];
        [requestedQtyLbl awakeFromNib];
        
        issuedQtyLbl = [[CustomLabel alloc] init];
        [issuedQtyLbl awakeFromNib];
        
        weightedQtyLbl = [[CustomLabel alloc] init];
        [weightedQtyLbl awakeFromNib];
        
        actionLbl = [[CustomLabel alloc] init];
        [actionLbl awakeFromNib];
        
        acceptedQtyLbl = [[CustomLabel alloc] init];
        [acceptedQtyLbl awakeFromNib];

        rejectedQtyLbl = [[CustomLabel alloc] init];
        [rejectedQtyLbl awakeFromNib];
        
        issueRefIdTbl = [[UITableView alloc] init];
        issueRefIdTbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        issueRefIdTbl.dataSource = self;
        issueRefIdTbl.delegate = self;
        (issueRefIdTbl.layer).borderWidth = 1.0f;
        issueRefIdTbl.layer.cornerRadius = 3;
        issueRefIdTbl.layer.borderColor = [UIColor grayColor].CGColor;
        issueRefIdTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        issueRefIdTbl.hidden = YES;
        
        skListTable = [[UITableView alloc] init];
        skListTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        skListTable.dataSource = self;
        skListTable.delegate = self;
        (skListTable.layer).borderWidth = 1.0f;
        skListTable.layer.cornerRadius = 3;
        skListTable.layer.borderColor = [UIColor grayColor].CGColor;
        skListTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        skListTable.hidden = YES;
        
        // Table for storing the items ..
        cartTable = [[UITableView alloc] init];
        cartTable.backgroundColor = [UIColor blackColor];
        cartTable.dataSource = self;
        cartTable.delegate = self;
        cartTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        cartTable.userInteractionEnabled = TRUE;
        
        UILabel *line_ = [[UILabel alloc] init];
        line_.layer.masksToBounds = YES;
        line_.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];

        UILabel *totalQtyLbl = [[UILabel alloc] init];
        totalQtyLbl.layer.cornerRadius = 14;
        totalQtyLbl.layer.masksToBounds = YES;
        totalQtyLbl.textAlignment = NSTextAlignmentLeft;
        totalQtyLbl.font = [UIFont boldSystemFontOfSize:20.0];
        totalQtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        UILabel *totalCostLbl = [[UILabel alloc] init];
        totalCostLbl.layer.cornerRadius = 14;
        totalCostLbl.layer.masksToBounds = YES;
        totalCostLbl.textAlignment = NSTextAlignmentLeft;
        totalCostLbl.font = [UIFont boldSystemFontOfSize:20.0];
        totalCostLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        totalQuantity = [[UILabel alloc] init];
        totalQuantity.text = @"0";
        totalQuantity.layer.cornerRadius = 14;
        totalQuantity.layer.masksToBounds = YES;
        totalQuantity.textAlignment = NSTextAlignmentRight;
        totalQuantity.font = [UIFont boldSystemFontOfSize:20.0];
        totalQuantity.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        totalCost = [[UILabel alloc] init];
        totalCost.text = @"0.0";
        totalCost.layer.cornerRadius = 14;
        totalCost.layer.masksToBounds = YES;
        totalCost.textAlignment = NSTextAlignmentRight;
        totalCost.font = [UIFont boldSystemFontOfSize:20.0];
        totalCost.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];

        UILabel *line_2 = [[UILabel alloc] init];
        line_2.layer.masksToBounds = YES;
        line_2.backgroundColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];

        submitBtn = [[UIButton alloc] init] ;
        submitBtn.backgroundColor = [UIColor grayColor];
        submitBtn.layer.masksToBounds = YES;
        submitBtn.layer.cornerRadius = 5.0f;
        [submitBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
        submitBtn.tag = 2;
        
        saveBtn = [[UIButton alloc] init];
        saveBtn.backgroundColor = [UIColor grayColor];
        saveBtn.layer.masksToBounds = YES;
        saveBtn.layer.cornerRadius = 5.0f;
        saveBtn.tag = 4;
        [saveBtn addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchDown];
        
        cancelButton = [[UIButton alloc] init];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchDown];
        cancelButton.layer.cornerRadius = 5.0f;
        cancelButton.backgroundColor = [UIColor grayColor];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.tag = 4;
        
        //Allocation of TotalValue Lables.....
        
        requestQtyValueLbl = [[UILabel alloc] init];
        requestQtyValueLbl.layer.cornerRadius = 5;
        requestQtyValueLbl.layer.masksToBounds = YES;
        requestQtyValueLbl.backgroundColor = [UIColor blackColor];
        requestQtyValueLbl.layer.borderWidth = 2.0f;
        requestQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        requestQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
        requestQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        issueQtyValueLbl = [[UILabel alloc] init];
        issueQtyValueLbl.layer.cornerRadius = 5;
        issueQtyValueLbl.layer.masksToBounds = YES;
        issueQtyValueLbl.backgroundColor = [UIColor blackColor];
        issueQtyValueLbl.layer.borderWidth = 2.0f;
        issueQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        issueQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
        issueQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        weighedQtyValueLbl = [[UILabel alloc] init];
        weighedQtyValueLbl.layer.cornerRadius = 5;
        weighedQtyValueLbl.layer.masksToBounds = YES;
        weighedQtyValueLbl.backgroundColor = [UIColor blackColor];
        weighedQtyValueLbl.layer.borderWidth = 2.0f;
        weighedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        weighedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
        weighedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        acceptedQtyValueLbl = [[UILabel alloc] init];
        acceptedQtyValueLbl.layer.cornerRadius = 5;
        acceptedQtyValueLbl.layer.masksToBounds = YES;
        acceptedQtyValueLbl.backgroundColor = [UIColor blackColor];
        acceptedQtyValueLbl.layer.borderWidth = 2.0f;
        acceptedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        acceptedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
        acceptedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];

        rejectedQtyValueLbl = [[UILabel alloc] init];
        rejectedQtyValueLbl.layer.cornerRadius = 5;
        rejectedQtyValueLbl.layer.masksToBounds = YES;
        rejectedQtyValueLbl.backgroundColor = [UIColor blackColor];
        rejectedQtyValueLbl.layer.borderWidth = 2.0f;
        rejectedQtyValueLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
        rejectedQtyValueLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:15.0f];
        rejectedQtyValueLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        requestQtyValueLbl.text      = @"0.0";
        issueQtyValueLbl.text        = @"0.0";
        weighedQtyValueLbl.text      = @"0.0";
        acceptedQtyValueLbl.text     = @"0.0";
        rejectedQtyValueLbl.text     = @"0.0";
        
        requestQtyValueLbl.textAlignment  = NSTextAlignmentCenter;
        issueQtyValueLbl.textAlignment    = NSTextAlignmentCenter;
        weighedQtyValueLbl.textAlignment  = NSTextAlignmentCenter;
        acceptedQtyValueLbl.textAlignment = NSTextAlignmentCenter;
        rejectedQtyValueLbl.textAlignment = NSTextAlignmentCenter;

        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        cancelButton.userInteractionEnabled = YES;
        
        closeBtn = [[UIButton alloc] init] ;
        [closeBtn addTarget:self action:@selector(closePriceView:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.tag = 11;
        
        UIImage * image = [UIImage imageNamed:@"delete.png"];
        [closeBtn setBackgroundImage:image    forState:UIControlStateNormal];

        //Allocation of Price View...
        
        priceView = [[UIView alloc] init];
        priceView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
        priceView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7].CGColor;
        priceView.layer.borderWidth = 1.0;
        
        priceTable = [[UITableView alloc] init];
        priceTable.backgroundColor = [UIColor blackColor];
        priceTable.dataSource = self;
        priceTable.delegate = self;
        priceTable.layer.cornerRadius = 3;

        transparentView = [[UIView alloc]init];
        transparentView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
        transparentView.hidden = YES;
        
        descLabl = [[CustomLabel alloc]init];
        [descLabl awakeFromNib];
        
        mrpLbl = [[CustomLabel alloc]init];
        [mrpLbl awakeFromNib];
        
        priceLbl = [[CustomLabel alloc]init];
        [priceLbl awakeFromNib];
        
        //added by Srinivasulu on 27/05/2017....
        
        /*Creation of  UISCrollView*/
        stockReceiptItemsScrollView = [[UIScrollView alloc] init];
        
        //upto here on 27/05/2017....
        [createReceiptView addSubview:headerNameLbl];

        [createReceiptView addSubview:summaryInfoBtn];
        [createReceiptView addSubview:location];
        [createReceiptView addSubview:issueRef];
        [createReceiptView addSubview:toOutletTxt];
        [createReceiptView addSubview:requestRefTxt];
        [createReceiptView addSubview:deliveredBy];
       
        [createReceiptView addSubview:date];
        [createReceiptView addSubview:inspectedBy];
        [createReceiptView addSubview:shippedBy];
        [createReceiptView addSubview:receivedByTxt];
        [createReceiptView addSubview:shipmentModeTxt];
        
        if (!isHubLevel) {
            
            location.text = presentLocation;
            selectFromLocBtn.hidden = YES;
            
        }
        [createReceiptView addSubview:selectFromLocBtn];
        [createReceiptView addSubview:selecToLocBtn];
        [createReceiptView addSubview:dateBtn];
        [createReceiptView addSubview:shipmentModeBtn];

       
        [createReceiptView addSubview:searchItem];
        [createReceiptView addSubview:selectCategoriesBtn];

        [stockReceiptItemsScrollView addSubview:sNoLbl];
        [stockReceiptItemsScrollView addSubview:sKuidLbl];
        [stockReceiptItemsScrollView addSubview:descLbl];
        [stockReceiptItemsScrollView addSubview:uomLbl];
        [stockReceiptItemsScrollView addSubview:priceLbll];
        [stockReceiptItemsScrollView addSubview:acceptedQtyLbl];
        [stockReceiptItemsScrollView addSubview:rejectedQtyLbl];
       
        //[stockReceiptItemsScrollView addSubview:costLbl];
        
        [stockReceiptItemsScrollView addSubview:issuedQtyLbl];
        [stockReceiptItemsScrollView addSubview:requestedQtyLbl];
        [stockReceiptItemsScrollView addSubview:weightedQtyLbl];
        [stockReceiptItemsScrollView addSubview:actionLbl];
        
        [stockReceiptItemsScrollView addSubview:cartTable];
        
        [createReceiptView addSubview:stockReceiptItemsScrollView];
//        //upto here on 27/05/2017....
       
        [createReceiptView addSubview:submitBtn];
        [createReceiptView addSubview:saveBtn];
        [createReceiptView addSubview:cancelButton];

        [createReceiptView addSubview:requestQtyValueLbl];
        [createReceiptView addSubview:issueQtyValueLbl];
        [createReceiptView addSubview:weighedQtyValueLbl];
        [createReceiptView addSubview:acceptedQtyValueLbl];
        [createReceiptView addSubview:rejectedQtyValueLbl];

        [createReceiptView addSubview:skListTable];
        [createReceiptView addSubview:issueRefIdTbl];
        
        [self.view addSubview:createReceiptView];
        
        [priceView addSubview:priceLbl];
        [priceView addSubview:mrpLbl];
        [priceView addSubview:descLabl];
        [priceView addSubview:priceTable];
        [transparentView addSubview:priceView];
        [transparentView addSubview:closeBtn];
        [self.view addSubview:transparentView];
        
        //added by Srinivasulu on 27/05/2017....
        
        //populating text to textFields....
        @try {
            //setting the product title Label text....

            self.titleLabel.text = NSLocalizedString(@"omni_retailer", nil);

            //setting the titleLable text....
            headerNameLbl.text = NSLocalizedString(@"new_stock_receipt",nil);
            
            //setting titletext for the hud....
            HUD.labelText = NSLocalizedString(@"please_wait..",nil);
            
            [submitBtn setTitle:NSLocalizedString(@"submit",nil) forState:UIControlStateNormal];
            [saveBtn setTitle:NSLocalizedString(@"save",nil) forState:UIControlStateNormal];
            [cancelButton setTitle:NSLocalizedString(@"cancel",nil) forState:UIControlStateNormal];
            
            totalQtyLbl.text = NSLocalizedString(@"total_Qty",nil);
            totalCostLbl.text = NSLocalizedString(@"total_cost", nil);
            
            //setting text for the UILabels used as table headers....
            sNoLbl.text = NSLocalizedString(@"Sno",nil);
            sKuidLbl.text = NSLocalizedString(@"Sku ID",nil);
            descLbl.text = NSLocalizedString(@"Desc",nil);
            uomLbl.text = NSLocalizedString(@"uom",nil);
            priceLbll.text = NSLocalizedString(@"Price",nil);
            
            issuedQtyLbl.text = NSLocalizedString(@"issue_qty",nil);
            costLbl.text = NSLocalizedString(@"Cost",nil);
            acceptedQtyLbl.text = NSLocalizedString(@"accepted_qty",nil);
            rejectedQtyLbl.text = NSLocalizedString(@"rejected_qty",nil);
            
            //added by Srinivasulu on 27/05/2017....
            
            requestedQtyLbl.text = NSLocalizedString(@"req_qty",nil);
            weightedQtyLbl.text = NSLocalizedString(@"weighed_qty",nil);
            actionLbl.text = NSLocalizedString(@"action",nil);
            
            //upto here on 27/05/2017...
            
            
            descLabl.text = NSLocalizedString(@"description", nil);
            mrpLbl.text = NSLocalizedString(@"mrp_rps", nil);
            priceLbl.text = NSLocalizedString(@"price", nil);

        } @catch (NSException *exception) {
            
        }
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                
            }
            else{
            }
            
            @try {
                createReceiptView.frame = CGRectMake( 2, 70, self.view.frame.size.width - 4, self.view.frame.size.height - 80);
                
                
                //seting frame for headerNameLbl....
                headerNameLbl.frame = CGRectMake( 0, 0, createReceiptView.frame.size.width, 45);
                
                //seting frame for summaryInfoBtn....
                summaryInfoBtn.frame = CGRectMake(createReceiptView.frame.size.width-55,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+5 , 35, 30);
                
                float horizontalWidth = 25;
                
                //Row 1
                location.frame = CGRectMake(createReceiptView.frame.origin.x+10, headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+10,180, 40);
                
                issueRef.frame = CGRectMake(location.frame.origin.x+location.frame.size.width+horizontalWidth, location.frame.origin.y, location.frame.size.width,40);

                toOutletTxt.frame = CGRectMake(issueRef.frame.origin.x+issueRef.frame.size.width+horizontalWidth, location.frame.origin.y, location.frame.size.width,40);
                
                requestRefTxt.frame = CGRectMake(toOutletTxt.frame.origin.x+toOutletTxt.frame.size.width+horizontalWidth, location.frame.origin.y, location.frame.size.width,40);

                deliveredBy.frame = CGRectMake(requestRefTxt.frame.origin.x+requestRefTxt.frame.size.width+horizontalWidth,location.frame.origin.y,location.frame.size.width,40);
                
                //second Row....
                
                date.frame = CGRectMake(location.frame.origin.x,location.frame.origin.y+location.frame.size.height+10,location.frame.size.width,40);
                
                inspectedBy.frame = CGRectMake(issueRef.frame.origin.x,date.frame.origin.y,location.frame.size.width,40);
                
                shippedBy.frame = CGRectMake(toOutletTxt.frame.origin.x,date.frame.origin.y,location.frame.size.width,40);
                
                receivedByTxt.frame = CGRectMake(requestRefTxt.frame.origin.x,date.frame.origin.y,location.frame.size.width,40);
               
                shipmentModeTxt.frame = CGRectMake(deliveredBy.frame.origin.x,date.frame.origin.y,location.frame.size.width,40);
 
                selectFromLocBtn.frame = CGRectMake((location.frame.origin.x+location.frame.size.width-45), location.frame.origin.y-8, 50, 55);
                
                selecToLocBtn.frame = CGRectMake((toOutletTxt.frame.origin.x+toOutletTxt.frame.size.width-45), toOutletTxt.frame.origin.y-8, 50, 55);

                dateBtn.frame = CGRectMake((date.frame.origin.x+date.frame.size.width-45), date.frame.origin.y+2, 40, 35);
 
                shipmentModeBtn.frame = CGRectMake((shipmentModeTxt.frame.origin.x+shipmentModeTxt.frame.size.width-45), shipmentModeTxt.frame.origin.y-8, 50, 55);
               
                // end of header view Text Fields:
                
                searchItem.frame = CGRectMake(date.frame.origin.x,date.frame.origin.y+date.frame.size.height+20,summaryInfoBtn.frame.origin.x+summaryInfoBtn.frame.size.width -(date.frame.origin.x+70), 40);
                
                selectCategoriesBtn.frame = CGRectMake((searchItem.frame.origin.x+searchItem.frame.size.width + 5),searchItem.frame.origin.y,75,searchItem.frame.size.height);
            
                line_.frame = CGRectMake(searchItem.frame.origin.x + searchItem.frame.size.width - 220, createReceiptView.frame.size.height -70,300, 2);
                
                totalQtyLbl.frame = CGRectMake( line_.frame.origin.x, line_.frame.origin.y + line_.frame.size.height, 150, 40);
                
                totalCostLbl.frame = CGRectMake(totalQtyLbl.frame.origin.x , totalQtyLbl.frame.origin.y + totalQtyLbl.frame.size.height-10, totalQtyLbl.frame.size.width, totalQtyLbl.frame.size.height);
                
                totalQuantity.frame = CGRectMake(totalQtyLbl.frame.origin.x +  totalQtyLbl.frame.size.width, totalQtyLbl.frame.origin.y,  line_.frame.size.width - totalQtyLbl.frame.size.width, totalQtyLbl.frame.size.height);
                
                totalCost.frame = CGRectMake(totalQuantity.frame.origin.x , totalCostLbl.frame.origin.y,  totalQuantity.frame.size.width, totalQuantity.frame.size.height);
                
                line_2.frame = CGRectMake(line_.frame.origin.x,totalCostLbl.frame.origin.y+
                                          totalCostLbl.frame.size.height,line_.frame.size.width,line_.frame.size.height);
                // frame for the UIButtons...
                submitBtn.frame = CGRectMake(searchItem.frame.origin.x,createReceiptView.frame.size.height-45,110, 40);
                
                saveBtn.frame = CGRectMake(submitBtn.frame.origin.x+submitBtn.frame.size.width+20,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
                
                cancelButton.frame = CGRectMake(saveBtn.frame.origin.x+saveBtn.frame.size.width+20,submitBtn.frame.origin.y,submitBtn.frame.size.width,40);
                
                stockReceiptItemsScrollView.frame = CGRectMake(searchItem.frame.origin.x, searchItem.frame.origin.y + searchItem.frame.size.height+5,searchItem.frame.size.width+80, submitBtn.frame.origin.y- (searchItem.frame.origin.y + searchItem.frame.size.height + 10));
                //upto here on 27/05/2017....
                
                sNoLbl.frame = CGRectMake(0,0,60,35);
                
                sKuidLbl.frame = CGRectMake((sNoLbl.frame.origin.x + sNoLbl.frame.size.width +2),sNoLbl.frame.origin.y, 100, sNoLbl.frame.size.height);
                
                descLbl.frame = CGRectMake((sKuidLbl.frame.origin.x + sKuidLbl.frame.size.width +2),sNoLbl.frame.origin.y,150, sNoLbl.frame.size.height);
                
                uomLbl.frame = CGRectMake((descLbl.frame.origin.x + descLbl.frame.size.width +2),sNoLbl.frame.origin.y, 65, sNoLbl.frame.size.height);
                
                requestedQtyLbl.frame = CGRectMake((uomLbl.frame.origin.x + uomLbl.frame.size.width +2),sNoLbl.frame.origin.y, 90, sNoLbl.frame.size.height);
                
                issuedQtyLbl.frame = CGRectMake((requestedQtyLbl.frame.origin.x + requestedQtyLbl.frame.size.width +2),sNoLbl.frame.origin.y, 100, sNoLbl.frame.size.height);
                
                weightedQtyLbl.frame = CGRectMake((issuedQtyLbl.frame.origin.x + issuedQtyLbl.frame.size.width +2), sNoLbl.frame.origin.y, 110, sNoLbl.frame.size.height);
                
                acceptedQtyLbl.frame = CGRectMake((weightedQtyLbl.frame.origin.x+weightedQtyLbl.frame.size.width +2), sNoLbl.frame.origin.y,100, sNoLbl.frame.size.height);
                
                rejectedQtyLbl.frame = CGRectMake((acceptedQtyLbl.frame.origin.x+acceptedQtyLbl.frame.size.width +2), sNoLbl.frame.origin.y,90, sNoLbl.frame.size.height);
                
                actionLbl.frame = CGRectMake((rejectedQtyLbl.frame.origin.x + rejectedQtyLbl.frame.size.width + 2), sNoLbl.frame.origin.y,115,sNoLbl.frame.size.height);
                
                // sku Table frame
                skListTable.frame = CGRectMake(searchItem.frame.origin.x, searchItem.frame.origin.y + searchItem.frame.size.height , searchItem.frame.size.width, 260);
                
                cartTable.frame = CGRectMake( sNoLbl.frame.origin.x, sNoLbl.frame.origin.y +  sNoLbl.frame.size.height, actionLbl.frame.origin.x + actionLbl.frame.size.width,  stockReceiptItemsScrollView.frame.size.height - (sNoLbl.frame.origin.y +  sNoLbl.frame.size.height+10));
                
                requestQtyValueLbl.frame = CGRectMake(requestedQtyLbl.frame.origin.x+7,submitBtn.frame.origin.y,requestedQtyLbl.frame.size.width,40);
                issueQtyValueLbl.frame = CGRectMake(issuedQtyLbl.frame.origin.x+7,requestQtyValueLbl.frame.origin.y,issuedQtyLbl.frame.size.width,40);
                weighedQtyValueLbl.frame = CGRectMake(weightedQtyLbl.frame.origin.x+7,requestQtyValueLbl.frame.origin.y,weightedQtyLbl.frame.size.width,40);
                acceptedQtyValueLbl.frame = CGRectMake(acceptedQtyLbl.frame.origin.x+7,requestQtyValueLbl.frame.origin.y,acceptedQtyLbl.frame.size.width,40);
                
                rejectedQtyValueLbl.frame = CGRectMake(rejectedQtyLbl.frame.origin.x+7,requestQtyValueLbl.frame.origin.y,rejectedQtyLbl.frame.size.width,40);

                
                //stockReceiptItemsScrollView.contentSize = CGSizeMake( cartTable.frame.origin.x + cartTable.frame.size.width, stockReceiptItemsScrollView.frame.size.height);
                
                //frame for the Transparent view:
                
                transparentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                
                priceView.frame = CGRectMake(200, 300, 490,300);
                
                descLabl.frame = CGRectMake(0,5,180, 35);
                mrpLbl.frame = CGRectMake(descLabl.frame.origin.x+descLabl.frame.size.width+2,descLabl.frame.origin.y, 150, 35);
                priceLbl.frame = CGRectMake(mrpLbl.frame.origin.x+mrpLbl.frame.size.width+2, descLabl.frame.origin.y, 150, 35);
                
                priceTable.frame = CGRectMake(descLabl.frame.origin.x,descLabl.frame.origin.y+descLabl.frame.size.height+5, priceLbl.frame.origin.x+priceLbl.frame.size.width - (descLabl.frame.origin.x), priceView.frame.size.height - (descLabl.frame.origin.y + descLabl.frame.size.height+20));
                
                closeBtn.frame = CGRectMake(priceView.frame.size.width+165, priceView.frame.origin.y-38, 40, 40);
                
                
                @try {
                    
                    [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:self.view andSubViews:YES fontSize:16.0f cornerRadius:0];
                   
                    headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
                    submitBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    saveBtn.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                    cancelButton.titleLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

                } @catch (NSException *exception) {
                    
                }
            }
            @catch (NSException *exception) {
            }
        }
        else {
            //need to code for iPHONE....
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

/**
 * @description  it is one of ViewLifeCylce Method which will be executed after execution of
 viewDidAppear.......
 * @date
 * @method       viewWillAppear
 * @author
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments....
 *
 */

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    @try {
        
        if (receiptId !=nil) {
            
            [self callingReceiptDetails];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        if (rawMaterialDetails == nil)
            rawMaterialDetails = [NSMutableArray new];
    }
}


#pragma -mark end of ViewLifeCylce Methods....

/**
 * @description  it will be executed when memory warning is receiveds.......
 * @date         27/02/2017
 * @method       didReceiveMemoryWarning
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


/**
 * @description  this method is used to get the locations based on bussinessActivty...
 * @date         21/09/2016
 * @method       getLocations
 * @author       Bhargav Ram
 * @param        int
 * @param        NSString
 * @return
 *
 * @modified BY  Srinivasulu on 17/01/2016
 * @reason       hiding the HUD in catch block....
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocations {
    
    @try {
        
        
        [HUD setHidden: NO];
        
        NSArray * loyaltyKeys = @[START_INDEX,REQUEST_HEADER,BUSSINESS_ACTIVITY];
        
        NSArray * loyaltyObjects = @[NEGATIVE_ONE ,[RequestHeader getRequestHeader],@""];
        
        NSDictionary * dictionary_ = [NSDictionary dictionaryWithObjects:loyaltyObjects forKeys:loyaltyKeys];
        
        NSError * err_;
        NSData * jsonData_ = [NSJSONSerialization dataWithJSONObject:dictionary_ options:0 error:&err_];
        NSString * loyaltyString = [[NSString alloc] initWithData:jsonData_ encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.utilityMasterDelegate = self;
        [webServiceController getAllLocationDetailsData:loyaltyString];
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

        
    } @finally {
        
    }
}


/**
 * @description  calling the products
 * @date         06/10/2016
 * @method       callRawMaterials
 * @author       Bhargav
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callRawMaterials:(NSString *)searchString {
    
    @try {
        [HUD show:YES];
        [HUD setHidden:NO];
        
        
        NSMutableDictionary * searchProductDic = [[NSMutableDictionary alloc] init];
        
        searchProductDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        searchProductDic[START_INDEX] = @"0";
        searchProductDic[kSearchCriteria] = searchString;
        searchProductDic[kStoreLocation] = presentLocation;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:searchProductDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.searchProductDelegate = self;
        [webServiceController searchProductsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/10/2016
 * @method       callRawMaterialDetails:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 *
 * @modified BY  Srinivasulu on 17/11/2016
 *
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)callRawMaterialDetails:(NSString *)pluCodeStr {
    
    @try {
        [HUD show:YES];
        [HUD setHidden: NO];
        
        NSMutableDictionary * productDetailsDic = [[NSMutableDictionary alloc] init];
        
        productDetailsDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        productDetailsDic[kStoreLocation] = presentLocation;
        productDetailsDic[ITEM_SKU] = pluCodeStr;
        productDetailsDic[START_INDEX] = NEGATIVE_ONE;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:productDetailsDic options:0 error:&err];
        NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //getSkuid.skuID = salesReportJsonString;
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.getSkuDetailsDelegate = self;
        [webServiceController getSkuDetailsWithData:salesReportJsonString];
        
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    
}




/**
 * @description  this method is used to get Categories List...
 * @date         21/09/2016
 * @method       callingCategoriesList
 * @author       Bhargav Ram
 * @param        NSString
 * @return
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingCategoriesList {
    
    @try {
        [HUD show:YES];
        
        [HUD setHidden:NO];
        
        [HUD setLabelText:NSLocalizedString(@"please_wait..", nil)];
        
        if(categoriesArr == nil){
            categoriesArr  = [NSMutableArray new];
            checkBoxArr    = [NSMutableArray new];
        }
        
        NSMutableDictionary * locationWiseCategoryDictionary = [[NSMutableDictionary alloc]init];
        
        [locationWiseCategoryDictionary setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        
        [locationWiseCategoryDictionary setValue:presentLocation forKey:kStoreLocation];
        
        
        [locationWiseCategoryDictionary setValue:NEGATIVE_ONE forKey:START_INDEX_STR];
        
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:OUTLET_ALL];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:WAREHOUSE_ALL];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ISSUE_AND_CLOSE];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:kNotForDownload];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:SAVE_STOCK_REPORT];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ENFORCE_GENERATE_PO];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:IS_TOTAL_COUNT_REQUIRED];
        [locationWiseCategoryDictionary setValue:[NSNumber numberWithBool:false] forKey:ZERO_STOCK_CHECK_AT_OUTLET_LEVEL];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:locationWiseCategoryDictionary options: 0 error: &err];
        NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@--json product Categories String--",getProductsJsonString);
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.skuServiceDelegate = self;
        [webServiceController getCategoriesByLocation:getProductsJsonString];
        
    }
    @catch (NSException *exception) {
       
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

    }
}


/**
 * @description  we are sending the request to get items for the selected multiple categories.......
 * @date         20/0/2016
 * @method       multipleCategriesSelected
 * @author       Bhargav Ram
 * @param        UIButton
 * @param
 * @return
 
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)multipleCategriesSelection:(UIButton *)sender {
    @try {
        NSMutableArray * catArr = [NSMutableArray new];
        Boolean * selectCategory = true;
        
        if (sender.tag != 2) {
            
            for(int i = 0; i < checkBoxArr.count; i++){
                
                if([checkBoxArr[i] integerValue]){
                    
                    selectCategory = false;
                    
                    NSDictionary * locDic = categoriesArr[i];
                    [catArr addObject:locDic];
                }
                
            }
            
            if (selectCategory) {
                [HUD setHidden:YES];
                [self displayAlertMessage:NSLocalizedString(@"please_select_atleast_one_category", nil) horizontialAxis:(self.view.frame.size.width - 350)/2   verticalAxis:self.view.frame.size.height - 250  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:2];
                
                return;
            }
            
        }
        
        @try {
            [HUD setHidden:NO];
            NSMutableDictionary * priceListDic = [[NSMutableDictionary alloc]init];
            
            priceListDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            priceListDic[START_INDEX] = NEGATIVE_ONE;
            priceListDic[CATEGORY_LIST] = catArr;
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:priceListDic options:0 error:&err];
            
            NSString * getProductsJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@--json product Categories String--",getProductsJsonString);
            
            WebServiceController * webServiceController = [WebServiceController new];
            webServiceController.skuServiceDelegate = self;
            [webServiceController getPriceListSkuDetails:getProductsJsonString];
            
        }
        @catch (NSException * exception) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified by Srinivasulu on 13/04/2017....
 * @reason       added commons and changed method name
 *
 */

-(void)getStockIssuesFromOutlet {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden:NO];
        
        if(issueRefIdsArr == nil ){
            
            issueRefIdsArr = [NSMutableArray new];
        }
        else if(issueRefIdsArr.count ){
            
            [issueRefIdsArr removeAllObjects];
        }
        NSMutableDictionary * issueIdsDictionary = [[NSMutableDictionary alloc] init];
        
        issueIdsDictionary[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        issueIdsDictionary[START_INDEX] = NEGATIVE_ONE;
        //[issueIdsDictionary setObject:presentLocation forKey:kIssuedTo];
        issueIdsDictionary[kShippedFrom] = toOutletTxt.text;
        issueIdsDictionary[kSearchCriteria] = issueRef.text;
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:issueIdsDictionary options:0 error:&err];
        
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController getStockIssue:getStockIssueJsonString];
    }
    @catch (NSException *exception) {
        
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}


/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified by Srinivasulu on 13/04/2017....
 * @reason       added commons and changed method name
 *
 */

-(void)getStockIssuesFromWarehouse {
    
    @try {
        
         [HUD show:YES];
        [HUD setHidden:NO];
        
        if(issueRefIdsArr == nil ){
            
            issueRefIdsArr = [NSMutableArray new];
        }
        else if(issueRefIdsArr.count ){
            
            [issueRefIdsArr removeAllObjects];
        }
        
        NSArray *headerKeys_ = @[REQUEST_HEADER,START_INDEX,FROM_STORE_CODE,SEARCH_CRITERIA];
        NSArray * headerObjects_ = @[[RequestHeader getRequestHeader], [NSString stringWithFormat:@"%d",-1],location.text,issueRef.text];
        
        NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:headerObjects_ forKeys:headerKeys_];
        
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController getWarehouseIssueIds:getStockIssueJsonString];
    }
    @catch (NSException *exception) {
       
        [HUD setHidden: YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)callingIssueIdDetails:(NSString *)IssueIdString  {
    
    @try {
        
        [HUD setHidden:NO];
        
        NSMutableDictionary * issueDetails = [[NSMutableDictionary alloc] init];
        [issueDetails setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [issueDetails setValue:IssueIdString forKey:kGoodsIssueRef];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:issueDetails options:0 error:&err];
        
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController getStockIssueId:getStockIssueJsonString];
        
    }
    @catch (NSException *exception) {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

    }
}


-(void)getWarehouseIssueDetails:(NSString*)issueId {
    
    @try {
        
        [HUD setHidden:NO];
        
        NSMutableDictionary * issueDetails = [[NSMutableDictionary alloc] init];
        [issueDetails setValue:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
        [issueDetails setValue:issueId forKey:kGoodsIssueRef];
        NSError  * err;
        NSData   * jsonData    = [NSJSONSerialization dataWithJSONObject:issueDetails options:0 error:&err];
        NSString * getStockIssueJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
       
        WebServiceController * webServiceController = [WebServiceController new];
        webServiceController.stockIssueDelegate = self;
        [webServiceController getWarehouseIssueDetails:getStockIssueJsonString];
        
    }
    
    @catch (NSException *exception) {
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}


/**
 * @description  Fetching the details of a particular receipt ID when it is in Draft State..
 * @date
 * @method       callingReceiptDetails
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 14/04/2017....
 * @reason      added the comments and hidding HUD in catch....
 *
 */


-(void)callingReceiptDetails {
    
    @try {
        
        [HUD show:YES];
        [HUD setHidden: NO];
        
        NSMutableDictionary * receiptDetails = [[NSMutableDictionary alloc] init];
        receiptDetails[REQUEST_HEADER] = [RequestHeader getRequestHeader];
        
        receiptDetails[kGoodsReceiptRef] = receiptId;
        NSError  * err;
        NSData   * jsonData = [NSJSONSerialization dataWithJSONObject:receiptDetails options:0 error:&err];
        NSString * getStockReceiptJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        WebServiceController *webServiceController = [WebServiceController new];
        webServiceController.stockReceiptDelegate = self;
        [webServiceController getStockReceiptDetails:getStockReceiptJsonString];
    }
    @catch (NSException *exception) {
       
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
}



/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified By   Srinivasulu on 14/04/2017....
 * @reason        added comments and hidding the hud in catch....
 *
 */

-(void)submitButtonPressed:(UIButton *) sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        if (rawMaterialDetails.count == 0) {
            
            float y_axis = self.view.frame.size.height - 120;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",NSLocalizedString(@"please_add_items_to_the_cart", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 320)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];        }
        
        else if((location.text).length == 0) {
            [HUD setHidden:YES];
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItem.isEditing)
                y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"please_select_issued_location", nil),@"\n",@""];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:350 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
        }
        
        else if((date.text).length == 0){
           
            [HUD setHidden:YES];
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItem.isEditing)
                y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"please_select_shipped_date", nil),@"\n",@""];
            
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:3];
        }
        else if((shipmentModeTxt.text).length == 0){
            [HUD setHidden:YES];
        
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItem.isEditing)
                y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
            
            
            NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"please_select_shipment_mode", nil),@"\n",@""];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 400)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:400 contentHeight:100  isSoundRequired:YES timming:2.0 noOfLines:3];
        }
        
        else {
            [HUD setHidden:NO];
            
            //changed By srinivauslu on 02/05/2018....
            //reason.. Need to stop user internation after servcie calls...
            
            submitBtn.userInteractionEnabled = NO;
            saveBtn.userInteractionEnabled = NO;
            
            //upto here on 02/05/2018....
            
            // NO_OF_ITEMS added by roja...
             int  noOfItems = (int)rawMaterialDetails.count;
            stockReceiptDic[NO_OF_ITEMS] = [NSNumber numberWithFloat:noOfItems];
            stockReceiptDic[REQUEST_HEADER] = [RequestHeader getRequestHeader];
            
            NSMutableArray * locArr = [NSMutableArray new];
            
            for (NSDictionary * dic in rawMaterialDetails) {
                
                NSMutableDictionary *itemDetailsDic = [dic mutableCopy];
                [itemDetailsDic setValue:@([[dic valueForKey:ITEM_UNIT_PRICE] floatValue] * [[dic valueForKey:ACCEPTED_QTY] floatValue]) forKey:COST];
                [locArr addObject:itemDetailsDic];
            }
            
            stockReceiptDic[RECEIPT_DETAILS] = locArr;
            
            NSString *deliveryDteStr = date.text;
            
            if(deliveryDteStr.length > 1)
                deliveryDteStr = [NSString stringWithFormat:@"%@%@", date.text,@" 00:00:00"];
            
            stockReceiptDic[DELIVERY_DATE] = deliveryDteStr;
            stockReceiptDic[kReceiptTotal] = @((totalCost.text).floatValue);
            stockReceiptDic[kReceiptTotalQty] = @((totalQuantity.text).floatValue);
            stockReceiptDic[GRAND_TOTAL] = @((totalCost.text).floatValue);
            stockReceiptDic[kSubTotal] = @((totalCost.text).floatValue);
            
            stockReceiptDic[kShipmentMode] = shipmentModeTxt.text;
            
            if((issueRef.text).length > 0) {
                stockReceiptDic[kIssueReferenceNo] = issueRef.text;
            }
            
            // commented by roja
//            if([requestRefTxt.text length] > 0){
//                [stockReceiptDic setObject:requestRefTxt.text forKey:kShipmentRef];
//            }
            
            // added by roja
            if((issueRef.text).length > 0){
                stockReceiptDic[kShipmentRef] = issueRef.text;
            }
            
            if((receivedByTxt.text).length > 0){
                stockReceiptDic[RECEIVED_by] = receivedByTxt.text;
                //kReceivedBy
            }
            
            if ((inspectedBy.text).length>0) {
                stockReceiptDic[Inspected_By] = inspectedBy.text;
                //INSPECTED_BY
            }
            
            if(sender.tag ==4)
                stockReceiptDic[STATUS] = DRAFT;
            
            else
                stockReceiptDic[STATUS] = RECEIVED;
            
            
            stockReceiptDic[DELIVERED_BY] = deliveredBy.text;
            
            stockReceiptDic[kIssuedBy] = firstName;
            
            stockReceiptDic[CUSTOMER_ID] = custID;
            
            stockReceiptDic[kShippedFrom] = toOutletTxt.text;
            
            stockReceiptDic[kReceiptLocation] = location.text;
            
            // added by roja on 16-07-2018....
            stockReceiptDic[kgoodsReqRef] = requestRefTxt.text;
            
            if (isDraft) {
                
                stockReceiptDic[kGoodsReceiptRef] = receiptId;
            }
            
            NSError * err;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:stockReceiptDic options:0 error:&err];
            NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"---%@",salesReportJsonString);
            WebServiceController * webServiceController = [WebServiceController new];
            
            if (isDraft) {
                
                webServiceController.stockReceiptDelegate = self;
                [webServiceController updateStockReceipt:jsonData];
            }
            else{
              
                webServiceController.stockReceiptDelegate = self;
                [webServiceController createStockReceipt:jsonData];
            }


//            if (isDraft) {
            
//                [updateStockReceiptDic setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
//
//
//                NSMutableArray * locArr = [NSMutableArray new];
//
//                for (NSDictionary * dic in rawMaterialDetails) {
//
//                    NSMutableDictionary *itemDetailsDic = [dic mutableCopy];
//
//                    [itemDetailsDic setValue:[NSNumber numberWithFloat:[[dic valueForKey:ITEM_UNIT_PRICE] floatValue] * [[dic valueForKey:ACCEPTED_QTY] floatValue]] forKey:COST];
//
//                    [locArr addObject:itemDetailsDic];
//                }
//
//                [updateStockReceiptDic setObject:locArr forKey:RECEIPT_DETAILS];
//
//                [updateStockReceiptDic setObject:[NSNumber numberWithFloat:[totalCost.text floatValue]] forKey:kReceiptTotal];
//                [updateStockReceiptDic setObject:[NSNumber numberWithFloat:[totalQuantity.text floatValue]] forKey:kReceiptTotalQty];
//                [updateStockReceiptDic setObject:[NSNumber numberWithFloat:[totalCost.text floatValue]] forKey:GRAND_TOTAL];
//                [updateStockReceiptDic setObject:[NSNumber numberWithFloat:[totalCost.text floatValue]] forKey:kSubTotal];
//
//                [updateStockReceiptDic setObject:shipmentModeTxt.text forKey:kShipmentMode];
//
//                if([issueRef.text length] > 0) {
//                    [updateStockReceiptDic setObject:issueRef.text forKey:kIssueReferenceNo];
//                }
//                if([requestRefTxt.text length] > 0){
//                    [updateStockReceiptDic setObject:requestRefTxt.text forKey:kShipmentRef];
//                }
//                if([receivedByTxt.text length] > 0){
//                    [updateStockReceiptDic setObject:receivedByTxt.text forKey:kReceivedBy];
//                }
//
//                if ([inspectedBy.text length]>0) {
//                    [updateStockReceiptDic setObject:inspectedBy.text forKey:INSPECTED_BY];
//                }
//
//                if(sender.tag ==4)
//                    [updateStockReceiptDic  setObject:DRAFT forKey:STATUS];
//
//                else
//                    [updateStockReceiptDic setObject:RECEIVED forKey:STATUS];
//
//                [updateStockReceiptDic setObject:receiptId forKey:kGoodsReceiptRef];
//
//
//                [updateStockReceiptDic setObject:deliveredBy.text forKey:DELIVERED_BY];
//
//                [updateStockReceiptDic setObject:firstName forKey:kIssuedBy];
//
//                [updateStockReceiptDic setObject:custID forKey:CUSTOMER_ID];
//
//                [updateStockReceiptDic setObject:toOutletTxt.text forKey:kShippedFrom];
//
//                [updateStockReceiptDic setObject:location.text forKey:kReceiptLocation];
//
//
//                NSError * err;
//                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:updateStockReceiptDic options:0 error:&err];
//                NSString * salesReportJsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//                NSLog(@"---%@",salesReportJsonString);
//
//                WebServiceController * webServiceController = [WebServiceController new];
//                [webServiceController setStockReceiptDelegate:self];
//                [webServiceController updateStockReceipt:jsonData];
//
//            }
            
////            else{
//                NSMutableDictionary * createReceiptDic = [[NSMutableDictionary alloc] init];
//
//                [createReceiptDic setObject:[RequestHeader getRequestHeader] forKey:REQUEST_HEADER];
//
//                NSString *deliveryDteStr = date.text;
//
//                if(deliveryDteStr.length > 1)
//                    deliveryDteStr = [NSString stringWithFormat:@"%@%@", date.text,@" 00:00:00"];
//
//
//                NSMutableArray * locArr = [NSMutableArray new];
//
//
//                for (NSDictionary * dic in rawMaterialDetails) {
//
//                    NSMutableDictionary * itemDetailsDic = [dic mutableCopy];
//
//                    [itemDetailsDic setValue:[NSNumber numberWithFloat:[[dic valueForKey:ITEM_UNIT_PRICE] floatValue] * [[dic valueForKey:ACCEPTED_QTY] floatValue]] forKey:COST];
//
//                    [locArr addObject:itemDetailsDic];
//                }
//
//
//                [createReceiptDic setObject:toOutletTxt.text forKey:kShippedFrom];
//
//                [createReceiptDic setObject:location.text forKey:kReceiptLocation];
//
//                [createReceiptDic setObject:firstName forKey:kIssuedBy];
//
//                [createReceiptDic setObject:deliveredBy.text forKey:DELIVERED_BY];
//
//                [createReceiptDic setObject:deliveryDteStr forKey:DELIVERY_DATE];
//
//                [createReceiptDic setObject:custID forKey:CUSTOMER_ID];
//
//                // added by roja on 16-07-2018....
//                [createReceiptDic setObject:requestRefTxt.text forKey:kgoodsReqRef];
//
//                [createReceiptDic setObject:[NSNumber numberWithFloat:[totalCost.text floatValue]] forKey:kReceiptTotal];
//
//                [createReceiptDic setObject:[NSNumber numberWithFloat:[totalQuantity.text floatValue]] forKey:kReceiptTotalQty];
//
//                [createReceiptDic setObject:receivedByTxt.text forKey:RECEIVED_by];
//
//                [createReceiptDic setObject:inspectedBy.text forKey:inspected_By];
//
//                [createReceiptDic setObject:[NSNumber numberWithFloat:[totalCost.text floatValue]] forKey:GRAND_TOTAL];
//
//                [createReceiptDic setObject:[NSNumber numberWithFloat:[totalCost.text floatValue]] forKey:kSubTotal];
//
//                [createReceiptDic setObject:shipmentModeTxt.text forKey:kShipmentMode];
//
//                if([issueRef.text length] > 0){
//                    [createReceiptDic setObject:issueRef.text forKey:kIssueReferenceNo];
//                }
//                [createReceiptDic setObject:@"" forKey:kShipmentRef];
//
//                if(sender.tag ==4)
//                    [createReceiptDic  setObject:DRAFT forKey:STATUS];
//
//                else
//                    [createReceiptDic setObject:@"Received" forKey:STATUS];
//                [createReceiptDic setObject:locArr forKey:RECEIPT_DETAILS];
//
//                NSError * err;
//                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:createReceiptDic options:0 error:&err];
//                NSString * createStockReceiptJsonString   = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//                NSLog(@"%@--json Request String--",createStockReceiptJsonString);
//
//                WebServiceController * webServiceController = [WebServiceController new];
//                [webServiceController setStockReceiptDelegate:self];
//                [webServiceController createStockReceipt:jsonData];
//
//            }
        }
        
    }
    @catch (NSException * exception) {
        
        [HUD setHidden:YES];
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];

    }

}


#pragma mark Hadling the Success Response & Error Response in Methods...

/**
 * @description
 * @date
 * @method       getLocationSuccessResponse
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
-(void)getLocationSuccessResponse:(NSDictionary *)sucessDictionary {
    @try {
        
        locationArr = [NSMutableArray new];
        
        [locationArr addObject:NSLocalizedString(@"all_outlets",nil)];

        for(NSDictionary * dic in [sucessDictionary valueForKey:LOCATIONS_DETAILS]) {
            if (![[dic valueForKey:LOCATION_ID] isKindOfClass:[NSNull class]] && [[dic valueForKey:LOCATION_ID] caseInsensitiveCompare:presentLocation] != NSOrderedSame) {
                [locationArr addObject:[dic valueForKey:LOCATION_ID]];
            }
            if ([locationArr containsObject:presentLocation]) {
                [locationArr removeObject:presentLocation];
            }
        }
        
        {
            
            //            if (![[dic valueForKey:LOCATION_ID] isKindOfClass:[NSNull class]] && [[dic valueForKey:LOCATION_ID] caseInsensitiveCompare:presentLocation] != NSOrderedSame) {
            //
            //                [locationArr addObject:dic];
            //
            //            }

        }
        
    } @catch (NSException *exception) {
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    @finally {
        [HUD setHidden:YES];
    }
    
}


/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getLocationErrorResponse:(NSString *)error {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        HUD.tag = 0;
        
        [catPopOver dismissPopoverAnimated:YES];
        [HUD setHidden:YES];
    }
    
}

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)searchProductsSuccessResponse:(NSDictionary *)successDictionary {
    
    
    @try {
        
        //checking searchItemsFieldTag.......
        if (successDictionary != nil && (searchItem.tag == (searchItem.text).length) ) {
            
            
            //checking searchItemsFieldTag.......
            if (![successDictionary[PRODUCTS_LIST] isKindOfClass:[NSNull class]]  && [successDictionary.allKeys containsObject:PRODUCTS_LIST]) {
                
                
                for(NSDictionary *dic in [successDictionary valueForKey:PRODUCTS_LIST]){
                    
                    [productListArr addObject:dic];
                }
            }
            
            if(productListArr.count){
                float tableHeight = productListArr.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = productListArr.count * 33;
                
                if(productListArr.count > 5)
                    tableHeight = (tableHeight/productListArr.count) * 5;
                
                [self showPopUpForTables:skListTable popUpWidth:searchItem.frame.size.width  popUpHeight:tableHeight presentPopUpAt:searchItem  showViewIn:createReceiptView];

            }
            else if(catPopOver.popoverVisible)
                [catPopOver dismissPopoverAnimated:YES];
            searchItem.tag = 0;
            [HUD setHidden:YES];
        }
        
        else if ( (((searchItem.text).length >= 3) && (searchItem.tag != 0)) && (searchItem.tag != (searchItem.text).length)) {
            
            searchItem.tag = 0;
            
            [self textFieldDidChange:searchItem];
            
        }
        else  if(catPopOver.popoverVisible || (searchItem.tag == (searchItem.text).length)){
            [catPopOver dismissPopoverAnimated:YES];
            searchItem.tag = 0;
            [HUD setHidden:YES];
            
        }
        else {
            
            [catPopOver dismissPopoverAnimated:YES];
            searchItem.tag = 0;
            [HUD setHidden:YES];
        }
    }
    
    @catch (NSException * exception) {
        
        if(catPopOver.popoverVisible)
            [catPopOver dismissPopoverAnimated:YES];
        searchItem.tag = 0;
        [HUD setHidden:YES];
        
    }
    @finally {
        
        
    }
}

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)searchProductsErrorResponse {
    
    
       @try {
            [HUD setHidden:YES];
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItem.isEditing)
                y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
            
            NSString *mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"no_data_found",nil)];
            
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        }
        

    @catch (NSException *exception) {
        
    }
}

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */
- (void)getSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        if (successDictionary != nil) {
            
            priceDic = [[NSMutableArray alloc]init];
            NSArray * price_arr = [successDictionary valueForKey:kSkuLists];
            
            for (int i=0; i<price_arr.count; i++) {
                
                NSDictionary *json = price_arr[i];
                [priceDic addObject:json];
            }
            if (((NSArray *)[successDictionary valueForKey:kSkuLists]).count >1) {
                
                if (priceDic.count>0) {
                    [HUD setHidden:YES];
                    transparentView.hidden = NO;
                    [priceTable reloadData];
                    SystemSoundID    soundFileObject1;
                    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"popup_tune" withExtension: @"mp3"];
                    self.soundFileURLRef = (__bridge CFURLRef) tapSound ;
                    
                    AudioServicesCreateSystemSoundID (soundFileURLRef,&soundFileObject1);
                    AudioServicesPlaySystemSound (soundFileObject1);
                }
            }
            else  {
                
                BOOL status = FALSE;
                
                int i = 0;
                
                NSMutableDictionary * dic;
                
                
                
                for ( i=0; i<rawMaterialDetails.count;i++) {
                    
                    NSArray * itemArray = [successDictionary valueForKey:kSkuLists];
                    
                    
                    if (itemArray.count > 0) {
                        
                        NSDictionary * itemdic = itemArray[0];
                       
                        dic = rawMaterialDetails[i];
       
                        //if ([[itemdic allKeys] containsObject:TRACKING_REQUIRED] && ![[itemdic objectForKey:TRACKING_REQUIRED] isKindOfClass:[NSNull class]]) {
                        //
                        //if([[itemdic objectForKey:TRACKING_REQUIRED] boolValue]) {
                        //
                        //isTrackingRequired = true;
                        //}
                        //}
                        
                        
                            if ([[dic valueForKey:ITEM_SKU] isEqualToString:[itemdic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[itemdic valueForKey:PLU_CODE]] && (![[itemdic valueForKey:TRACKING_REQUIRED] boolValue])) {
                                
                                //setting supplied quantity....
                                [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kMaxQuantity] intValue] + 1] forKey:kMaxQuantity];
                                
                                [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kSupplied] intValue] + 1] forKey:kSupplied];
                                
                                //setting accepted quantity....
                                [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:ACCEPTED_QTY] intValue] + 1] forKey:ACCEPTED_QTY];
                                
                                //setting received quantity....
                                [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kReceived] intValue] + 1] forKey:kReceived];
                                
                                rawMaterialDetails[i] = dic;
                                
                                status = TRUE;
                                break;
                            }
                       
                    }
                }
                
                if (!status) {
                    
                    NSArray * itemArray = [successDictionary valueForKey:kSkuLists];
                    if (itemArray.count > 0) {
                        NSDictionary * itemdic = itemArray[0];
                        
                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc] init];
                        
                        //setting skuId....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                        
                        
                        //setting plucode....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PLU_CODE] defaultReturn:[itemDetailsDic valueForKey:ITEM_SKU]] forKey:PLU_CODE];
                        
                        //setting itemDescription....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                        
                        //setting itemPrice as salePrice...  SALE_PRICE .... costPrice
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:cost_Price] defaultReturn:@""] floatValue]] forKey:ITEM_UNIT_PRICE];
                        
                        //setting itemPrice as salePrice...  SALE_PRICE .... costPrice
                        // commented by roja
//                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:ITEM_UNIT_PRICE] floatValue]] forKey:iTEM_PRICE];
                        
                        //added by Srinivasulu on 18/04/2017.....
                        //setting this property eliminate the crash....
                        
                        [itemDetailsDic setValue:@"1" forKey:kSupplied];
                        
                        //upto here on 18/04/2017....
                        
                        //setting --------- quantity-----used as requested/indented Qty....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        
                        //setting supplied quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kSupplied];
                        
                        
                        //setting weighted quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:WEIGHTED_QTY];
                        
                        //setting accepted quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ACCEPTED_QTY];
                        
                        //setting received quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kReceived];
                        
                        //setting rejected quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kRejected];
                        
                        //added by Srinivasulu on 13/04/2017.....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductCategory] defaultReturn:@""] forKey:kProductCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductSubCategory] defaultReturn:@""] forKey:kProductSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductRange] defaultReturn:@""] forKey:kProductRange];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                        
                        //newly added keys....
                        //added by  Srinivasulu on  14/04/2017....
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        // commented by roja
//                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                        
//                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        //upto here on 13/04/2017.....
                        
                        //Newly Added Keys on 2/08/2017...By Bhargav as per the service modifications...
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
                        
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
                        
                        // commented by roja
//                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
                       
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
                        
                        // keys added by roja on 16-07-2018....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kPrimaryDepartment] defaultReturn:@""] forKey:kPrimaryDepartment];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SECONDARY_DEPARTMENT] defaultReturn:@""] forKey:SECONDARY_DEPARTMENT];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];

                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:TRACKING_REQUIRED] defaultReturn:@""] forKey:TRACKING_REQUIRED];
                        //     quantity
 
                        [rawMaterialDetails addObject:itemDetailsDic];
                        
                    }
                    cartTable.hidden = NO;
                }
            }
            
            [self calculateTotal];
        }
    }
    @catch (NSException * exception) {
        NSLog(@"---exception will reading.-------%@",exception);
    }
    @finally{
        [HUD setHidden:YES];
        [cartTable reloadData];
        
    }
}

/**
 * @description  in this method we will call the services....
 * @method       getSkuDetailsSuccessResponse
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By Srinivasulu on 13/04/2017...
 * @reason      added comments && added new field in items level....
 *
 */

- (void)getSkuDetailsErrorResponse:(NSString*)failureString {
    @try {
        
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@",failureString];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  handling the success response received from server side....
 * @date         03/04/2017
 * @method       getCategorySuccessResponse:
 * @author       Bhargav.v
 * @param        NSDictionary
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getCategoriesByLocationSuccessResponse:(NSDictionary *)sucessDictionary {
    @try {
        
        for (NSDictionary * categoryDic in [sucessDictionary valueForKey:CATEGORY_LIST]) {
            
            [categoriesArr addObject:categoryDic];
            [checkBoxArr addObject:@"0"];
            
        }
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@---exception in handling the response",exception);
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
        if(categoriesArr.count){
            [self displayCategoriesList:nil];
            [categoriesTbl reloadData];
            
        }
    }
}


/**
 * @description  handling the service call error resposne....
 * @date         03/04/2017
 * @method       getCategoryErrorResponse:
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)getCategoriesByLocationErrorResponse:(NSString*)errorResponse {
    
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2  verticalAxis:y_axis  msgType:@"" conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


-(void)getPriceListSkuDetailsSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        
        
        if (successDictionary != nil) {
            
            int  totalRecords = [[self checkGivenValueIsNullOrNil:[successDictionary valueForKey:TOTAL_SKUS]  defaultReturn:@"0"]intValue];

            
            for(NSDictionary * newSkuItemDic in [successDictionary valueForKey:SKU_LIST]){
                
                //checking priceList is existing or not....
                if([[newSkuItemDic valueForKey:SKU_PRICE_LIST] count]){
                    
                    for(NSDictionary * newSkuPriceListDic in [newSkuItemDic valueForKey:SKU_PRICE_LIST]){
                        
                        BOOL isExistingItem = false;
                        NSDictionary * existItemdic;
                        int i = 0;
                        
                        for ( i= 0; i < rawMaterialDetails.count; i++) {
                            
                            //reading the existing cartItem....
                            existItemdic = rawMaterialDetails[i];
                            
                            if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuPriceListDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuPriceListDic valueForKey:PLU_CODE]]) {
                                
                                [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                                
                                rawMaterialDetails[i] = existItemdic;
                                
                                isExistingItem = true;
                                
                                break;
                            }
                        }
                        
                        if(isExistingItem) {
                            
                            rawMaterialDetails[i] = existItemdic;
                            
                        }
                        else{
                            
                            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                            
                            [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                            
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:ITEM_UNIT_PRICE] defaultReturn:@""] forKey:iTEM_PRICE];
                            
                            //setting costPrice for price....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:cost_Price] defaultReturn:@""] floatValue]] forKey:ITEM_UNIT_PRICE];
                            
                            //setting weighted quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:WEIGHTED_QTY];
                            
                            //setting accepted quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ACCEPTED_QTY];
                            
                            //setting quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                            
                            //setting received quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kReceived];
                            
                            //setting rejected quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kRejected];
                            
                            //setting max_quantity quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                            
                            //setting supplied quantity....
                            [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kSupplied];
                            
                            //setting productRange....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                            
                            //setting measure Range....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                            
                            //setting Category....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kcategory] defaultReturn:@""] forKey:kcategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                            
                            //reading from superList....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                            
                            //Newly Added Keys on 2/08/2017...By Bhargav as per the service modifications...
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
                            
//                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
                            
                            // keys added by roja on 16-07-2018....
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:kPrimaryDepartment] defaultReturn:@""] forKey:kPrimaryDepartment];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:SECONDARY_DEPARTMENT] defaultReturn:@""] forKey:SECONDARY_DEPARTMENT];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
                            
                            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuPriceListDic valueForKey:TRACKING_REQUIRED] defaultReturn:@""] forKey:TRACKING_REQUIRED];
                            
                            [rawMaterialDetails addObject:itemDetailsDic];
                        }
                    }
                }
                else{
                    
                    BOOL isExistingItem = false;
                    NSDictionary * existItemdic;
                    int i = 0;
                    
                    for ( i=0; i < rawMaterialDetails.count; i++) {
                        
                        //reading the existing cartItem....
                        existItemdic = rawMaterialDetails[i];
                        
                        if ([[existItemdic valueForKey:ITEM_SKU] isEqualToString:[newSkuItemDic valueForKey:ITEM_SKU]] && [[existItemdic valueForKey:PLU_CODE] isEqualToString:[newSkuItemDic valueForKey:PLU_CODE]]) {
                            
                            [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                            
                            rawMaterialDetails[i] = existItemdic;
                            
                            isExistingItem = true;
                            
                            break;
                        }
                    }
                    
                    if(isExistingItem) {
                        
                        [existItemdic setValue:[NSString stringWithFormat:@"%d",[[existItemdic valueForKey:QUANTITY] intValue] + 1] forKey:QUANTITY];
                        
                        rawMaterialDetails[i] = existItemdic;
                    }
                    else{
                        
                        NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc ]init];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                        
                        [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:ITEM_UNIT_PRICE] defaultReturn:@""] forKey:iTEM_PRICE];
                        
                        //setting costPrice for price....
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:cost_Price] defaultReturn:@""] floatValue]] forKey:ITEM_UNIT_PRICE];
                        
                        //setting weighted quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:WEIGHTED_QTY];
                        
                        //setting accepted quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ACCEPTED_QTY];
                        
                        //setting quantity....
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                        
                        //setting received quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kReceived];
                        
                        //setting rejected quantity....
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kRejected];
                        
                        //setting max_quantity quantity....
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                        
                        //setting supplied quantity....
                        
                        [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kSupplied];
                        
                        //setting productRange....
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                        
                        //setting measure Range....
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                        
                        //setting Category....
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kcategory] defaultReturn:@""] forKey:kcategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic  valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                        
                        //reading from superList....
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                        
                        //Newly Added Keys on 2/08/2017...By Bhargav as per the service modifications...
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];
                        
                        [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[newSkuItemDic valueForKey:MODAL] defaultReturn:@""] forKey:MODAL];
                        
                        [rawMaterialDetails addObject:itemDetailsDic];
                    }
                }
            }
            
            float y_axis = self.view.frame.size.height - 120;
            
            if(searchItem.isEditing)
                y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
            
            NSString * mesg = [NSString stringWithFormat:@"%d%@",totalRecords,NSLocalizedString(@"records_are_added_to_the_cart_successfully", nil)];
            
            [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"cart_records", nil)  conentWidth:400 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];

            
            [self calculateTotal];
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        [HUD setHidden:YES];
        [cartTable reloadData];
        [categoriesPopOver dismissPopoverAnimated:YES];
        
    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getSkuDetailsFailureResponse:
 * @author       Bhargav Ram
 * @param       NSString
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getPriceListSKuDetailsErrorResponse:(NSString *)errorResponse {
    @try {
        
        [HUD setHidden:YES];
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden:YES];
        
    }
}

/**
 * @description  handling of stockIssues Id reponse
 * @date
 * @method       getStockIssueSuccessResponse:
 * @author
 * @param        NSDictionary
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 * @modified by Srinivasulu on 13/04/2017....
 * @reason       added commons
 *
 */

- (void)getStockIssueSuccessResponse:(NSDictionary *)sucessDictionary {
    @try {
        
        if ([businessFlow rangeOfString:WAREHOUSE options:NSCaseInsensitiveSearch].location == NSOrderedSame) {
            
            if ([sucessDictionary.allKeys containsObject:ISSUE_REF_LIST] && ![[sucessDictionary valueForKey:ISSUE_REF_LIST] isKindOfClass:[NSNull class]]) {
                
                
                for (NSString *issueIds in [sucessDictionary valueForKey:ISSUE_REF_LIST]) {
                    
                    [issueRefIdsArr addObject:issueIds];
                    
                }
            }
        }
        else {
            for(NSDictionary * receiptDic in [sucessDictionary valueForKey:ISSUE_IDS]) {
                [issueRefIdsArr addObject:[receiptDic valueForKey:kGoodsIssueRef]];
                
            }
        }
        totalNumberOfRecords = (int)[[sucessDictionary valueForKey:TOTAL_BILLS] integerValue];
        
        @try {
            
            if(issueRefIdsArr.count){
                float tableHeight = issueRefIdsArr.count * 40;
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    tableHeight = issueRefIdsArr.count * 33;
                
                if(issueRefIdsArr.count > 5)
                    tableHeight = (tableHeight/issueRefIdsArr.count) * 5;
                
                [self showPopUpForTables:issueRefIdTbl  popUpWidth:(issueRef.frame.size.width * 1.5)  popUpHeight:tableHeight presentPopUpAt:issueRef  showViewIn:createReceiptView];
            }
            else
                [catPopOver dismissPopoverAnimated:YES];
            
        } @catch (NSException *exception) {
            [HUD setHidden:YES];
            NSLog(@"----exception in the getStockIssue ----%@",exception);
            
            NSLog(@"------exception while creating the popUp in createReceiptView------%@",exception);
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
        [HUD setHidden: YES];
        [issueRefIdTbl reloadData];
    }
}

/**
 * @description  handling of stockIssues Id reponse
 * @date
 * @method       getStockIssueSuccessResponse:
 * @author
 * @param        NSDictionary
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 * @modified by Srinivasulu on 13/04/2017....
 * @reason       added commons
 *
 */

- (void)getStockIssueErrorResponse:(NSString *)error {
    @try {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/**
 * @description
 * @date
 * @method
 * @author
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 * @modified BY  Srinivasulu on 15/04//2017
 * @reason       added comments and cahnged the handling
 *
 */

- (void)getStockIssueIdSuccessResponse:(NSDictionary *)sucessDictionary {
    
    @try {
        
        NSString * key = kIssueDetails;
        if ([businessFlow rangeOfString:WAREHOUSE options:NSCaseInsensitiveSearch].location == NSOrderedSame) {
            
            key = WAREHOUSE_ISSUEDETAILS;
        }
        
        if ([sucessDictionary.allKeys containsObject: key] && [[sucessDictionary valueForKey:key] isKindOfClass:[NSDictionary class]] ) {
            
            NSDictionary * locDictionary = [sucessDictionary valueForKey:key ];
            
            if ([locDictionary.allKeys containsObject: DELIVERED_BY] && ![[locDictionary valueForKey:DELIVERED_BY] isKindOfClass:[NSNull class]]) {
                
                deliveredBy.text = [locDictionary valueForKey:DELIVERED_BY];
            }
            
            //if ([[locDictionary allKeys] containsObject: kShippedFrom] && ![[locDictionary valueForKey:kShippedFrom] isKindOfClass:[NSNull class]] ) {
            
            //location.text = [locDictionary valueForKey:kShippedFrom];
            //}
            
            
            if ([locDictionary.allKeys containsObject: kShipmentRef] && ![[locDictionary valueForKey:kShipmentRef] isKindOfClass:[NSNull class]] ) {
                
                //shipmentRefTxt.text = [locDictionary valueForKey:kShipmentRef];
            }
            
            if ([locDictionary.allKeys containsObject: kCreatedDateStr] && ![[locDictionary valueForKey:kCreatedDateStr] isKindOfClass:[NSNull class]] ) {
                date.text = [locDictionary valueForKey:kCreatedDateStr];
            }
            
            if ([locDictionary.allKeys containsObject: kShipmentMode] && ![[locDictionary valueForKey:kShipmentMode] isKindOfClass:[NSNull class]] ) {
                shipmentModeTxt.text = [locDictionary valueForKey:kShipmentMode];
            }
            
            // added by roja on 16-07-2018....
            if ([locDictionary.allKeys containsObject: kgoodsReqRef] && ![[locDictionary valueForKey:kgoodsReqRef] isKindOfClass:[NSNull class]] ) {
                requestRefTxt.text = [locDictionary valueForKey:kgoodsReqRef];
            }
            if ([locDictionary.allKeys containsObject: kShippedFrom] && ![[locDictionary valueForKey:kShippedFrom] isKindOfClass:[NSNull class]] ) {
                toOutletTxt.text = [locDictionary valueForKey:kShippedFrom];
            }
        }
        
        
        
        for (NSDictionary * dic in [sucessDictionary valueForKey:kItemDetails]) {
            
            
            NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"] forKey:iTEM_PRICE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_UNIT_PRICE] defaultReturn:@"0.00"] forKey:ITEM_UNIT_PRICE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kItem] defaultReturn:@""] forKey:kItem];
            
            //populating the quantities into textFields....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] forKey:QUANTITY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] forKey:kMaxQuantity];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] forKey:kSupplied];
            
            [itemDetailsDic setValue:[itemDetailsDic valueForKey:kSupplied] forKey:WEIGHTED_QTY];
            
            [itemDetailsDic setValue:[itemDetailsDic valueForKey:kSupplied] forKey:ACCEPTED_QTY];
            
            [itemDetailsDic setValue:[itemDetailsDic valueForKey:kSupplied] forKey:kReceived];
            
            [itemDetailsDic setValue:@"0.00" forKey:kRejected];
            
            //added by  Srinivasulu on  14/04/2017....
            //newly added keys....
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kBrand] defaultReturn:@""] forKey:kBrand];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
            
            //upto here on 13/04/2017.....
            
            //Recently added by Bhargav
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kItemDept] defaultReturn:@""] forKey:kItemDept];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:EAN] defaultReturn:@""] forKey:EAN];

//            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MODEL] defaultReturn:@""] forKey:MODAL];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SECTION] defaultReturn:@""] forKey:SECTION];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kSubCategory] defaultReturn:@""] forKey:kSubCategory];

            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kItemSubDept] defaultReturn:@""] forKey:kItemSubDept];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];

            // keys added by roja on 16-07-2018....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrimaryDepartment] defaultReturn:@""] forKey:kPrimaryDepartment];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SECONDARY_DEPARTMENT] defaultReturn:@""] forKey:SECONDARY_DEPARTMENT];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
            
            [rawMaterialDetails addObject:itemDetailsDic];
        }
        
        [self calculateTotal];
        [cartTable reloadData];
        
        
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
    
}

- (void)getStockIssueIdErrorResponse:(NSString *)error {
    
    @try {
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@",error];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @catch (NSException *exception) {
        
    }
}


-(void)createStockReceiptSuccessResponse:(NSDictionary *)successDictionary {
    
    @try {
        [HUD setHidden:YES];
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
        y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_receipt_generated_successfully",nil),@"\n", [successDictionary valueForKey:RECEIPT_ID]];

        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 450)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:450 contentHeight:60  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [HUD setHidden:YES];
    }
}

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 */

-(void)createStockReceiptErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
        y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        
        NSString * mesg = [NSString stringWithFormat:@"%@",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 450)/2  verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:600 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:1];
    }
    @catch (NSException * exception) {
        
    }
    @finally {
        
    }
}



/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       upDateStockReceiptSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)upDateStockReceiptSuccessResponse:(NSDictionary *)successDictionary {
    @try {
        [HUD setHidden:YES];
        
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"stock_receipt_updated_successfully", nil),@"\n",@""];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 450)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"SUCCESS", nil)  conentWidth:450 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:3];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       upDateStockReceiptErrorResponse:
 * @author       Bhargav Ram
 * @param        NSString
 * @return
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)upDateStockReceiptErrorResponse:(NSString *)errorResponse {
    
    @try {
        [HUD setHidden:YES];
        
        //changed By srinivauslu on 02/05/2018....
        //reason.. Need to stop user internation after servcie calls...
        
        submitBtn.userInteractionEnabled = YES;
        saveBtn.userInteractionEnabled = YES;
        
        //upto here on 02/05/2018....
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 450)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:450 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:3];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}



/**
 * @description  here we are handling the resposne received from services.......
 * @date         20/0/2016
 * @method       getStockReceiptDetailsSuccessResponse:
 * @author       Bhargav Ram
 * @param        NSDictionary
 * @param
 * @return
 * @return
 * @verified By
 * @verified On
 */

-(void)getStockReceiptDetailsSuccessResponse:(NSDictionary *)successDictionary{
    @try {
        
        
        isDraft = true;
        
        stockReceiptDic = [NSMutableDictionary new];
        
        stockReceiptDic = [[successDictionary valueForKey:ITEM_DETAILS][0]mutableCopy];
        
        NSDictionary * details =[successDictionary valueForKey:kReceipt];
        
        if ([[details valueForKey:kGoodsReceiptRef] isEqualToString:receiptId]) {
            
            [receiptId copy];
        }
       
        if ([details.allKeys containsObject:kgoodsReqRef] && ![[details valueForKey:kgoodsReqRef] isKindOfClass:[NSNull class]]) {
          
            requestRefTxt.text = [details valueForKey:kgoodsReqRef];
        }
        
        if ([details.allKeys containsObject:DELIVERY_DATE] && ![[details valueForKey:DELIVERY_DATE] isKindOfClass:[NSNull class]]) {
            date.text = [details valueForKey:DELIVERY_DATE];
        }
        
        if ([details.allKeys containsObject:kShippedFrom] && ![[details valueForKey:kShippedFrom] isKindOfClass:[NSNull class]]) {
            toOutletTxt.text = [details valueForKey:kShippedFrom];
        }
        
        if ([details.allKeys containsObject:RECEIVED_by] && ![[details valueForKey:RECEIVED_by] isKindOfClass:[NSNull class]]) {
            receivedByTxt.text = [details valueForKey:RECEIVED_by];
        }
        
        if ([details.allKeys containsObject:DELIVERED_BY] && ![[details valueForKey:DELIVERED_BY] isKindOfClass:[NSNull class]]) {
            
            deliveredBy.text = [details valueForKey:DELIVERED_BY];
        }
        
        if ([details.allKeys containsObject:INSPECTED_BY] && ![[details valueForKey:INSPECTED_BY] isKindOfClass:[NSNull class]]) {
            inspectedBy.text = [details valueForKey:INSPECTED_BY];
        }
        
        if ([details.allKeys containsObject:kShipmentMode] && ![[details valueForKey:kShipmentMode] isKindOfClass:[NSNull class]]) {
            shipmentModeTxt.text = [details valueForKey:kShipmentMode];
        }
        
        if ([details.allKeys containsObject:kIssueReferenceNo] && ![[details valueForKey:kIssueReferenceNo] isKindOfClass:[NSNull class]]) {
            issueRef.text = [details valueForKey:kIssueReferenceNo];
        }
        
        if ([details.allKeys containsObject:STATUS] && ![[details valueForKey:STATUS] isKindOfClass:[NSNull class]]) {
            
            presentStatus = [[details valueForKey:STATUS]copy];
        }
        
        for (NSDictionary * dic in [successDictionary valueForKey:ITEM_DETAILS]) {
            
            NSMutableDictionary * itemDetailsDic = [[NSMutableDictionary alloc]init];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PLU_CODE] defaultReturn:@""] forKey:PLU_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"] forKey:iTEM_PRICE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"] forKey:kPrice];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kItem] defaultReturn:@""] forKey:kItem];
            
            //added by Srinivasulu on 18/04/2017.....
            //setting this property eliminate the crash....
            //setting --------- quantity-----used as requested/indented Qty....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"] forKey:QUANTITY];
            
            //setting supplied quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kMaxQuantity] defaultReturn:@"0.00"] forKey:kMaxQuantity];
            
            //setting supplied quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kSupplied] defaultReturn:@"0.00"] forKey:kSupplied];
            
            //setting weighted quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:WEIGHTED_QTY] defaultReturn:@"0.00"] forKey:WEIGHTED_QTY];
            
            //setting accepted quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ACCEPTED_QTY] defaultReturn:@"0.00"] forKey:ACCEPTED_QTY];
            
            //setting received quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kReceived] defaultReturn:@"0.00"] forKey:kReceived];
            
            //setting rejected quantity....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kRejected] defaultReturn:@"0.00"] forKey:kRejected];
            
            //upto here on 18/04/2017....
            
            //[itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kSNo] defaultReturn:@"1"] forKey:kSNo];
            
            
            //newly added keys....
            //added by  Srinivasulu on  14/04/2017....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
            
            // keys added by roja on 16-07-2018....
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrimaryDepartment] defaultReturn:@""] forKey:kPrimaryDepartment];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:SECONDARY_DEPARTMENT] defaultReturn:@""] forKey:SECONDARY_DEPARTMENT];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:UTILITY] defaultReturn:@""] forKey:UTILITY];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_SCAN_CODE] defaultReturn:@""] forKey:ITEM_SCAN_CODE];
            
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:TRACKING_REQUIRED] defaultReturn:ZERO_CONSTANT] forKey:TRACKING_REQUIRED];
            
            // added by roja
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:EAN] defaultReturn:@""] forKey:EAN];
            [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[dic valueForKey:MAKE] defaultReturn:@""] forKey:MAKE];

            
            //upto here on 13/04/2017.....
            
            [rawMaterialDetails addObject:itemDetailsDic];
        }
        
        [self calculateTotal];

    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [cartTable reloadData];
        [HUD setHidden:YES];
    }
}





/**
 * @description  here we are handling the error response from the service.......
 * @date         21/09/2016
 * @method       getStockReceiptDetailsErrorResponse
 * @author       Srinivasulu
 * @param        NSString
 * @param
 * @return
 *
 * @modified BY
 * @reason
 *
 * @return
 * @verified By
 * @verified On
 *
 */



-(void)getStockReceiptDetailsErrorResponse:(NSString *)errorResponse {
    @try {
        
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        if(searchItem.isEditing)
            y_axis = searchItem.frame.origin.y + searchItem.frame.size.height;
        
        NSString *mesg = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"alert", nil),@"\n",errorResponse];
        
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 300)/2   verticalAxis:y_axis  msgType:NSLocalizedString(@"warning", nil)  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}


/**
 * @description  here we are calculating the Totalprice of order..........
 * @date         27/09/2016
 * @method       calculateTotal
 * @author       Srinivasulu
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)calculateTotal{
    
    @try {
        float reqQuantity = 0;
        float issueQty    = 0;
        float wighedQty   = 0;
        float aceptedQty  = 0;
        float rejectedQty = 0;
        
        for(NSDictionary * dic in rawMaterialDetails){
            
            reqQuantity += [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]floatValue];
            issueQty    += [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY] defaultReturn:@"0.00"]floatValue];
            wighedQty   += [[self checkGivenValueIsNullOrNil:[dic valueForKey:WEIGHTED_QTY] defaultReturn:@"0.00"]floatValue];
            aceptedQty  += [[self checkGivenValueIsNullOrNil:[dic valueForKey:ACCEPTED_QTY] defaultReturn:@"0.00"]floatValue];
            rejectedQty += ([[dic valueForKey:WEIGHTED_QTY] floatValue] - [[dic valueForKey:ACCEPTED_QTY] floatValue]);
        }
        
        requestQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",reqQuantity];
        issueQtyValueLbl.text    = [NSString stringWithFormat:@"%@%.2f",@"",issueQty];
        weighedQtyValueLbl.text  = [NSString stringWithFormat:@"%@%.2f",@"",wighedQty];
        acceptedQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",aceptedQty];
        rejectedQtyValueLbl.text = [NSString stringWithFormat:@"%@%.2f",@"",rejectedQty];
        
    } @catch (NSException * exception) {
        
        NSLog(@"---exception in while calculating the totalValue--%@",exception);
        
    } @finally {
        
    }
}


/**
 * @description  Navigating to the home Page By by clicking on the cancel Button..
 * @date
 * @method       cancelButtonPressed
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)cancelButtonPressed:(UIButton *)sender {
    @try {
        
        //Play Audio for button touch....
        AudioServicesPlaySystemSound (soundFileObject);
        
        [self backAction];
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

#pragma -mark action used in displaying the calender in popUp....

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)DateButtonPressed:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        pickView = [[UIView alloc] init];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            pickView.frame = CGRectMake( 15, date.frame.origin.y+date.frame.size.height, 320, 320);
            
        }
        else{
            pickView.frame = CGRectMake(0, 0, 320, 460);
        }
        
        pickView.backgroundColor = [UIColor colorWithRed:(119/255.0) green:(136/255.0) blue:(153/255.0) alpha:0.8f];
        pickView.layer.masksToBounds = YES;
        pickView.layer.cornerRadius = 12.0f;
        
        //pickerframe creation...
        CGRect pickerFrame = CGRectMake(0,50,0,0);
        myPicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
        
        //Current Date...
        NSDate *now = [NSDate date];
        [myPicker setDate:now animated:YES];
        myPicker.backgroundColor = [UIColor whiteColor];
        
        //        myPicker.datePickerMode = UIDatePickerModeTime;
        
        UIButton  *pickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [pickButton setBackgroundImage:[UIImage imageNamed:@"ok2.png"] forState:UIControlStateNormal];
        
        
        //        pickButton.backgroundColor = [UIColor grayColor];
        
        //        pickButton.backgroundColor = [UIColor clearColor];
        pickButton.layer.masksToBounds = YES;
        [pickButton addTarget:self action:@selector(populateDateToTextField:) forControlEvents:UIControlEventTouchUpInside];
        //        pickButton.layer.borderColor = [UIColor blackColor].CGColor;
        //        pickButton.layer.borderWidth = 0.5f;
        //        pickButton.layer.cornerRadius = 12;
        pickButton.tag = sender.tag;
        [customView addSubview:myPicker];
        [customView addSubview:pickButton];
        
        
        //added by srinivasulu on 02/02/2017....
        
        UIButton  *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [clearButton setBackgroundImage:[UIImage imageNamed:@"Clear.png"] forState:UIControlStateNormal];
        
        
        //        pickButton.backgroundColor = [UIColor grayColor];
        
        
        
        //        clearButton.backgroundColor = [UIColor clearColor];
        clearButton.layer.masksToBounds = YES;
        [clearButton addTarget:self action:@selector(clearDate:) forControlEvents:UIControlEventTouchUpInside];
        //        clearButton.layer.borderColor = [UIColor blackColor].CGColor;
        //        clearButton.layer.borderWidth = 0.5f;
        //        clearButton.layer.cornerRadius = 12;
        clearButton.tag = sender.tag;
        [customView addSubview:clearButton];
        
        
        
        
        //        pickButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
        //        clearButton.frame = CGRectMake( (customView.frame.size.width / 2) - (100/2), 269, 100, 45);
        
        pickButton.frame = CGRectMake( ((customView.frame.size.width - 230)/ 3), 270, 110, 45);
        clearButton.frame = CGRectMake( pickButton.frame.origin.x + pickButton.frame.size.width + ((customView.frame.size.width - 200)/ 3), pickButton.frame.origin.y, pickButton.frame.size.width, pickButton.frame.size.height);
        
        //upto here on 02/02/2017....
        
        customerInfoPopUp.view = customView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:date.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
        }
        
        else {
            
            //            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            catPopOver = popover;
            
        }
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
        
    } @catch (NSException *exception) {
        
        NSLog(@"----exception in the stockReceiptView in showCalenderInPopUp:----%@",exception);
        NSLog(@"------exception while creating the popUp in stockView------%@",exception);
        
    }
}

-(void)clearDate:(UIButton *)sender{
    //    BOOL callServices = false;
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        [catPopOver dismissPopoverAnimated:YES];
        
        if((date.text).length){
            
            date.text = @"";
            
        }
        
        
    } @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        NSLog(@"---- exception in StockReceiptView -- in  -- clearDate() ----");
        NSLog(@"---- exception is ----%@",exception);
        
    } @finally {
        
    }
    
}
/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)populateDateToTextField:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [catPopOver dismissPopoverAnimated:YES];
        
        //Date Formate Setting...
        NSDateFormatter *requiredDateFormat = [[NSDateFormatter alloc] init];
        //        [requiredDateFormat setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        requiredDateFormat.dateFormat = @"dd/MM/yyyy";
        dateString = [requiredDateFormat stringFromDate:myPicker.date];
        
        //NSDate * selectedDateString = [requiredDateFormat dateFromString:[requiredDateFormat stringFromDate:myPicker.date]];
        
        NSDate *existingDateString;
        /*z;
         UITextField *endDateTxt;*/
        
        if ((date.text).length != 0 && ( ![date.text isEqualToString:@""])){
            existingDateString = [requiredDateFormat dateFromString:date.text ];
            
        }
        date.text = dateString;
        
    } @catch (NSException *exception) {
        
    }
    @finally{
    }
    
}


#pragma mark textField delegates:

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By  Srinivasulu on 31/05/2017....
 * @reason       added new field and changed the code....
 */

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.frame.origin.x == weightedQtyTxt.frame.origin.x || textField.frame.origin.x == acceptedQtyTxt.frame.origin.x||textField.frame.origin.x == rejectedQtyTxt.frame.origin.x);
    
    reloadTableData = false;
    
    return YES;
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By  Srinivasulu on 31/05/2017....
 * @reason       added new field and changed the code....
 *
 */

-(void)textFieldDidBeginEditing:(UITextField *)textField {
   
    @try {
        
        @try {
            
            if(textField == searchItem){
                
                offSetViewTo = 120;
            }
            
            else if (textField.frame.origin.x == weightedQtyTxt.frame.origin.x || textField.frame.origin.x == acceptedQtyTxt.frame.origin.x||textField.frame.origin.x == rejectedQtyTxt.frame.origin.x ) {
                
                reloadTableData = true;
                
                offSetViewTo = 140;
            }
            
            [self keyboardWillShow];
            
        } @catch (NSException *exception) {
            
        }
        
    } @catch (NSException *exception) {
        
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 *
 * @modified By  Srinivasulu on 31/05/2017....
 * @reason       added new field and changed the code....
 *
 */

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.frame.origin.x == weightedQtyTxt.frame.origin.x || textField.frame.origin.x == acceptedQtyTxt.frame.origin.x||textField.frame.origin.x == rejectedQtyTxt.frame.origin.x ) {
        
        @try {
            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            NSString *expression = @"^[0-9]*((\\.)[0-9]{0,2})?$";
            NSError *error = nil;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, newString.length)];
            return numberOfMatches != 0;
        } @catch (NSException *exception) {
            
            NSLog(@"-- exception in texField: shouldChangeCharactersInRange:replalcement----%@",exception);
            
            return  YES;
        }
    }
    return  YES;
    
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By  Srinivasulu on 31/05/2017....
 * @reason       added new field and changed the code....
 */

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField == searchItem) {
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                if (searchItem.tag == 0) {
                    
                    searchItem.tag = (textField.text).length;
                    
                    productListArr = [[NSMutableArray alloc]init];
                    
                    [self callRawMaterials:textField.text];
                }
                
                else {
                    
                    [HUD setHidden:YES];
                    [catPopOver dismissPopoverAnimated:YES];
                }
                
            } @catch (NSException *exception) {
                
            }
        }
        
        else {
            [HUD setHidden:YES];
            searchItem.tag = 0;
            
            [catPopOver dismissPopoverAnimated:YES];
        }
    }
    
    else if (textField == issueRef) {
        
        if ((textField.text).length >= 3) {
            
            @try {
                
                issueRefIdsArr = [NSMutableArray new];
                
                if ([businessFlow rangeOfString:WAREHOUSE options:NSCaseInsensitiveSearch].location == NSOrderedSame) {
                    
                    [self getStockIssuesFromWarehouse];
                }
                else {
                    [self getStockIssuesFromOutlet];
                }
            }
            @catch (NSException * exception) {
                
            }
            @finally {
                
            }
        }
    }
    
    else if(textField.frame.origin.x == weightedQtyTxt.frame.origin.x){
        
        @try {
            NSString * qtyKey = WEIGHTED_QTY;
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
        }
        @finally {
        }
    }
    
    else if(textField.frame.origin.x == acceptedQtyTxt.frame.origin.x){
        
        @try {
            NSString * qtyKey = ACCEPTED_QTY;
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            [temp setValue:textField.text  forKey:qtyKey];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    else if (textField.frame.origin.x == rejectedQtyTxt.frame.origin.x) {
        
        @try {
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            [temp setValue:textField.text  forKey:kReceived];
            
            [temp setValue:[NSString stringWithFormat:@"%.2f", ( (textField.text).floatValue - [[temp valueForKey:ACCEPTED_QTY] floatValue] )] forKey:kRejected];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
        
        }
    }
}

/**
 * @description  it is an textFieldDelegate method it will be executed when text Begin edititng........
 * @date         10/09/2016
 * @method       textFieldDidBeginEditing:
 * @author       Bhargav Ram
 * @param        UITextField
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 * @modified By  Srinivasulu on 31/05/2017....
 * @reason       added new field and changed the code....
 *
 */

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self keyboardWillHide];
    offSetViewTo = 0;
    
      if (textField.frame.origin.x == weightedQtyTxt.frame.origin.x) {
        
        @try {
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            [temp setValue:textField.text  forKey:WEIGHTED_QTY];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        
        @catch (NSException *exception) {
            NSLog(@"----%@",exception);
        }
        @finally {
            if(reloadTableData)
            [cartTable reloadData];
            [self calculateTotal];
            
        }
    }
    
    else if (textField.frame.origin.x == acceptedQtyTxt.frame.origin.x){
        
        @try {
            
            NSMutableDictionary *temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            [temp setValue:textField.text  forKey:ACCEPTED_QTY];
            
            
            [temp setValue:[NSString stringWithFormat:@"%.2f", ([[temp valueForKey:kReceived] floatValue] - (textField.text).floatValue)] forKey:kRejected];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
        }
        @finally {
            if(reloadTableData)
            [cartTable reloadData];
            [self calculateTotal];
        }
    }
    
    else if (textField.frame.origin.x == rejectedQtyTxt.frame.origin.x){
        
        @try {
            
            NSMutableDictionary * temp = [rawMaterialDetails[textField.tag]  mutableCopy];
            
            [temp setValue:textField.text  forKey:kReceived];
            
            [temp setValue:[NSString stringWithFormat:@"%.2f", ( (textField.text).floatValue - [[temp valueForKey:ACCEPTED_QTY] floatValue] )] forKey:kRejected];
            
            rawMaterialDetails[textField.tag] = temp;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            if(reloadTableData)
            [cartTable reloadData];
            [self calculateTotal];
        }
    }
}

/**
 * @description  It is tableFieldDelegates Method. It will executed when user started entering input....
 * @date         29/05/2016
 * @method       textFieldShouldBeginEditing:
 * @author       Bhargav
 * @param        UITextField
 * @param
 * @return       BOOL
 * @verified By
 * @verified On
 *
 */

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark end of TextField Delegates

/**
 * @description  method to move the view up/down whenever the keyboard is shown/dismissed
 * @date         04/06/2016
 * @method       setViewMovedUp
 * @author       Bhargav
 * @param        BOOL
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

#pragma mark key board methods:

-(void)setViewMovedUp:(BOOL)movedUp {
    
    @try {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3]; // if you want to slide up the view
        CGRect rect = self.view.frame;
        
        // CGRect rect = scrollView.frame;
        
        if (movedUp)
        {
            //1. move the view's origin up so that the text field that will be hidden come above the keyboard
            rect.origin.y = (rect.origin.y -(rect.origin.y + offSetViewTo));
        }
        else
        {
            // revert back to the normal state.
            rect.origin.y +=  offSetViewTo;
        }
        self.view.frame = rect;
        //   scrollView.frame = rect;
        
        [UIView commitAnimations];
        
        /* offSetViewTo = 80;
         [self keyboardWillShow];*/
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    } @finally {
        
    }
}


/**
 * @description  called when keyboard is displayed
 * @date         04/06/2016
 * @method       keyboardWillShow
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillShow {
    // Animate the current view out of the way
    @try {
        [self setViewMovedUp:YES];
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
    }
}

/**
 * @description  called when keyboard is dismissed
 * @date         04/06/2016
 * @method       keyboardWillHide
 * @author       Bhargav
 * @param
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)keyboardWillHide {
    @try {
        [self setViewMovedUp:NO];
        
    } @catch (NSException *exception) {
        NSLog(@"-------exception while changing frame self.view---------%@",exception);
        
    }
}


#pragma mark TableView Delegates..
/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (tableView == cartTable || tableView == skListTable || tableView == issueRefIdTbl || tableView == shipModeTable || tableView == categoriesTbl ||tableView == priceTable) {
        
        return 40;
    }
    else
        
    return 40;
}


/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == cartTable) {
 
        return  rawMaterialDetails.count;
    }
    else if (tableView == skListTable){
        return productListArr.count;
    }
    else if (tableView == issueRefIdTbl){
        return issueRefIdsArr.count;
    }
    else if (tableView == shipModeTable){
        return shipModesArr.count;
    }
    else if (tableView == locationTable) {
        return locationArr.count;
    }
    else if (tableView == priceTable) {
        return priceDic.count;
    }
    else if (tableView == categoriesTbl ) {
        
        return categoriesArr.count;
    }
    return false;
}

/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == skListTable) {
        
        //changed by Bhargav.v  on 12/2/2018....
        UITableViewCell * hlcell;
        
        @try {
            
            static NSString * hlCellID = @"hlCellID";
            
            hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
            
            if ((hlcell.contentView).subviews){
                
                for (UIView *subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
                hlcell.accessoryType = UITableViewCellAccessoryNone;
            }
            tableView.separatorColor = [UIColor clearColor];
            
            //  NSDictionary *dic = [priceDic objectAtIndex:indexPath.row];
            
            UILabel * itemDescLbl;
            UILabel * itemPriceLbl;
            UILabel * itemQtyInHandLbl;
            UILabel * itemColorLbl;
            UILabel * itemSizeLbl;
            UILabel * itemMeasurementLbl;
            
            itemDescLbl = [[UILabel alloc] init] ;
            itemDescLbl.layer.borderWidth = 1.5;
            itemDescLbl.font = [UIFont systemFontOfSize:13.0];
            itemDescLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemDescLbl.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemDescLbl.textColor = [UIColor blackColor];
            itemDescLbl.textAlignment=NSTextAlignmentLeft;
            
            itemPriceLbl = [[UILabel alloc] init] ;
            itemPriceLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemPriceLbl.layer.borderWidth = 1.5;
            itemPriceLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemPriceLbl.textAlignment = NSTextAlignmentCenter;
            itemPriceLbl.numberOfLines = 2;
            itemPriceLbl.textColor = [UIColor blackColor];
            
            itemQtyInHandLbl = [[UILabel alloc] init] ;
            itemQtyInHandLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemQtyInHandLbl.layer.borderWidth = 1.5;
            itemQtyInHandLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemQtyInHandLbl.textAlignment = NSTextAlignmentCenter;
            itemQtyInHandLbl.numberOfLines = 2;
            itemQtyInHandLbl.textColor = [UIColor blackColor];
            
            itemColorLbl = [[UILabel alloc] init] ;
            itemColorLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemColorLbl.layer.borderWidth = 1.5;
            itemColorLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemColorLbl.textAlignment = NSTextAlignmentCenter;
            itemColorLbl.numberOfLines = 2;
            itemColorLbl.textColor = [UIColor blackColor];
            
            itemSizeLbl = [[UILabel alloc] init] ;
            itemSizeLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemSizeLbl.layer.borderWidth = 1.5;
            itemSizeLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemSizeLbl.textAlignment = NSTextAlignmentCenter;
            itemSizeLbl.numberOfLines = 2;
            itemSizeLbl.textColor = [UIColor blackColor];
            
            itemMeasurementLbl = [[UILabel alloc] init] ;
            itemMeasurementLbl.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            itemMeasurementLbl.layer.borderWidth = 1.5;
            itemMeasurementLbl.backgroundColor =[UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
            itemMeasurementLbl.textAlignment = NSTextAlignmentCenter;
            itemMeasurementLbl.numberOfLines = 2;
            itemMeasurementLbl.textColor = [UIColor blackColor];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (productListArr.count > indexPath.row){
                NSDictionary * dic = productListArr[indexPath.row];
                
                
                if([dic isKindOfClass:[NSDictionary class]]){
                    
                    itemDescLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:ITEM_DESCRIPTION] defaultReturn:@"--"];
                    itemPriceLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:kPrice] defaultReturn:@"0.00"] floatValue]];
                    
                    itemQtyInHandLbl.text = [NSString stringWithFormat:@"%.2f", [[self checkGivenValueIsNullOrNil:[dic valueForKey:QUANTITY_IN_HAND] defaultReturn:@"0.00"] floatValue]];
                    itemColorLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:COLOR] defaultReturn:@"--"];
                    itemSizeLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:SIZE] defaultReturn:@""];
                    itemMeasurementLbl.text = [self checkGivenValueIsNullOrNil:[dic valueForKey:MEASUREMENT_RANGE] defaultReturn:@""];
                }
            }
            
            
            else {
                
                itemDescLbl.text = @"";
                itemPriceLbl.text = @"";
                itemQtyInHandLbl.text = @"";
                itemColorLbl.text = @"";
                itemSizeLbl.text = @"";
                itemMeasurementLbl.text = @"";
            }
            
            if(!(itemQtyInHandLbl.text).length)
                itemQtyInHandLbl.text = @"--";
            if(!(itemColorLbl.text).length)
                itemColorLbl.text = @"--";
            if(!(itemSizeLbl.text).length)
                itemSizeLbl.text = @"--";
            if(!(itemMeasurementLbl.text).length)
                itemMeasurementLbl.text = @"--";
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                itemDescLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemPriceLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemQtyInHandLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemColorLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemSizeLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                itemMeasurementLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                }
                else {
                    
                }
                
                itemDescLbl.frame = CGRectMake(0, 0, 300, 50);
                itemPriceLbl.frame = CGRectMake( itemDescLbl.frame.origin.x + itemDescLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemQtyInHandLbl.frame = CGRectMake( itemPriceLbl.frame.origin.x + itemPriceLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemColorLbl.frame = CGRectMake( itemQtyInHandLbl.frame.origin.x + itemQtyInHandLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemSizeLbl.frame = CGRectMake( itemColorLbl.frame.origin.x + itemColorLbl.frame.size.width, 0, 100, itemDescLbl.frame.size.height);
                itemMeasurementLbl.frame = CGRectMake( itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width, 0, searchItem.frame.size.width - (itemSizeLbl.frame.origin.x + itemSizeLbl.frame.size.width), itemDescLbl.frame.size.height);
            }
            else {
                
                itemDescLbl.frame = CGRectMake(5, 0, 130, 34);
                itemPriceLbl.frame = CGRectMake(135, 0, 70, 34);
            }
            
            
            //[hlcell setBackgroundColor:[UIColor clearColor]];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemPriceLbl];
            [hlcell.contentView addSubview:itemQtyInHandLbl];
            [hlcell.contentView addSubview:itemColorLbl];
            [hlcell.contentView addSubview:itemSizeLbl];
            [hlcell.contentView addSubview:itemMeasurementLbl];
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
        }
        @finally{
            
            return hlcell;
        }
    }
    
    else if (tableView == cartTable) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        CAGradientLayer *layer_1;
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
            
            @try {
                layer_1 = [CAGradientLayer layer];
                layer_1.colors = @[(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor];
                
                layer_1.frame = CGRectMake(sNoLbl.frame.origin.x, hlcell.frame.size.height - 2,actionLbl.frame.origin.x+actionLbl.frame.size.width-(sNoLbl.frame.origin.x), 1);
                
                [hlcell.contentView.layer addSublayer:layer_1];
                
            } @catch (NSException *exception) {
                
            }
        }
        
        @try {
            
            //labels used in table row....
            UILabel * itemNoLbl;
            UILabel * itemSkuIdLbl;
            UILabel * itemDescLbl;
            UILabel * itemUomLbl;
            UILabel * requested_QtyLbl;
            UILabel * issueQty_Lbl;
            
            //UIButtons used as subviews in cell....
            UIButton * delrowbtn;
            UIButton * moreBtn;
            
            itemNoLbl = [[UILabel alloc] init];
            itemNoLbl.backgroundColor = [UIColor clearColor];
            itemNoLbl.layer.borderWidth = 0;
            itemNoLbl.textAlignment = NSTextAlignmentCenter;
            itemNoLbl.numberOfLines = 2;
            itemNoLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemSkuIdLbl = [[UILabel alloc] init];
            itemSkuIdLbl.backgroundColor = [UIColor clearColor];
            itemSkuIdLbl.layer.borderWidth = 0;
            itemSkuIdLbl.textAlignment = NSTextAlignmentCenter;
            itemSkuIdLbl.numberOfLines = 1;
            itemSkuIdLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemDescLbl = [[UILabel alloc] init];
            itemDescLbl.backgroundColor = [UIColor clearColor];
            itemDescLbl.layer.borderWidth = 0;
            itemDescLbl.textAlignment = NSTextAlignmentCenter;
            itemDescLbl.numberOfLines = 1;
            itemDescLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            itemUomLbl = [[UILabel alloc] init];
            itemUomLbl.backgroundColor = [UIColor clearColor];
            itemUomLbl.layer.borderWidth = 0;
            itemUomLbl.textAlignment = NSTextAlignmentCenter;
            itemUomLbl.numberOfLines = 1;
            itemUomLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            requested_QtyLbl = [[UILabel alloc] init];
            requested_QtyLbl.backgroundColor = [UIColor clearColor];
            requested_QtyLbl.layer.borderWidth = 0;
            requested_QtyLbl.textAlignment = NSTextAlignmentCenter;
            requested_QtyLbl.numberOfLines = 1;
            requested_QtyLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            issueQty_Lbl = [[UILabel alloc] init];
            issueQty_Lbl.backgroundColor = [UIColor clearColor];
            issueQty_Lbl.layer.borderWidth = 0;
            issueQty_Lbl.textAlignment = NSTextAlignmentCenter;
            issueQty_Lbl.numberOfLines = 1;
            issueQty_Lbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            weightedQtyTxt = [[UITextField alloc] init];
            weightedQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            weightedQtyTxt.textColor = [UIColor blackColor];
            weightedQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            weightedQtyTxt.layer.borderWidth = 2;
            weightedQtyTxt.textAlignment = NSTextAlignmentCenter;
            weightedQtyTxt.backgroundColor = [UIColor clearColor];
            weightedQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            weightedQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            weightedQtyTxt.returnKeyType = UIReturnKeyDone;
            weightedQtyTxt.tag = indexPath.row;
            
            weightedQtyTxt.delegate = self;
            [weightedQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            acceptedQtyTxt = [[UITextField alloc] init];
            acceptedQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            acceptedQtyTxt.textColor = [UIColor blackColor];
            acceptedQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            acceptedQtyTxt.layer.borderWidth = 2;
            acceptedQtyTxt.textAlignment = NSTextAlignmentCenter;
            acceptedQtyTxt.backgroundColor = [UIColor clearColor];
            acceptedQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            acceptedQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            acceptedQtyTxt.returnKeyType = UIReturnKeyDone;
            acceptedQtyTxt.tag = indexPath.row;
            acceptedQtyTxt.delegate = self;
            [acceptedQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            rejectedQtyTxt = [[UITextField alloc] init];
            rejectedQtyTxt.borderStyle = UITextBorderStyleRoundedRect;
            rejectedQtyTxt.textColor = [UIColor blackColor];
            rejectedQtyTxt.keyboardType = UIKeyboardTypeNumberPad;
            rejectedQtyTxt.layer.borderWidth = 2;
            rejectedQtyTxt.textAlignment = NSTextAlignmentCenter;
            rejectedQtyTxt.backgroundColor = [UIColor clearColor];
            rejectedQtyTxt.autocorrectionType = UITextAutocorrectionTypeNo;
            rejectedQtyTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
            rejectedQtyTxt.returnKeyType = UIReturnKeyDone;
            rejectedQtyTxt.tag = indexPath.row;
            rejectedQtyTxt.delegate = self;
            [rejectedQtyTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            
            moreBtn = [[UIButton alloc] init];
            // moreBtn.backgroundColor = [UIColor blackColor];
            moreBtn.titleLabel.textColor = [UIColor whiteColor];
            moreBtn.userInteractionEnabled = YES;
            moreBtn.tag = indexPath.row;
            [moreBtn addTarget:self action:@selector(showMoreInfoPopUp:) forControlEvents:UIControlEventTouchUpInside];
            
            delrowbtn = [[UIButton alloc] init];
            [delrowbtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
            [delrowbtn addTarget:self action:@selector(delRow:) forControlEvents:UIControlEventTouchUpInside];
            delrowbtn.tag = indexPath.row;
            delrowbtn.backgroundColor = [UIColor clearColor];
            
            itemNoLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemSkuIdLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemDescLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            itemUomLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            requested_QtyLbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            issueQty_Lbl.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            weightedQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            acceptedQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            rejectedQtyTxt.layer.borderColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0].CGColor;
            
            
            itemNoLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemSkuIdLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemDescLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            itemUomLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            requested_QtyLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            issueQty_Lbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            weightedQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            acceptedQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            rejectedQtyTxt.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
            
            //added by Srinivasulu on 27/05/2017....
            
            [moreBtn setTitleColor:[UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:204.0/255.0 alpha:1.0]forState:UIControlStateNormal];
            
            //upto here on 27/05/2017....
            
            
            [hlcell.contentView addSubview:itemNoLbl];
            [hlcell.contentView addSubview:itemSkuIdLbl];
            [hlcell.contentView addSubview:itemDescLbl];
            [hlcell.contentView addSubview:itemUomLbl];
            [hlcell.contentView addSubview:requested_QtyLbl];
            [hlcell.contentView addSubview:issueQty_Lbl];
            [hlcell.contentView addSubview:weightedQtyTxt];
            [hlcell.contentView addSubview:acceptedQtyTxt];
            [hlcell.contentView addSubview:rejectedQtyTxt];
            
            //added by Srinivasulu on 27/05/2017....
            [hlcell.contentView addSubview:moreBtn];
            
            [hlcell.contentView addSubview:delrowbtn];
            
            //upto here on 27/05/2017....
            
            //setting frame and font........
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                itemNoLbl.frame = CGRectMake(sNoLbl.frame.origin.x, 0, sNoLbl.frame.size.width, hlcell.frame.size.height);
                
                itemSkuIdLbl.frame = CGRectMake(sKuidLbl.frame.origin.x, 0, sKuidLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemDescLbl.frame = CGRectMake(descLbl.frame.origin.x, 0, descLbl.frame.size.width,  hlcell.frame.size.height);
                
                itemUomLbl.frame = CGRectMake(uomLbl.frame.origin.x, 0,uomLbl.frame.size.width,  hlcell.frame.size.height);
                
                requested_QtyLbl.frame = CGRectMake(requestedQtyLbl.frame.origin.x, 0,requestedQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                issueQty_Lbl.frame = CGRectMake(issuedQtyLbl.frame.origin.x, 0,issuedQtyLbl.frame.size.width,  hlcell.frame.size.height);
                
                weightedQtyTxt.frame = CGRectMake(weightedQtyLbl.frame.origin.x,2,weightedQtyLbl.frame.size.width - 2,36);
                
                acceptedQtyTxt.frame = CGRectMake(acceptedQtyLbl.frame.origin.x,2,acceptedQtyLbl.frame.size.width - 2,36);
                
                rejectedQtyTxt.frame = CGRectMake(rejectedQtyLbl.frame.origin.x,2,rejectedQtyLbl.frame.size.width - 2,36);
                
                moreBtn.frame =CGRectMake(actionLbl.frame.origin.x,0,actionLbl.frame.size.width-45,40);
                
                delrowbtn.frame =CGRectMake(actionLbl.frame.origin.x + actionLbl.frame.size.width-45,5,35,35);
              
                [WebServiceUtility setFontFamily:TEXT_FONT_NAME forView:hlcell andSubViews:YES fontSize:16.0f cornerRadius:0];
            }
            else{
                
            }
            
            @try {
                
                [moreBtn setTitle:NSLocalizedString(@"more", nil) forState:UIControlStateNormal];
                
                if(rawMaterialDetails.count > indexPath.row){
                    
                    NSMutableDictionary * temp = [rawMaterialDetails[indexPath.row] mutableCopy];
                    
                    itemNoLbl.text = [NSString stringWithFormat:@"%i",(int)(indexPath.row + 1) ];
                    itemSkuIdLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_SKU]  defaultReturn:@""];
                    
                    
                    itemDescLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_DESCRIPTION]  defaultReturn:@""];
                    
                    itemUomLbl.text = [self checkGivenValueIsNullOrNil:[temp valueForKey:SELL_UOM]  defaultReturn:@""];
                    
                    //                    commented as per the UIModifications..
                    //                    itemPriceLbl.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:ITEM_UNIT_PRICE]  defaultReturn:@"0.00"] floatValue])];
                    
                    
                    //                    populating the quantities into textFields....
                    requested_QtyLbl.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY]  defaultReturn:@"0.00"] floatValue])];
                    
                    issueQty_Lbl.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:QUANTITY]  defaultReturn:@"0.00"] floatValue])];
                    
                    weightedQtyTxt.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:WEIGHTED_QTY]  defaultReturn:@"0.00"] floatValue])];
                    
                    acceptedQtyTxt.text = [NSString stringWithFormat:@"%.2f",([[self checkGivenValueIsNullOrNil:[temp valueForKey:ACCEPTED_QTY]  defaultReturn:@"0.00"] floatValue])];
                    
                    rejectedQtyTxt.text = [NSString stringWithFormat:@"%.2f",(weightedQtyTxt.text).floatValue - (acceptedQtyTxt.text).floatValue];
                    
                    temp[kRejected] = [NSString stringWithFormat:@"%.2f", ((acceptedQtyTxt.text).floatValue - (receivedQtyTxt.text).floatValue)];
                    
                    rawMaterialDetails[indexPath.row] = temp;
                }
            }
            @catch (NSException * exception) {
                
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
        }
    }

    
    else if (tableView == priceTable) {
        
        static NSString *hlCellID = @"hlCellID";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
        
        if ((hlcell.contentView).subviews){
            
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        tableView.separatorColor = [UIColor clearColor];
        @try {
            [HUD setHidden:YES];
            NSDictionary *dic = priceDic[indexPath.row];
            
            UILabel *skid = [[UILabel alloc] init] ;
            skid.layer.borderWidth = 1.5;
            skid.font = [UIFont systemFontOfSize:13.0];
            skid.font = [UIFont fontWithName:TEXT_FONT_NAME size:13];
            skid.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            skid.backgroundColor = [UIColor blackColor];
            skid.textColor = [UIColor whiteColor];
            skid.text = [dic valueForKey:kDescription];
            skid.textAlignment=NSTextAlignmentCenter;
            //            skid.adjustsFontSizeToFitWidth = YES;
            
            UILabel *mrpPrice = [[UILabel alloc] init] ;
            mrpPrice.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            mrpPrice.layer.borderWidth = 1.5;
            mrpPrice.backgroundColor = [UIColor blackColor];
            mrpPrice.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:SALE_PRICE] floatValue]];
            mrpPrice.textAlignment = NSTextAlignmentCenter;
            mrpPrice.numberOfLines = 2;
            mrpPrice.textColor = [UIColor whiteColor];
            
            UILabel *price = [[UILabel alloc] init] ;
            price.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
            price.layer.borderWidth = 1.5;
            price.backgroundColor = [UIColor blackColor];
            price.text = [NSString stringWithFormat:@"%.2f",[[dic valueForKey:kPrice] floatValue]];
            price.textAlignment = NSTextAlignmentCenter;
            price.numberOfLines = 2;
            price.textColor = [UIColor whiteColor];
            // name.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:12];
            
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            hlcell.backgroundColor = [UIColor clearColor];
            [hlcell.contentView addSubview:skid];
            [hlcell.contentView addSubview:price];
            [hlcell.contentView addSubview:mrpPrice];
            
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                if (currentOrientation == UIDeviceOrientationLandscapeRight || currentOrientation == UIDeviceOrientationLandscapeLeft) {
                    
                    
                    skid.frame = CGRectMake( 0, 0, descLabl.frame.size.width + 1, hlcell.frame.size.height);
                    
                    skid.font = [UIFont systemFontOfSize:22];
                    
                    mrpPrice.frame = CGRectMake(skid.frame.origin.x + skid.frame.size.width, 0, mrpLbl.frame.size.width + 2,  hlcell.frame.size.height);
                    
                    mrpPrice.font = [UIFont systemFontOfSize:22];
                    
                    price.font = [UIFont systemFontOfSize:22];
                    price.frame = CGRectMake(mrpPrice.frame.origin.x + mrpPrice.frame.size.width, 0, priceLbl.frame.size.width+2, hlcell.frame.size.height);
                }
            }
            
            
        }
        @catch (NSException *exception) {
            
            NSLog(@"%@",exception);
            
        }
        @finally {
            
        }
        return hlcell;
    }
    
    else if (tableView == issueRefIdTbl) {
        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (hlcell == nil) {
            hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            hlcell.frame = CGRectZero;
        }
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        hlcell.textLabel.text = issueRefIdsArr[indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

        return hlcell;
    }
    
    else if (tableView == shipModeTable){
        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (hlcell == nil) {
            hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            hlcell.frame = CGRectZero;
        }
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        hlcell.textLabel.text = shipModesArr[indexPath.row];
        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];

        return hlcell;
    }
    
    else if (tableView == locationTable){
        
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *hlcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (hlcell == nil) {
            hlcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            hlcell.frame = CGRectZero;
        }
        
        if ((hlcell.contentView).subviews){
            for (UIView *subview in (hlcell.contentView).subviews) {
                [subview removeFromSuperview];
            }
        }
        
        if(hlcell == nil) {
            hlcell =  [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            hlcell.accessoryType = UITableViewCellAccessoryNone;
        }
        
//        @try {
//            NSString * businessFlowStr = @"";
//            
//            if ([[[locationArr objectAtIndex:indexPath.row] allKeys] containsObject:BUSSINESS_ACTIVITY] && ![[[locationArr objectAtIndex:indexPath.row] valueForKey:BUSSINESS_ACTIVITY] isKindOfClass:[NSNull class]]) {
//                
//                businessFlowStr = [[locationArr objectAtIndex:indexPath.row] valueForKey:BUSSINESS_ACTIVITY];
//            }
//            
//            hlcell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",[[locationArr objectAtIndex:indexPath.row] valueForKey:LOCATION_ID],businessFlowStr];
//        }
//        @catch (NSException *exception) {
//            
//        }
        
        hlcell.textLabel.text  = locationArr[indexPath.row];

        hlcell.textLabel.textColor = [UIColor blackColor];
        hlcell.textLabel.font = [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
        
        return hlcell;
    }
    
    else if (tableView == categoriesTbl) {
        @try {
            
            static NSString * hlCellID = @"hlCellID";
            UITableViewCell * hlcell = [tableView dequeueReusableCellWithIdentifier:hlCellID];
            
            
            if ((hlcell.contentView).subviews){
                
                for (UIView * subview in (hlcell.contentView).subviews) {
                    [subview removeFromSuperview];
                }
            }
            
            if(hlcell == nil) {
                hlcell =  [[UITableViewCell alloc]
                           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hlCellID] ;
                hlcell.accessoryType = UITableViewCellAccessoryNone;
            }
            tableView.separatorColor = [UIColor clearColor];
            
            checkBoxsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage * checkBoxImg =  [UIImage imageNamed:@"checkbox_off_background.png"];
            [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            
            
            if( checkBoxArr.count && categoriesArr.count){
                if([checkBoxArr[indexPath.row] integerValue])
                    checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                checkBoxsBtn.userInteractionEnabled = YES;
            }
            
            [checkBoxsBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
            checkBoxsBtn.tag = indexPath.row;
            
            [checkBoxsBtn addTarget:self action:@selector(changeCheckBoxImages:) forControlEvents:UIControlEventTouchUpInside];
            
            [hlcell.contentView addSubview:checkBoxsBtn];
            
            checkBoxsBtn.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x, 7, 30 , 30);
            
            //upto here on 07/03/2017....
            
            UILabel * categoryLbl = [[UILabel alloc] init];
            categoryLbl.backgroundColor = [UIColor clearColor];
            categoryLbl.numberOfLines = 1;
            categoryLbl.lineBreakMode = NSLineBreakByWordWrapping;
            
            categoryLbl.textColor = [UIColor colorWithRed:72.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                
                
                categoryLbl.font =  [UIFont fontWithName:TEXT_FONT_NAME size:16.0f];
                categoryLbl.frame = CGRectMake(checkBoxsBtn.frame.origin.x+checkBoxsBtn.frame.size.width+15, checkBoxsBtn.frame.origin.y-5,280,40);
            }
            
            categoryLbl.textAlignment = NSTextAlignmentLeft;
            categoryLbl.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
            
            [hlcell.contentView addSubview:checkBoxsBtn];
            [hlcell.contentView addSubview:categoryLbl];
            
            @try {
                
                if( categoriesArr.count > indexPath.row){
                    categoryLbl.text  = categoriesArr[indexPath.row];
                    
                }
                
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            
            hlcell.backgroundColor = [UIColor clearColor];
            hlcell.selectionStyle = UITableViewCellSelectionStyleNone;
            return hlcell;
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);

    //dismissing the catPopOver.......
    [catPopOver dismissPopoverAnimated:YES];
    
    if (tableView == skListTable) {
        
        //Changes Made Bhargav.v on 11/05/2018...
        //Changed The Parameter to Plucode While sending the RequestString to SkuDetails...
        //Reason:Making the plucode Search instead of searching skuid to avoid Price List...
        
        NSDictionary * detailsDic = productListArr[indexPath.row];
        
        NSString * inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[SKUID]];
        
        if (([detailsDic.allKeys containsObject:PLU_CODE]) && (![[detailsDic valueForKey:PLU_CODE] isKindOfClass:[NSNull class]])) {
            
            inputServiceStr = [NSString stringWithFormat:@"%@",detailsDic[PLU_CODE]];
        }
        
        [self callRawMaterialDetails:inputServiceStr];
        
        searchItem.text = @"";
        [searchItem resignFirstResponder];
    }
        
    else if (tableView == issueRefIdTbl) {
        @try {
            issueRef.text = issueRefIdsArr[indexPath.row];
            [catPopOver dismissPopoverAnimated:YES];
            if([businessFlow rangeOfString:@"warehouse" options:NSCaseInsensitiveSearch].location == NSOrderedSame) {
                
                [self getWarehouseIssueDetails:issueRefIdsArr[indexPath.row]];
                
            }
            else {
                [self callingIssueIdDetails:issueRefIdsArr[indexPath.row]];
            }
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    else if (tableView == shipModeTable) {
        
        shipmentModeTxt.text = shipModesArr[indexPath.row];
        [catPopOver dismissPopoverAnimated:YES];
        
    }
    else if (tableView == locationTable) {
        
        [catPopOver dismissPopoverAnimated:YES];
        
//        NSString * businessFlowStr = @"";
//        
//        if ([[[locationArr objectAtIndex:indexPath.row] allKeys] containsObject:BUSSINESS_ACTIVITY] && ![[[locationArr objectAtIndex:indexPath.row] valueForKey:BUSSINESS_ACTIVITY] isKindOfClass:[NSNull class]]) {
//            
//            businessFlowStr = [[locationArr objectAtIndex:indexPath.row] valueForKey:BUSSINESS_ACTIVITY];
//            
//            businessFlow = [businessFlowStr copy];
//        }
//        
//        if (location.tag ==2) {
//            
//            location.text = [NSString stringWithFormat:@"%@",[[locationArr objectAtIndex:indexPath.row] valueForKey:LOCATION_ID]];
//        }
//        else {
//            
//            toOutletTxt.text = [NSString stringWithFormat:@"%@",[[locationArr objectAtIndex:indexPath.row] valueForKey:LOCATION_ID]];
//        }
        
        if ([locationArr[indexPath.row] isEqualToString:NSLocalizedString(@"all_outlets",nil)]) {
            
            toOutletTxt.text = @"";
        }
        else
            toOutletTxt.text  = locationArr[indexPath.row];

        
    }
    else if (tableView == priceTable) {
        
        //added by Srinivasulu on 14/04/2017....
        //added exception handling....
        @try {
            
            transparentView.hidden = YES;
            
            NSDictionary *detailsDic = priceDic[indexPath.row];
            
            
            BOOL status = FALSE;
            
            int i=0;
            NSMutableDictionary *dic;
            
            for ( i=0; i<rawMaterialDetails.count;i++) {
                
                dic = rawMaterialDetails[i];
                if ([[dic valueForKey:ITEM_SKU] isEqualToString:[detailsDic valueForKey:ITEM_SKU]] && [[dic valueForKey:PLU_CODE] isEqualToString:[detailsDic valueForKey:PLU_CODE]]) {
                    
                    //setting supplied quantity....
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kMaxQuantity] intValue] + 1] forKey:kMaxQuantity];
                    
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kSupplied] intValue] + 1] forKey:kSupplied];
                    
                    //setting accepted quantity....
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:ACCEPTED_QTY] intValue] + 1] forKey:ACCEPTED_QTY];
                    
                    //setting received quantity....
                    [dic setValue:[NSString stringWithFormat:@"%d",[[dic valueForKey:kReceived] intValue] + 1] forKey:kReceived];
                    
                    
                    rawMaterialDetails[i] = dic;
                    
                    status = TRUE;
                    break;
                }
            }
            
            if (!status) {
                NSDictionary *itemdic = detailsDic;
                
                NSMutableDictionary *itemDetailsDic = [[NSMutableDictionary alloc] init];
                
                //setting skuId....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_SKU] defaultReturn:@""] forKey:ITEM_SKU];
                
                [itemDetailsDic setValue:[itemDetailsDic valueForKey:ITEM_SKU] forKey:kItem];
                
                
                //setting plucode....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PLU_CODE] defaultReturn:[itemDetailsDic valueForKey:ITEM_SKU]] forKey:PLU_CODE];
                
                //setting itemDescription....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_DESCRIPTION] defaultReturn:@""] forKey:ITEM_DESCRIPTION];
                
                //setting itemPrice as salePrice...  SALE_PRICE .... costPrice
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[self checkGivenValueIsNullOrNil:[itemdic valueForKey:cost_Price] defaultReturn:@""] floatValue]] forKey:ITEM_UNIT_PRICE];
                
                //setting itemPrice as salePrice...  SALE_PRICE .... costPrice
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%.2f",[[itemdic valueForKey:ITEM_UNIT_PRICE] floatValue]] forKey:iTEM_PRICE];
                
                
                //setting --------- quantity-----used as requested/indented Qty....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:QUANTITY];
                
                //setting supplied quantity....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kMaxQuantity];
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kSupplied];
                
                //added by Srinivasulu on 18/04/2017.....
                //setting this property eliminate the crash....
                
                [itemDetailsDic setValue:@"1" forKey:kSupplied];
                
                //upto here on 18/04/2017....
                
                //setting weighted quantity....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:WEIGHTED_QTY];
                
                //setting accepted quantity....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:ACCEPTED_QTY];
                
                //setting received quantity....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",1] forKey:kReceived];
                
                //setting rejected quantity....
                [itemDetailsDic setValue:[NSString stringWithFormat:@"%d",0] forKey:kRejected];
                
                
                //added by Srinivasulu on 13/04/2017.....
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductSubCategory] defaultReturn:@""] forKey:kProductSubCategory];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductRange] defaultReturn:@""] forKey:kProductRange];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:kMeasureRange];
                
                //newly added keys....
                //added by  Srinivasulu on  14/04/2017....
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:COLOR] defaultReturn:@""] forKey:COLOR];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SIZE] defaultReturn:@""] forKey:SIZE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:PRODUCT_RANGE] defaultReturn:@""] forKey:PRODUCT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kMeasureRange] defaultReturn:@""] forKey:MEASUREMENT_RANGE];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:ITEM_CATEGORY] defaultReturn:@""] forKey:ITEM_CATEGORY];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:kProductBrand] defaultReturn:@""] forKey:kBrand];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:MODEL] defaultReturn:@""] forKey:MODEL];
                
                [itemDetailsDic setValue:[self checkGivenValueIsNullOrNil:[itemdic valueForKey:SELL_UOM] defaultReturn:@""] forKey:SELL_UOM];
                
                //upto here on 13/04/2017.....
                
                [rawMaterialDetails addObject:itemDetailsDic];
            }
            
            else
            rawMaterialDetails[i] = dic;
            
            cartTable.hidden = NO;
            
            [cartTable reloadData];
            
            [self calculateTotal];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
}

#pragma -mark action used ot del items from row....



/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)delRow:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        
        if(rawMaterialDetails.count >= sender.tag){
            
            [rawMaterialDetails removeObjectAtIndex:sender.tag];
            [cartTable reloadData];
        }
        
        [self calculateTotal];
        
    } @catch (NSException *exception) {
        NSLog(@"%li",(long)sender.tag);
    } @finally {
        
    }
}

/**
 * @description  here we are calling the showMOreInfoPopUP:
 * @date         27/05/2017....
 * @method       showMoreInfoPopUp:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)showMoreInfoPopUp:(UIButton *)sender{
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}

#pragma -mark reusableMethods.......
/**
 * @description  Displaying th PopUp's and reloading table if popUp is vissiable.....
 * @date         21/09/2016
 * @method       showPopUpForTables:-- popUpWidth:-- popUpHeight:-- presentPopUpAt:-- showViewIn:--
 * @author       Srinivasulu
 * @param        UITableView
 * @param        float
 * @param        float
 * @param        id
 * @param        id
 * @return
 * @verified By
 * @verified On
 *
 */


-(void)showPopUpForTables:(UITableView *)tableName   popUpWidth:(float)width popUpHeight:(float)height  presentPopUpAt:(id)displayFrame  showViewIn:(id)view {
    
    @try {
        
        if ( catPopOver.popoverVisible && (tableName.frame.size.height > height) ){
            catPopOver.popoverContentSize =  CGSizeMake(width, height);
            
            [tableName reloadData];
            return;
            
        }
        
        if(catPopOver.popoverVisible)
        [catPopOver dismissPopoverAnimated:YES];
        
        
        UITextView *textView = displayFrame;
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        
        UIView *customView = [[UIView alloc] initWithFrame:CGRectMake( 0.0, 0.0, width, height)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        
        //        tableName = [[UITableView alloc]init];
        tableName.layer.borderWidth = 1.0;
        tableName.layer.cornerRadius = 10.0;
        tableName.bounces = FALSE;
        tableName.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        tableName.layer.borderColor = [UIColor blackColor].CGColor;
        tableName.dataSource = self;
        tableName.delegate = self;
        tableName.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        tableName.hidden = NO;
        tableName.frame = CGRectMake(0.0, 0.0, customView.frame.size.width, customView.frame.size.height);
        [customView addSubview:tableName];
        [tableName reloadData];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            [popover presentPopoverFromRect:textView.frame inView:view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
            
        }
        
        else {
            
            customerInfoPopUp.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            // popover.contentViewController.view.alpha = 0.0;
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            catPopOver = popover;
            
        }
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        [tableName reloadData];
        
    }
    
}


/**
 * @description  <#description#>
 * @date         <#date#>
 * @method       <#name#>
 * @author       Bhargav.v
 * @param        <#param#>
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)getShipmentModes:(UIButton*)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    shipModesArr = [NSMutableArray new];
    [shipModesArr addObject:NSLocalizedString(@"rail", nil) ];
    [shipModesArr addObject:NSLocalizedString(@"flight", nil) ];
    [shipModesArr addObject:NSLocalizedString(@"express", nil) ];
    [shipModesArr addObject:NSLocalizedString(@"ordinary", nil) ];
    
    
    int count  = 5 ;
    
    if (shipModesArr.count < count) {
        count = (int)shipModesArr.count;
    }
    
    PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, shipmentModeTxt.frame.size.width *1.5,count * 40)];
    customView.opaque = NO;
    customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
    customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    customView.layer.borderWidth = 2.0f;
    [customView setHidden:NO];
    
    shipModeTable = [[UITableView alloc] init];
    shipModeTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
    shipModeTable.dataSource = self;
    shipModeTable.delegate = self;
    (shipModeTable.layer).borderWidth = 1.0f;
    shipModeTable.layer.cornerRadius = 3;
    shipModeTable.layer.borderColor = [UIColor grayColor].CGColor;
    shipModeTable.separatorColor = [UIColor grayColor];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        shipModeTable.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
        
    }
    
    [customView addSubview:shipModeTable];
    
    customerInfoPopUp.view = customView;
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        
        [popover presentPopoverFromRect:shipmentModeTxt.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        catPopOver= popover;
    }
    
    else {
        
        customerInfoPopUp.preferredContentSize = CGSizeMake(160.0, 250.0);
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
        // popover.contentViewController.view.alpha = 0.0;
        popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        catPopOver = popover;
    }
    
    UIGraphicsBeginImageContext(customView.frame.size);
    [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    customView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [shipModeTable reloadData];
    
}


#pragma -mark method used to display alert/warning messages....

/**
 * @description  adding the  alertMessage's based on input
 * @date         15/03/2017
 * @method       displayAlertMessage
 * @author       Srinivasulu
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

-(void)displayAlertMessage:(NSString *)message    horizontialAxis:(float)xPostion  verticalAxis:(float)yPosition msgType:(NSString *)messageType   conentWidth:(float )labelWidth contentHeight:(float)labelHeight   isSoundRequired:(BOOL)soundStatus  timming:(float)noOfSecondsToDisplay    noOfLines:(int)noOfLines{
    
    
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
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            if(searchItem.isEditing)
            yPosition = searchItem.frame.origin.y + searchItem.frame.size.height;
            
            
            userAlertMessageLbl.frame = CGRectMake(xPostion, yPosition, labelWidth, labelHeight);
            
        }
        else{
            if (version > 8.0) {
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                
            }
            else{
                userAlertMessageLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:14];
                userAlertMessageLbl.frame = CGRectMake(xPostion + 75, yPosition-35, 200, 30);
                
            }
            
        }
        
        [self.view addSubview:userAlertMessageLbl];
        fadeOutTime = [NSTimer scheduledTimerWithTimeInterval:noOfSecondsToDisplay target:self selector:@selector(removeAlertMessages) userInfo:nil repeats:NO];
        
    }
    @catch (NSException * exception) {
        [HUD setHidden:YES];
        
        NSLog(@"--------exception in the stockReceiptView in displayAlertMessage---------%@",exception);
        NSLog(@"----exception while creating the useralertMesssageLbl------------%@",exception);
        
    }
}

/*
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
        
        NSLog(@"--------exception in the CreateReceiptView in removeAlertMessages---------%@",exception);
        NSLog(@"----exception in removing userAlertMessageLbl label------------%@",exception);
        
    }
    
}



/**
 * @description  here we are checking whether the object is null or not
 * @date         16/12/2016
 * @method       checkGivenValueIsNullOrNil
 * @author       bhargav
 * @param
 * @param
 * @return
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

-(void)populateLocationsTable:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        int count = 5;
        
        location.tag = sender.tag;

        
        if(locationArr == nil || locationArr.count==0){
            [self getLocations];
            
        }
        
        PopOverViewController  *customerInfoPopUp = [[PopOverViewController alloc] init];
        UIView * customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, location.frame.size.width * 1.5, count * 40)];
        customView.opaque = NO;
        customView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        customView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        customView.layer.borderWidth = 2.0f;
        [customView setHidden:NO];
        
        locationTable = [[UITableView alloc] init];
        locationTable.backgroundColor = [UIColor colorWithRed:0.92f green:0.929f blue:0.929f alpha:1.0];
        locationTable.dataSource = self;
        locationTable.delegate = self;
        (locationTable.layer).borderWidth = 1.0f;
        locationTable.layer.cornerRadius = 3;
        locationTable.layer.borderColor = [UIColor grayColor].CGColor;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            locationTable.frame = CGRectMake(0, 0, customView.frame.size.width, customView.frame.size.height);
            
        }
        
        [customView addSubview:locationTable];
        
        customerInfoPopUp.view = customView;
        
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            customerInfoPopUp.preferredContentSize =  CGSizeMake(customView.frame.size.width, customView.frame.size.height);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            
            if(sender.tag == 2)
                [popover presentPopoverFromRect:location.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            else
                [popover presentPopoverFromRect:toOutletTxt.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            
            catPopOver= popover;
        }
        
        else {
            
            customerInfoPopUp.preferredContentSize = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:customerInfoPopUp];
            popover.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            [popover presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            catPopOver = popover;
        }
        
        UIGraphicsBeginImageContext(customView.frame.size);
        [[UIImage imageNamed:@"CustomerView.png"] drawInRect:customView.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        customView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        [locationTable reloadData];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


/**
 * @description  this method is used to get Categories List...
 * @date         11/09/2016
 * @method       validatingCategoriesList
 * @author       Bhargav Ram
 * @param        UIButton
 * @return
 *
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)validatingCategoriesList:(UIButton *)sender {
    @try {
        
        
        if(((categoriesArr == nil)  && (!categoriesArr.count))){
            
            [self callingCategoriesList];
        }
        else {
            
            [self displayCategoriesList:nil];
            [categoriesTbl reloadData];
        }
    }
    @catch (NSException *exception) {
        
        [HUD setHidden:YES];
        
        float y_axis = self.view.frame.size.height - 120;
        
        NSString * mesg = [NSString stringWithFormat:@"%@",NSLocalizedString(@"unable_to_process_your_request", nil)];
        
        [self displayAlertMessage:mesg horizontialAxis:(self.view.frame.size.width - 360)/2   verticalAxis:y_axis  msgType:@""  conentWidth:300 contentHeight:40  isSoundRequired:YES timming:2.0 noOfLines:2];
    }
    @finally {
        [HUD setHidden:YES];
        
    }
}


/**
 * @description        here we are displaying the popOver for the CategoriesList ...
 * @requestDteFld      27/09/2016
 * @method             displayCategoriesList
 * @author             Bhargav.v
 * @param              UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)displayCategoriesList:(UIButton*)sender  {
    
    AudioServicesPlaySystemSound(soundFileObject);
    
    @try {
        
        PopOverViewController * categoriesPopover = [[PopOverViewController alloc] init];
        
        categoriesView = [[UIView alloc] initWithFrame:CGRectMake(selectCategoriesBtn.frame.origin.x,searchItem.frame.origin.y,300,350)];
        categoriesView.opaque = NO;
        categoriesView.backgroundColor = [UIColor blackColor];
        categoriesView.layer.borderColor = [[UIColor whiteColor]colorWithAlphaComponent:0.6].CGColor;
        categoriesView.layer.borderWidth =2.0f;
        [categoriesView setHidden:NO];
        
        /*Creation of UILabel for headerDisplay.......*/
        //creating line  UILabel which will display at topOfThe  billingView.......
        
        UILabel  * headerNameLbl;
        CALayer  * bottomBorder;
        UIImage  * checkBoxImg;
        UILabel  * selectAllLbl;
        UIButton * okButton;
        UIButton * cancelBtn;
        
        headerNameLbl = [[UILabel alloc] init];
        headerNameLbl.layer.cornerRadius = 10.0f;
        headerNameLbl.layer.masksToBounds = YES;
        headerNameLbl.text = NSLocalizedString(@"categories_list", nil);
        headerNameLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:20.0f];
        
        headerNameLbl.textAlignment = NSTextAlignmentCenter;
        headerNameLbl.textColor = [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0];
        headerNameLbl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Gradient.png"]];
        
        //it is regard's to the view borderwidth and color setting....
        bottomBorder = [CALayer layer];
        bottomBorder.opacity = 5.0f;
        bottomBorder.backgroundColor = [UIColor grayColor].CGColor;
        bottomBorder.frame = CGRectMake(0.0f, 60.0f, headerNameLbl.frame.size.width, 1.0f);
        [headerNameLbl.layer addSublayer:bottomBorder];
        
        /*Creation of table header's*/
        selectAllCheckBoxBtn = [[UIButton alloc] init];
        checkBoxImg = [UIImage imageNamed:@"checkbox_off_background.png"];
        
        selectAllCheckBoxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
        [selectAllCheckBoxBtn addTarget:self
                                 action:@selector(changeSelectAllCheckBoxButtonImage:) forControlEvents:UIControlEventTouchDown];
        selectAllCheckBoxBtn.tag = 2;
        
        selectAllLbl = [[UILabel alloc] init];
        selectAllLbl.layer.cornerRadius = 10.0f;
        selectAllLbl.layer.masksToBounds = YES;
        selectAllLbl.text = NSLocalizedString(@"select_all", nil);
        selectAllLbl.font = [UIFont fontWithName:TEXT_FONT_NAME size:18.0f];
        selectAllLbl.textAlignment = NSTextAlignmentCenter;
        selectAllLbl.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        
        //creation of Product menu  table...
        categoriesTbl = [[UITableView alloc] init];
        categoriesTbl.backgroundColor  = [UIColor blackColor];
        categoriesTbl.layer.cornerRadius = 4.0;
        categoriesTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        categoriesTbl.dataSource = self;
        categoriesTbl.delegate = self;
        
        okButton = [[UIButton alloc] init] ;
        [okButton setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
        okButton.backgroundColor = [UIColor grayColor];
        okButton.layer.masksToBounds = YES;
        okButton.userInteractionEnabled = YES;
        okButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        okButton.layer.cornerRadius = 5.0f;
        [okButton addTarget:self action:@selector(multipleCategriesSelection:) forControlEvents:UIControlEventTouchDown];
        
        
        
        cancelBtn = [[UIButton alloc] init] ;
        [cancelBtn setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
        cancelBtn.backgroundColor = [UIColor grayColor];
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.userInteractionEnabled = YES;
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        cancelBtn.layer.cornerRadius = 5.0f;
        [cancelBtn addTarget:self action:@selector(dismissCategoryPopOver:) forControlEvents:UIControlEventTouchDown];
        
        [categoriesView addSubview:headerNameLbl];
        [categoriesView addSubview:selectAllLbl];
        [categoriesView addSubview:selectAllCheckBoxBtn];
        [categoriesView addSubview:categoriesTbl];
        [categoriesView addSubview:okButton];
        [categoriesView addSubview:cancelBtn];

        
        headerNameLbl.frame = CGRectMake(0,0,categoriesView.frame.size.width,50);
        
        selectAllCheckBoxBtn.frame = CGRectMake(10,headerNameLbl.frame.origin.y+headerNameLbl.frame.size.height+10,30,30);
        
        selectAllLbl.frame = CGRectMake(selectAllCheckBoxBtn.frame.origin.x+selectAllCheckBoxBtn.frame.size.width+10,selectAllCheckBoxBtn.frame.origin.y-5,95,40);
        
        categoriesTbl.frame = CGRectMake(0,selectAllCheckBoxBtn.frame.origin.y+selectAllCheckBoxBtn.frame.size.height+10,categoriesView.frame.size.width,200);
        
        okButton.frame = CGRectMake(selectAllLbl.frame.origin.x,categoriesTbl.frame.origin.y+categoriesTbl.frame.size.height+5,100,40);
        cancelBtn.frame = CGRectMake(okButton.frame.origin.x+okButton.frame.size.width+20,categoriesTbl.frame.origin.y+categoriesTbl.frame.size.height+5,100,40);
        
        categoriesPopover.view = categoriesView;
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            categoriesPopover.preferredContentSize =  CGSizeMake(categoriesView.frame.size.width, categoriesView.frame.size.height);
            
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:categoriesPopover];
            
            [popOver presentPopoverFromRect:selectCategoriesBtn.frame inView:createReceiptView permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
            
            categoriesPopOver = popOver;
            
        }
        
        else {
            
            categoriesPopover.contentSizeForViewInPopover = CGSizeMake(160.0, 250.0);
            
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:categoriesPopover];
            
            popOver.contentViewController.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
            
            categoriesPopOver = popOver;
            
        }
        
        
        
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
}



#pragma -mark action used to hide the price list view....


/**
 * @description  here we are hidding the transperentView....
 * @date
 * @method       closePriceView:
 * @author
 * @param        UIButton
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 15/04/2017...
 * @reason      added comments && added the expansion handling....
 *
 */

-(void)closePriceView:(UIButton *)sender {
    @try {
        
        transparentView.hidden = YES;
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception in closePriceView () -- in MaterialTransferReciepts ----");
        NSLog(@"----%@",exception);
    }
}

#pragma -mark superClass methods....


/**
 * @description  here we are navigating to homePage....
 * @date
 * @method       homeButonClicked
 * @author
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 15/04/2017...
 * @reason      added comments && added the expansion handling....
 *
 */

-(void)homeButonClicked {
    
    @try {
        
        OmniHomePage *home = [[OmniHomePage alloc]init];
        [self.navigationController pushViewController:home animated:YES];
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception in homeButonclicked () -- in MaterialTransferReciepts ----");
        NSLog(@"----%@",exception);
        
    }
}

/**
 * @description  here we are calling backAction()....
 * @date
 * @method       goToHome()
 * @author
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 15/04/2017...
 * @reason      added comments && added the expansion handling....
 *
 */

-(void)goToHome {
    
    @try {
        
        [self backAction];
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception in goToHome () -- in MaterialTransferReciepts ----");
        NSLog(@"----%@",exception);
        
    }
}

/**
 * @description  here we are navigating to previous calls existing navigation controller....
 * @date
 * @method       backAction()
 * @author
 * @param
 * @param
 * @return       void
 * @verified By
 * @verified On
 *
 *
 * @modified By Srinivasulu on 15/04/2017...
 * @reason      added comments && added the expansion handling....
 *
 */

-(void)backAction {
    
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        [self.navigationController popViewControllerAnimated:YES];
        
    } @catch (NSException *exception) {
        
        NSLog(@"---- exception in backAction () -- in MaterialTransferReciepts ----");
        NSLog(@"----%@",exception);
        
    }
}


/**
 * @description  Here we are dismissing the popOver when cancelButton pressed...
 * @date         29/07/2017
 * @method       dismissCategoryPopOver
 * @author       Bhargav.v
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

-(void)dismissCategoryPopOver:(UIButton*)sender{
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    @try {
        [categoriesPopOver dismissPopoverAnimated:YES];
    } @catch (NSException *exception) {
        
    }
}



/**
 * @description  here we are showing the list of requestedItems.......
 * @date         20/09/2016
 * @method       changeCheckBoxImages:
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)changeCheckBoxImages:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if( [checkBoxArr[sender.tag] integerValue])
            checkBoxArr[sender.tag] = @"0";
        
        else
            checkBoxArr[sender.tag] = @"1";
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [categoriesTbl reloadData];
        
    }
    
    
    
}


/**
 * @description  here we are showing the list of requestedItems.......
 * @date         20/09/2016
 * @method       changeCheckBoxImage;
 * @author       Srinivasulu
 * @param        UIButton
 * @param
 * @return
 * @verified By
 * @verified On
 *
 */

- (void)changeSelectAllCheckBoxButtonImage:(UIButton *)sender {
    //Play Audio for button touch....
    AudioServicesPlaySystemSound (soundFileObject);
    
    @try {
        
        if(categoriesArr.count){
            
            UIImage * checkBoxImg = [UIImage imageNamed:@"checkbox_off_background.png"];
            
            
            if(selectAllCheckBoxBtn.tag == 2){
                
                for(int i = 0; i < checkBoxArr.count; i++){
                    
                    checkBoxArr[i] = @"1";
                }
                
                checkBoxImg = [UIImage imageNamed:@"checkbox_on_background.png"];
                
                [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                selectAllCheckBoxBtn.tag = 4;
                
            }
            else{
                
                for(int i = 0; i < checkBoxArr.count; i++){
                    
                    checkBoxArr[i] = @"0";
                }
                
                [selectAllCheckBoxBtn setBackgroundImage:checkBoxImg forState:UIControlStateNormal];
                
                selectAllCheckBoxBtn.tag = 2;
            }
            
        }
        
    } @catch (NSException *exception) {
        
    } @finally {
        
        [categoriesTbl reloadData];
        
    }
    
}


@end

