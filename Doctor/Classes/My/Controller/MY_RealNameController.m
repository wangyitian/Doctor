//
//  MY_RealNameController.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RealNameController.h"
#import "MY_RealNameCell.h"
#import "MY_RealNameModel.h"
@interface MY_RealNameController ()<RealNameCellProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, assign) NSIndexPath *indexPath;
@end

@implementation MY_RealNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self initData];
}

- (void)initData {
    NSArray *titleArray = [NSArray arrayWithObjects:@"工作证",@"执业证",@"职称证", nil];
    NSArray *descArray = [NSArray arrayWithObjects:@"请上传带有头像的工作证的彩色照片",@"请上传带有头像的医师执业证盖章页内页彩色照片",@"请上传带有头像的职称证盖章页内页彩色照片", nil];
    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        MY_RealNameModel *model = [[MY_RealNameModel alloc] init];
        model.title = titleArray[i];
        model.isRequired = YES;
        model.desc = descArray[i];
        [modelArray addObject:model];
    }
    [self.dataSource addObject:modelArray];
    [self.tableView reloadData];
}

- (void)setupUI {
    [self setTitle:@"实名认证" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 54)];
    headerView.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 44)];
    noticeLabel.backgroundColor = [MY_Util setColorWithInt:0xfffece];
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.textColor = [MY_Util setColorWithInt:0x333333];
    noticeLabel.font = MY_Font(14);
    
    MY_AccountModel *accountModel = [MY_Util getAccountModel];
    if (accountModel.type.integerValue == 3) {
        noticeLabel.text = @"认证未通过，请重新上传图片进行认证";
    } else {
        noticeLabel.text = @"欢迎加入麻省健康，完成实名认证可使用完整功能";
    }
    [headerView addSubview:noticeLabel];
    self.tableView.tableHeaderView = headerView;
    
    UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 41)];
    footerLabel.text = @"您的认证资料不会被公开，仅用于麻省健康认证审核。";
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.textColor = [MY_Util setColorWithInt:0x999999];
    footerLabel.font = MY_Font(11);
    self.tableView.tableFooterView = footerLabel;
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_RealNameCell class];
}

- (void)uploadPhotoWithIndex:(NSIndexPath*)indexPath {
    self.indexPath = indexPath;
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
//        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
//        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:sheet animated:YES completion: nil];
    });
}
#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        
        CGFloat ratio = 1.0;
        if (img.size.width > 1000) {
            ratio = 1000/img.size.width;
        }
        
        
        NSData *imageData = UIImageJPEGRepresentation(img,ratio);
        NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
        [paramter setObject:[MY_Util getUid] forKey:@"uid"];
        if (self.indexPath.row == 0) {
            [paramter setObject:encodedImageStr forKey:@"card"];
        } else if (self.indexPath.row == 1) {
            [paramter setObject:encodedImageStr forKey:@"certificate"];
        } else if (self.indexPath.row == 2) {
            [paramter setObject:encodedImageStr forKey:@"title"];
        }
        [model postDataWithURL:MY_API_REALNAME paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self presentAlertWithMessage:dic[@"message"] ConfirmAction:^(UIAlertAction *action) {
                ((MY_RealNameModel*)[[self.dataSource objectAtIndex:0] objectAtIndex:self.indexPath.row]).image = encodedImageStr;
                [self.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationNone];
                MY_AccountModel *account = [MY_Util getAccountModel];
                if (self.indexPath.row == 0) {
                    account.card = dic[@"card"];
                } else if (self.indexPath.row == 1) {
                    account.certificate = dic[@"certificate"];
                } else if (self.indexPath.row == 2) {
                    account.title = dic[@"title"];
                }
                [MY_Util saveAccount:account];
            } completion:nil];
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
