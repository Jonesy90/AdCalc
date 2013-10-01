//
//  MainViewController.h
//  AdCalc
//
//  Created by Michael Jones on 20/09/2013.
//  Copyright (c) 2013 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

#define METRIC 0


@interface MainViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

{
    NSInteger metricRow;
    NSInteger currencyRow;
    
}

@property (nonatomic, strong) NSArray *metricArray;
@property (nonatomic, strong) NSArray *currencyArray;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UITextField *revenueTextField;
@property (weak, nonatomic) IBOutlet UITextField *deliveryTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *metricPicker;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *clearButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *infoButton;

- (IBAction)calculateButton:(id)sender;

- (void) clearContents;



@end
