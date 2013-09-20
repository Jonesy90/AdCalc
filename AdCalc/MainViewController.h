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
    NSInteger *selectedRow;
}

//NSArray
@property (nonatomic, strong) NSArray *metricArray;

//UILabels
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;


//UITextFields
@property (weak, nonatomic) IBOutlet UITextField *revenueTextField;
@property (weak, nonatomic) IBOutlet UITextField *deliveryTextField;

//UIPicker
@property (weak, nonatomic) IBOutlet UIPickerView *metricPicker;


//UIButton - Action
- (IBAction)calculateButton:(id)sender;


@end
