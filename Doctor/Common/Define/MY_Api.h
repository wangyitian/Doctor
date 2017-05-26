//
//  MY_Api.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#ifndef MY_Api_h
#define MY_Api_h

#define MY_BASE_API_PATH                @"http://api.meiyujiankang.com/admin.php/Index/"
//基础接口
#define MY_API_REGISTER                 @"meiyu_register"               //注册
#define MY_API_GET_CODE                 @"meiyu_information"            //获取验证码
#define MY_API_LOGIN                    @"meiyu_Sign_in"                //登录
#define MY_API_CHANGE_PWD               @"meiyu_forget"                 //修改密码
#define MY_API_FORGET_PWD               @"meiyu_forget"                 //忘记密码
#define MY_API_PATIENT_RECOMMEND        @"meiyu_Patient_Recommend"      //患者推荐
#define MY_API_ENROLL                   @"meiyu_sign_up"                //报名
#define MY_API_CHANGE_PHONE             @"meiyu_modify_phone"           //修改手机号
#define MY_API_FEEDBACK                 @"meiyu_feedback"               //意见反馈
#define MY_API_CHANGE_PERSONAL_DATA     @"meiyu_Personal_information"   //修改个人信息
#define MY_API_REALNAME                 @"meiyu_Authentication"         //实名认证
#define MY_API_REFRESH                  @"meiyu_Return_information"     //刷新用户信息
#define MY_API_GET_EXPERIENCE           @"meiyu_Experience_type"        //获取项目
//功能接口
#define MY_API_HOMEPAGE                 @"meiyu_home_page"              //首页
#define MY_API_ZAN                      @"meiyu_Give"                   //赞
#define MY_API_COURSEINTRO              @"meiyu_school"                 //学院首页
#define MY_API_COURSELIST               @"meiyu_school_kecheng"         //课程列表
#define MY_API_PUBLISH                  @"meiyu_Experience"             //发布心得
#define MY_API_MESSAGELIST              @"meiyu_recommend"              //消息列表
#define MY_API_PATIENTLIST              @"meiyu_Recommended_patient"    //患者推荐列表
#define MY_API_PATIENTPROGRESS          @"meiyu_Patient_progress"       //患者推荐进度

//网页
#define MY_WEB_COURSEDETAIL             @"http://api.meiyujiankang.com/admin.php/Index/curriculum/id/"
#define MY_WEB_TRAINING                 @"http://api.meiyujiankang.com/admin.php/Index/news/id/"
#define MY_WEB_DOWNLOAD                 @"https://itunes.apple.com/us/app/%E7%BE%8E%E5%9F%9F%E5%8C%BB%E7%96%97/id1208855490?l=zh&ls=1&mt=8"


#define UMengKey            @"58b5099a8f4a9d6e1b000e73"
#define WeiboAppKey         @"3712267529"
#define WeiboAppSecret      @"4070be45960cdef96afaafbeda4e3a08"
#define WechatAppKey        @"wx3143aac2a8cccc7b"
#define WechatAppSecret     @"4721f26733e24e2f13dea6ccb60fee2e"
#define QQAppID             @"1105942207"
#define QQAppKey            @"YKfGK32gfAdVteqo"
#endif
