//
//  CurrencyTableViewController.m
//  AdCalc
//
//  Created by Michael Jones on 26/09/2013.
//  Copyright (c) 2013 Michael Jones. All rights reserved.
//

#import "CurrencyTableViewController.h"

@interface CurrencyTableViewController ()

@end

@implementation CurrencyTableViewController

@synthesize currencyConversion = _currencyConversion;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dollarsToEuros = [NSDictionary dictionaryWithObjectsAndKeys:@"Dollar To Euros", @"title", @"1 Dollar = 0.74115 Euros", @"exchange", nil];
    NSDictionary *dollarsToSterling = [NSDictionary dictionaryWithObjectsAndKeys:@"Dollar to Sterling", @"title", @"1 Dollar = 0.62345 Sterling", @"exchange", nil];
    NSDictionary *euroToDollar = [NSDictionary dictionaryWithObjectsAndKeys:@"Euro to Dollar", @"title", @"1 Euro = 1.34969 Dollars", @"exchange", nil];
    NSDictionary *euroToSterling = [NSDictionary dictionaryWithObjectsAndKeys:@"Euro to Sterling", @"title", @"1 Euro = 0.84078 Sterling", @"exchange", nil];
    NSDictionary *sterlingToDollar = [NSDictionary dictionaryWithObjectsAndKeys:@"Sterling to Dollar", @"title", @"1 Sterling = 1.60514 Dollar", @"exchange", nil];
    NSDictionary *sterlingToEuro = [NSDictionary dictionaryWithObjectsAndKeys:@"Sterling to Euro", @"title", @"1 Sterling = 1.18919 Euro", @"exchange", nil];

    _currencyConversion = [NSArray arrayWithObjects:dollarsToEuros, dollarsToSterling, euroToDollar, euroToSterling, sterlingToDollar, sterlingToEuro, nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.currencyConversion count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *conversions = [self.currencyConversion objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [conversions valueForKey:@"title"];
    cell.detailTextLabel.text = [conversions valueForKey:@"exchange"];
    
    // Configure the cell...
    
    return cell;
}



@end
