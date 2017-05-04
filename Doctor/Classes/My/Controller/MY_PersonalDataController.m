//
//  MY_PersonalDataController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PersonalDataController.h"
#import "MY_PersonalDataCell.h"
#import "MY_ChangePersonalDataController.h"
#import "MY_PersonalAvatarCell.h"
#import "MY_ChangePhoneController.h"
#import "MY_SubPickerView.h"
#import "MY_RealNameController.h"
@interface MY_PersonalDataController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MY_PersonalDataController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)setupUI {
    [self setTitle:@"个人资料" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 数据
- (void)initData {
    NSArray *dataArray = [NSArray arrayWithObjects:@"头像",@"昵称",@"真实姓名",@"手机号码",@"科室",@"医院",@"实名认证", nil];
    [self.dataSource addObject:dataArray];
    [self.tableView reloadData];
}

#pragma mark - tableview delegate
- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [MY_PersonalAvatarCell class];
    }
    return [MY_PersonalDataCell class];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    } else {
        MY_PersonalDataCell *cell = [MY_PersonalDataCell cellWithTablebView:tableView index:indexPath];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [cell setObject:[MY_Util getAccountModel] indexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [sheet addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }]];
        [sheet addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }]];
        [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:sheet animated:YES completion: nil];
        });
    } else if (indexPath.row == 1) {
        MY_ChangePersonalDataController *vc = [[MY_ChangePersonalDataController alloc] init];
        vc.changeType = Change_NickName;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        MY_ChangePersonalDataController *vc = [[MY_ChangePersonalDataController alloc] init];
        vc.changeType = Change_RealName;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        MY_ChangePhoneController *vc = [[MY_ChangePhoneController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4) {
        MY_SubPickerView *pickerView = [[MY_SubPickerView alloc] initWithDataSource:@"RoomType.plist" title:@"选择科室"];
        pickerView.confirmBlock = ^(NSString *value) {
            MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
            NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
            [paramter setObject:[MY_Util getUid] forKey:@"uid"];
            [paramter setObject:value forKey:@"department"];
            [model postDataWithURL:MY_API_CHANGE_PERSONAL_DATA paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
                [self.view makeToast:dic[@"message"] duration:1 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                    MY_AccountModel *account = [MY_Util getAccountModel];
                    account.department = value;
                    [MY_Util saveAccount:account];
                    [self.tableView reloadData];
                }];
            }];
        };
        [self.view addSubview:pickerView];
    } else if (indexPath.row == 5) {
        MY_ChangePersonalDataController *vc = [[MY_ChangePersonalDataController alloc] init];
        vc.changeType = Change_Hospital;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 6) {
        MY_AccountModel *accountModel = [MY_Util getAccountModel];
        if (!accountModel.isConfirmed) {
            MY_RealNameController *vc = [[MY_RealNameController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage *smallImage = [self thumbnailWithImageWithoutScale:img size:CGSizeMake(93, 93)];
        
        NSData *imageData = UIImageJPEGRepresentation(smallImage,1);
        NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
        [paramter setObject:encodedImageStr forKey:@"head"];
        [paramter setObject:[MY_Util getUid] forKey:@"uid"];
        [model postDataWithURL:MY_API_CHANGE_PERSONAL_DATA paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            MY_AccountModel *model = [MY_Util getAccountModel];
            model.head = dic[@"head"];
            [MY_Util saveAccount:model];
            [self presentAlertWithMessage:dic[@"message"] ConfirmAction:^(UIAlertAction *action) {
                [self.tableView reloadData];
            } completion:nil];
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    //    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
//    self.img.image = selfPhoto;
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

@end
