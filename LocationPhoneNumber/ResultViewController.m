//
//  ResultViewController.m
//  LocationPhoneNumber
//
//  Created by 陈 泽锋 on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ResultViewController.h"
#import "SVProgressHUD.h"

@interface NSDictionary(JSONCategories)

+ (NSDictionary *)dictionaryWithContentsOfJSONURLString:(NSString *)urlStr;

- (NSData *)toJSON;

@end

@implementation NSDictionary(JSONCategories)

+ (NSDictionary *)dictionaryWithContentsOfJSONURLString:(NSString *)urlStr {
    NSData *data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString:urlStr]];
    
    __autoreleasing NSError *error = nil;
    
    id result = [NSJSONSerialization 
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    if (error != nil) {
        return nil;
    }
    
    return result;
}

- (NSData *)toJSON {
    NSError *error = nil;
    
    id result = [NSJSONSerialization 
                 dataWithJSONObject:self
                 options:0
                 error:&error];
    
    if (error != nil) {
        return nil;
    }
    
    return result;
}

@end

@implementation ResultViewController
@synthesize textField;
@synthesize mobileNumber;
@synthesize city;
@synthesize province;
@synthesize areaCode;
@synthesize card;
@synthesize postCode;

- (IBAction)startSearch:(id)sender {
    self.mobileNumber.text = @"...";
    self.city.text = @"...";
    self.province.text = @"...";
    self.areaCode.text = @"...";
    self.postCode.text = @"...";
    self.card.text = @"...";
    
    NSString *searchNumberTxt = 
    [[[[NSString alloc] 
     initWithString:@"http://api.showji.com/Locating/default.aspx?m="] 
     stringByAppendingString:textField.text] 
     stringByAppendingString:@"&output=json"];
    
    NSLog(@"%@", searchNumberTxt);
    
    [SVProgressHUD show];
    [textField resignFirstResponder];   
    
    NSDictionary *json = nil;
    json = [NSDictionary dictionaryWithContentsOfJSONURLString:searchNumberTxt];
    
    if (json != nil && [[json objectForKey:@"QueryResult"] isEqualToString:@"True"]) {
        [SVProgressHUD dismissWithSuccess:@"Success"];
        self.mobileNumber.text = [json objectForKey:@"Mobile"];
        self.city.text = [json objectForKey:@"City"];
        self.province.text = [json objectForKey:@"Province"];
        self.areaCode.text = [json objectForKey:@"AreaCode"];
        self.postCode.text = [json objectForKey:@"PostCode"];
        
        NSString *cardStr = [[NSString alloc] 
                             initWithFormat:@"%@ - %@", [json objectForKey:@"Corp"], [json objectForKey:@"Card"]];
        self.card.text = cardStr;
    } else {
        self.mobileNumber.text = @"...";
        self.city.text = @"...";
        self.province.text = @"...";
        self.areaCode.text = @"...";
        self.postCode.text = @"...";
        self.card.text = @"...";
        
        [SVProgressHUD dismissWithError:@"Failure"];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
