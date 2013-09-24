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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _metricArray = [[NSArray alloc] initWithObjects:@"CPM", @"CPC/CPA", nil];
    
    UITapGestureRecognizer *tabGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKeyboard)];
    [self.view addGestureRecognizer:tabGesture];
    
    
    
    
}

- (IBAction)calculateButton:(id)sender {
    
    //Checks for white spaces within the textField.
    NSString *revenueString = [self.revenueTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *deliveryString = [self.deliveryTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Checks the length of the revenue and delivery objects and sees if they length is equal to 0. If it is an alert will display.
    if ([revenueString length] == 0 || [deliveryString length] == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Whoops" message:@"Revenue or Delivery fields are blank, please fill in." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }
    else {
        //Checks what object is being highligted in the UIPicker view and calls a certain method.
        if (selectedRow == 0) {
            [self cpmCalculation];
        }
        else if (selectedRow == 1){
            [self cpcCalculation];
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


- (void)cpmCalculation {
    //Creating two float values that is taken from the two textFields.
    float revenue = [self.revenueTextField.text floatValue];
    float delivery = [self.deliveryTextField.text floatValue];
    double total = [self.totalLabel.text doubleValue];
    
    //CPM Calculation
    total = revenue / delivery * 1000;
    //Displays the float total in the totalLabel field.
    self.totalLabel.text = [[NSString alloc] initWithFormat:@"%.05f", total];
    
//    NSLog(@"This is a CPM Calculation");
    NSLog(@"This is a CPM Calculation");
}

- (void)cpcCalculation{
    //Creating two float values that is taken from the two textFields.
    float revenue = [self.revenueTextField.text floatValue];
    float delivery = [self.deliveryTextField.text floatValue];
    double total = [self.totalLabel.text doubleValue];
    
    //CPM Calculation
    total = revenue / delivery;
    //Displays the float total in the totalLabel field.
    self.totalLabel.text = [[NSString alloc] initWithFormat:@"%0.05f", total];
    NSLog(@"This is a CPC or CPA Calculation");
    
}

- (IBAction)clear:(id)sender {
    
    self.totalLabel.text = 0;
    self.revenueTextField.text = 0;
    self.deliveryTextField.text = 0;
    
}


#pragma mark - UIPickerView Methods

//Remember to link up the delegates at using the Storyboard function. Using the Outlets.

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//Instead of putting in a number we'd count the amount of objects in the array which will return the number of rows in the pickerview.
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_metricArray count];
    
    return 0;
}

//Will display the object
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [_metricArray objectAtIndex:row];
    
    return 0;
}

//Does something once a row is selected??
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //Displays the row that is selected in the _metricsArray.
    //NSLog(@"Selected Item: %@. Index of selected item %i", [_metricArray objectAtIndex:row], row);
    
    selectedRow = [_metricPicker selectedRowInComponent:component];
    
    //ELSE/IF Statement on a selected row in component.
    if ([_metricPicker selectedRowInComponent:component] == 0) {
        NSLog(@"Selected Item: %@", [_metricArray objectAtIndex:row]);
    }
    else if ([_metricPicker selectedRowInComponent:component] == 1) {
        NSLog(@"Selected Item: %@", [_metricArray objectAtIndex:row]);
    }

}

@end
