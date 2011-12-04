//
//  ResultViewController.h
//  LocationPhoneNumber
//
//  Created by 陈 泽锋 on 11-11-16.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UILabel *mobileNumber;
@property (nonatomic, strong) IBOutlet UILabel *city;
@property (nonatomic, strong) IBOutlet UILabel *province;
@property (nonatomic, strong) IBOutlet UILabel *areaCode;
@property (nonatomic, strong) IBOutlet UILabel *postCode;
@property (nonatomic, strong) IBOutlet UILabel *card;

- (IBAction)startSearch:(id)sender;

@end
