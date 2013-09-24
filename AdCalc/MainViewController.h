//
//  MainViewController.h
//  AdCalc
//
//  Created by Michael Jones on 20/09/2013.
//  Copyright (c) 2013 Michael Jones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

{
    NSInteger selectedRow;
    
}

@property (nonatomic, strong) NSArray *metricArray;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (weak, nonatomic) IBOutlet UITextField *revenueTextField;
@property (weak, nonatomic) IBOutlet UITextField *deliveryTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *metricPicker;


//UIButton - Action
- (IBAction)calculateButton:(id)sender;


- (void)cpmCalculation;
- (void)cpcCalculation;
- (IBAction)clear:(id)sender;


@end
