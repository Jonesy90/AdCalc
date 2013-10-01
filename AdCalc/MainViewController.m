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
    
    _clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clearContents)];
    
    
    
//    _infoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(<#selector#>)];
}

- (IBAction)calculateButton:(id)sender {
    
    //Checks for white spaces within the textField.
    NSString *revenueString = [self.revenueTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *deliveryString = [self.deliveryTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Creating two float values that is taken from the two textFields.
    float revenue = [self.revenueTextField.text floatValue];
    float delivery = [self.deliveryTextField.text floatValue];
    double total = [self.totalLabel.text doubleValue];
    
    //Alerts.
    UIAlertView *somethingWentWrongAlert = [[UIAlertView alloc] initWithTitle:@"Something Went Wrong" message:@"Something went wrong. Please try again." delegate:nil cancelButtonTitle:@"Done" otherButtonTitles: nil];
    UIAlertView *blankFieldsAlert = [[UIAlertView alloc] initWithTitle:@"Whoops" message:@"Revenue or Delivery fields are blank, please fill in." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    
    
    //Checks the length of the revenue and delivery objects and sees if they length is equal to 0. If it is an alert will display.
    if ([revenueString length] == 0 || [deliveryString length] == 0){

        
        [blankFieldsAlert show];
    }
    else {
        //The Metric will be in dollars.
        if (metricRow == 0 && delivery > 0) {
            total = revenue / delivery * 1000;
            self.totalLabel.text = [[NSString alloc] initWithFormat:@"$ %0.02f", total];
        }
        else if (metricRow == 1 && delivery > 0){
            total = revenue / delivery;
            self.totalLabel.text = [[NSString alloc] initWithFormat:@"$ %0.02f", total];
        }
        else {
            [somethingWentWrongAlert show];
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
    self.revenueTextField.text = nil;
    self.deliveryTextField.text = nil;
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
        CGRect frame = CGRectMake(0.0, 0.0, 70, 30);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setContentMode:UIViewContentModeScaleAspectFill];
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
