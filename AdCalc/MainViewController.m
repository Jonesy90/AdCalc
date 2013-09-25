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
@synthesize totalLabel = _totalLabel;
@synthesize currencyArray = _currencyArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
    _metricArray = [[NSArray alloc] initWithObjects:@"CPM", @"CPC/CPA", nil];
    _currencyArray = [[NSArray alloc] initWithObjects:@"Dollars", @"Euros", @"Sterling", nil];
    
    UITapGestureRecognizer *tabGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKeyboard)];
    [self.view addGestureRecognizer:tabGesture];
    
    
    
}

- (IBAction)calculateButton:(id)sender {
    
    //Checks for white spaces within the textField.
    NSString *revenueString = [self.revenueTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *deliveryString = [self.deliveryTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Creating two float values that is taken from the two textFields.
    float revenue = [self.revenueTextField.text floatValue];
    float delivery = [self.deliveryTextField.text floatValue];
    double total = [self.totalLabel.text doubleValue];
    
    
    //Checks the length of the revenue and delivery objects and sees if they length is equal to 0. If it is an alert will display.
    if ([revenueString length] == 0 || [deliveryString length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops" message:@"Revenue or Delivery fields are blank, please fill in." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }
    else {
        //Dollars.
        if (metricRow == 0 && currencyRow == 0) {
            total = revenue / delivery * 1000;
            self.totalLabel.text = [[NSString alloc] initWithFormat:@"$ %.05f", total];
        }
        else if (metricRow == 1 && currencyRow == 0){
            total = revenue / delivery;
            self.totalLabel.text = [[NSString alloc] initWithFormat:@"$ %0.05f", total];
        }
        //Euros.
        else if (metricRow == 0 && currencyRow == 1){
            total = revenue / delivery * 1000;
            self.totalLabel.text = [[NSString alloc] initWithFormat:@"€ %.05f", total];
        }
        else if (metricRow == 1 && currencyRow == 1) {
            total = revenue / delivery;
            self.totalLabel.text = [[NSString alloc] initWithFormat:@"€ %0.05f", total];
        }
        //Pounds.
        else if (metricRow == 0 && currencyRow == 2) {
            total = revenue / delivery * 1000;
            self.totalLabel.text = [[NSString alloc] initWithFormat:@"£ %.05f", total];
        }
        else if (metricRow == 1 && currencyRow == 2) {
            total = revenue / delivery;
            self.totalLabel.text = [[NSString alloc] initWithFormat:@"£ %0.05f", total];
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong" message:@"Something went wrong. Please try again." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
            
            [alertView show];
        }
        
    }
    
}
- (void) removeKeyboard {
    [self.revenueTextField resignFirstResponder];
    [self.deliveryTextField resignFirstResponder];
}

- (IBAction)clear:(id)sender {
    [self clearContents];
}

- (void)clearContents{
    
    self.totalLabel.text = @"0";
    self.revenueTextField.text = 0;
    self.deliveryTextField.text = 0;
}


#pragma mark - UIPickerView Methods

//Remember to link up the delegates at using the Storyboard function. Using the Outlets.

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//Instead of putting in a number we'd count the amount of objects in the array which will return the number of rows in the pickerview.
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == METRIC) {
        return [_metricArray count];
    }
    
    if (component == CURRENCY) {
        return [_currencyArray count];
    }
    
    return 0;
}

//Will display the object
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == METRIC) {
    return [_metricArray objectAtIndex:row];
    }
    
    if (component == CURRENCY) {
        return [_currencyArray objectAtIndex:row];
    }
    
    
    return 0;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    metricRow = [_metricPicker selectedRowInComponent:METRIC];
    currencyRow = [_metricPicker selectedRowInComponent:CURRENCY];
    
//    //Metric Row Tests
//    if (metricRow == row) {
//         NSLog(@"Selected Item: %@",[_metricArray objectAtIndex:row]);
//    }
//    
//    
//    //Currency Row Tests
//    if (currencyRow == row) {
//        NSLog(@"Selected Item: %@",[_currencyArray objectAtIndex:row]);
//    }


}

#pragma mark - Motion Events

- (BOOL) canBecomeFirstResponder{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"Motion Begin");
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self clearContents];
        NSLog(@"Motion Ended");
    };
    
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"Motion Cancelled");
}

@end
