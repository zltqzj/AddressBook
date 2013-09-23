//
//  ViewController.m
//  AddressBook
//
//  Created by Sinosoft on 9/22/13.
//  Copyright (c) 2013 com.Sinosoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textView;
@synthesize picker;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    [self.view addSubview:textView];

}


-(IBAction)jump2Contack:(id)sender
{
     //  跳转到通讯录界面
     picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate  = self;
    [self presentViewController:picker animated:YES completion:nil];

}

-(IBAction)address:(id)sender
{
    NSLog(@"开始访问");
        
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    for(int i = 0; i < CFArrayGetCount(results); i++)
    {
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        //读取firstname
        NSString *personName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if(personName != nil)
            textView.text = [textView.text stringByAppendingFormat:@"\n姓名：%@\n",personName];
        //读取lastname
        NSString *lastname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if(lastname != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",lastname];
        //读取middlename
        NSString *middlename = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
        if(middlename != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlename];
        //读取prefix前缀
        NSString *prefix = (__bridge NSString*)ABRecordCopyValue(person, kABPersonPrefixProperty);
        if(prefix != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",prefix];
        //读取suffix后缀
        NSString *suffix = (__bridge NSString*)ABRecordCopyValue(person,kABPersonSuffixProperty );
        if(suffix != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",suffix];
        //读取nickname呢称
        NSString *nickname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
        if(nickname != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",nickname];
        //读取firstname拼音音标
        NSString *firstnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);
        if(firstnamePhonetic != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",firstnamePhonetic];
        //读取lastname拼音音标
        NSString *lastnamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);
        if(lastnamePhonetic != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",lastnamePhonetic];
        //读取middlename拼音音标
        NSString *middlenamePhonetic = (__bridge NSString*)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);
        if(middlenamePhonetic != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",middlenamePhonetic];
        //读取organization公司
        NSString *organization = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
        if(organization != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",organization];
        //读取jobtitle工作
        NSString *jobtitle = (__bridge NSString*)ABRecordCopyValue(person, kABPersonJobTitleProperty);
        if(jobtitle != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",jobtitle];
        //读取department部门
        NSString *department = (__bridge NSString*)ABRecordCopyValue(person, kABPersonDepartmentProperty);
        if(department != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",department];
        //读取birthday生日
        NSDate *birthday = (__bridge NSDate*)ABRecordCopyValue(person, kABPersonBirthdayProperty);
        if(birthday != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",birthday];
        //读取note备忘录
        NSString *note = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNoteProperty);
        if(note != nil)
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",note];
        //第一次添加该条记录的时间
        NSString *firstknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonCreationDateProperty);
        NSLog(@"第一次添加该条记录的时间%@\n",firstknow);
        //最后一次修改該条记录的时间
        NSString *lastknow = (__bridge NSString*)ABRecordCopyValue(person, kABPersonModificationDateProperty);
        NSLog(@"最后一次修改該条记录的时间%@\n",lastknow);
        
        //获取email多值
        ABMultiValueRef email = ABRecordCopyValue(person, kABPersonEmailProperty);
        int emailcount = ABMultiValueGetCount(email);
        for (int x = 0; x < emailcount; x++)
        {
            //获取email Label
            NSString* emailLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(email, x));
            //获取email值
            NSString* emailContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(email, x);
            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",emailLabel,emailContent];
        }
        //读取地址多值
        ABMultiValueRef address = ABRecordCopyValue(person, kABPersonAddressProperty);
        int count = ABMultiValueGetCount(address);
        
        for(int j = 0; j < count; j++)
        {
            //获取地址Label
            NSString* addressLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(address, j);
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",addressLabel];
            //获取該label下的地址6属性
            NSDictionary* personaddress =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(address, j);
            NSString* country = [personaddress valueForKey:(NSString *)kABPersonAddressCountryKey];
            if(country != nil)
                textView.text = [textView.text stringByAppendingFormat:@"国家：%@\n",country];
            NSString* city = [personaddress valueForKey:(NSString *)kABPersonAddressCityKey];
            if(city != nil)
                textView.text = [textView.text stringByAppendingFormat:@"城市：%@\n",city];
            NSString* state = [personaddress valueForKey:(NSString *)kABPersonAddressStateKey];
            if(state != nil)
                textView.text = [textView.text stringByAppendingFormat:@"省：%@\n",state];
            NSString* street = [personaddress valueForKey:(NSString *)kABPersonAddressStreetKey];
            if(street != nil)
                textView.text = [textView.text stringByAppendingFormat:@"街道：%@\n",street];
            NSString* zip = [personaddress valueForKey:(NSString *)kABPersonAddressZIPKey];
            if(zip != nil)
                textView.text = [textView.text stringByAppendingFormat:@"邮编：%@\n",zip];
            NSString* coutntrycode = [personaddress valueForKey:(NSString *)kABPersonAddressCountryCodeKey];
            if(coutntrycode != nil)
                textView.text = [textView.text stringByAppendingFormat:@"国家编号：%@\n",coutntrycode];
        }
        
        //获取dates多值
        ABMultiValueRef dates = ABRecordCopyValue(person, kABPersonDateProperty);
        int datescount = ABMultiValueGetCount(dates);
        for (int y = 0; y < datescount; y++)
        {
            //获取dates Label
            NSString* datesLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(dates, y));
            //获取dates值
            NSString* datesContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(dates, y);
            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",datesLabel,datesContent];
        }
        //获取kind值
        CFNumberRef recordType = ABRecordCopyValue(person, kABPersonKindProperty);
        if (recordType == kABPersonKindOrganization) {
            // it's a company
            NSLog(@"it's a company\n");
        } else {
            // it's a person, resource, or room
            NSLog(@"it's a person, resource, or room\n");
        }
        
        
        //获取IM多值
        ABMultiValueRef instantMessage = ABRecordCopyValue(person, kABPersonInstantMessageProperty);
        for (int l = 1; l < ABMultiValueGetCount(instantMessage); l++)
        {
            //获取IM Label
            NSString* instantMessageLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(instantMessage, l);
            textView.text = [textView.text stringByAppendingFormat:@"%@\n",instantMessageLabel];
            //获取該label下的2属性
            NSDictionary* instantMessageContent =(__bridge NSDictionary*) ABMultiValueCopyValueAtIndex(instantMessage, l);
            NSString* username = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageUsernameKey];
            if(username != nil)
                textView.text = [textView.text stringByAppendingFormat:@"username：%@\n",username];
            
            NSString* service = [instantMessageContent valueForKey:(NSString *)kABPersonInstantMessageServiceKey];
            if(service != nil)
                textView.text = [textView.text stringByAppendingFormat:@"service：%@\n",service];
        }
        
        //读取电话多值
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            
            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",personPhoneLabel,personPhone];
        }
        
        //获取URL多值
        ABMultiValueRef url = ABRecordCopyValue(person, kABPersonURLProperty);
        for (int m = 0; m < ABMultiValueGetCount(url); m++)
        {
            //获取电话Label
            NSString * urlLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(url, m));
            //获取該Label下的电话值
            NSString * urlContent = (__bridge NSString*)ABMultiValueCopyValueAtIndex(url,m);
            
            textView.text = [textView.text stringByAppendingFormat:@"%@:%@\n",urlLabel,urlContent];
        }
        
        //读取照片
        NSData *image = (__bridge NSData*)ABPersonCopyImageData(person);
        
        
        UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
        [myImage setImage:[UIImage imageWithData:image]];
        myImage.opaque = YES;
        [textView addSubview:myImage];
        
        
        
    }
    NSLog(@"所有内容%@",textView.text);
    CFRelease(results);
    CFRelease(addressBook);
    
}


#pragma  mark - ABPeoplePickerNavigationControllerDelegate
// Called after the user has pressed cancel
// The delegate is responsible for dismissing the peoplePicker
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// Called after a person has been selected by the user.
// Return YES if you want the person to be displayed.
// Return NO  to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    //获取联系人姓名
   NSString* name = (__bridge NSString*)ABRecordCopyCompositeName(person);
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
        NSString *aPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i)  ;
        NSString *aLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phoneMulti, i) ;
        NSLog(@"PhoneLabel:%@ Phone#:%@",aLabel,aPhone);
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"])
        {
            [phones addObject:aPhone];
        }
    }
    NSLog(@"姓名:%@",name);
    NSString* phoneNo;
    if([phones count]>0)
    {
        NSString *mobileNo = [phones objectAtIndex:0];
        phoneNo  = mobileNo;
        NSLog(@"电话%@",mobileNo);
        //NSLog(mobileNo);
    }
    
    //获取联系人邮箱
    ABMutableMultiValueRef emailMulti = ABRecordCopyValue(person, kABPersonEmailProperty);
    NSMutableArray *emails = [[NSMutableArray alloc] init];
    for (i = 0;i < ABMultiValueGetCount(emailMulti); i++)
    {
        NSString *emailAdress = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emailMulti, i);
        [emails addObject:emailAdress];
    }
    
    NSString* email;
  
    if([emails count]>0)
    {  
        NSString *emailFirst=[emails objectAtIndex:0];  
        email  = emailFirst;  
        //NSLog(emailFirst);  
    }
    NSLog(@"email:%@",email);
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}


// Called after a value has been selected by the user.
// Return YES if you want default action to be performed.
// Return NO to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}


// 隐藏键盘
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textView resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
