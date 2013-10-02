//
//  MainViewController.m
//  AdCalc
//
//  Created by Michael Jones on 20/09/2013.
//  Copyright (c) 2013 Michael Jones. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize metricArray = _metricArray;
@synthesize revenueTextField = _revenueTextField;
@synthesize deliveryTextField = _deliveryTextField;
@synthesize metricPicker = _metricPicker;
@synthesize metricTextField = _metricTextField;
@synthesize currencyArray = _currencyArray;
@synthesize clearButton = _clearButton;
@synthesize infoButton = _infoButton;



- (void)viewDidLoad
{
    [super viewDidLoad];
    _metricArray = [[NSArray alloc] initWithObjects:@"CPM", @"CPC/CPA", nil];
    
    UITapGestureRecognizer *tabGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKeyboard)];
    [self.view addGestureRecognizer:tabGesture];
        
    UIImage *backgroundImage = [UIImage imageNamed:@"AdCalc_BackgroundImage.png"];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    
    _clearButton.action = @selector(clearContents);

}

- (IBAction)calculateButton:(id)sender {
    
    //Checks for white spaces within the textField.
    NSString *revenueString = [self.revenueTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *deliveryString = [self.deliveryTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *metricString = [self.metricTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Creating two float values that is taken from the two textFields.
    float revenue = [self.revenueTextField.text floatValue];
    float delivery = [self.deliveryTextField.text floatValue];
    float metric = [self.metricTextField .text floatValue];
    
    //Alerts.
    UIAlertView *somethingWentWrongAlert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong" message:@"Something went wrong. Please try again." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
    UIAlertView *blankFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Whoops" message:@"Revenue or Delivery fields are blank, please fill in." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    
    
    //Checks the length of the revenue and delivery objects and sees if they length is equal to 0. If it is an alert will display.
    if ([revenueString length] == 0 && [deliveryString length] == 0 && [metricString length] == 0){

        [blankFieldsAlert show];
    }
    //The Revenue and Delivery TextField have to be filled in. Metrics TextField will be calculated.
    else if ([revenueString length] >= 1 && [deliveryString length] >= 1 && [metricString length] == 0) {
            //The CPM metric is selected in this IF statement.
        if (metricRow == 0) {
            //Formula for figuring out the CPM rate.
            metric = revenue / delivery * 1000;
            self.metricTextField.text = [[NSString alloc] initWithFormat:@"%0.02f", metric];
            NSLog(@"CPM rate will be displayed.");
        }
            //The CPC/CPA metric is selected in this ELSE/IF statement.
        else if (metricRow == 1) {
            //Formula for figuring out the CPC/CPA rate.
            metric = revenue / delivery;
            self.metricTextField.text = [[NSString alloc] initWithFormat:@"%0.02f", metric];
            NSLog(@"CPC rate will be displayed.");
        }
    }
    //The Delivery and Metric TextFields have to be filled in. Revenue TextField will be calculated.
    else if ([revenueString length] == 0 && [deliveryString length] >= 1 && [metricString length] >=1) {
            //The CPM metric is selected in this IF statement.
        if (metricRow == 0){
            //Forumula for figuring out the Revenue (CPM).
            revenue = metric * delivery / 1000;
            self.revenueTextField.text = [[NSString alloc] initWithFormat:@"%0.02f", revenue];
            NSLog(@"Revenue for a CPM campaign will be displayed.");
        }
            //The CPC/CPA metric is selected in this ELSE/IF statement.
        else if (metricRow == 0) {
            //Formula for figuring out the Revenue (CPC/CPA).
            revenue = delivery * metric;
            self.revenueTextField.text = [[NSString alloc] initWithFormat:@"%0.02f", revenue];
            NSLog(@"Revenue for a CPC/CPA campaign will be displayed.");
        }
    }
    //The Metric and Revenue TextFields have been filled in. Delivery TextField will be calculated.
    else if ([metricString length] >= 1 && [revenueString length] >= 1 && [deliveryString length] == 0){
        if (metricRow == 0) {
            //Formula for figuring out the amount to be delivered CPM.
            delivery = metric * (1000/revenue);
            self.deliveryTextField.text = [[NSString alloc] initWithFormat:@"%g", delivery];
            NSLog(@"Impression amount to be delivered will be displayed.");
        }
        else if (metricRow == 1) {
            //Forumula for figuring out the amount to be delivered CPC/CPA.
            delivery = revenue * metric;
            self.deliveryTextField.text = [[NSString alloc] initWithFormat:@"%f", delivery];
            NSLog(@"Clicks/Conversions amount to be delivered will displayed.");
        }
        
    }
    else {
        [somethingWentWrongAlert show];
    }

}
- (void) removeKeyboard {
    [self.metricTextField resignFirstResponder];
    [self.revenueTextField resignFirstResponder];
    [self.deliveryTextField resignFirstResponder];
}


- (void)clearContents{
    
    self.metricTextField.text = nil;
    self.revenueTextField.text = nil;
    self.deliveryTextField.text = nil;
    
    NSLog(@"ClearButton Pressed.");
}


#pragma mark - UIPickerView Methods

//Remember to link up the delegates at using the Storyboard function. Using the Outlets.

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//Instead of putting in a number we'd count the amount of objects in the array which will return the number of rows in the pickerview.
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == METRIC) {
        return [_metricArray count];
    }
    return 0;
}

//Will display the object
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == METRIC) {
    return [_metricArray objectAtIndex:row];
    }
    
    return 0;
    
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    metricRow = [_metricPicker selectedRowInComponent:METRIC];
    
//    //Metric Row Tests
//    if (metricRow == row) {
//         NSLog(@"Selected Item: %@",[_metricArray objectAtIndex:row]);
//    }

}

//Changes the Font type of the text inside the UIPickerView.
- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 100, 30);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setContentMode:UIViewContentModeScaleAspectFill];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont fontWithName:@"Chalkduster" size:18.0]];
    }
    [pickerLabel setText:[_metricArray objectAtIndex:row]];
    return pickerLabel;
}


#pragma mark - Motion Events

- (BOOL) canBecomeFirstResponder{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    NSLog(@"Motion Begin");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self clearContents];
//        NSLog(@"Motion Ended");
    };
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
//    NSLog(@"Motion Cancelled");
}

@end
