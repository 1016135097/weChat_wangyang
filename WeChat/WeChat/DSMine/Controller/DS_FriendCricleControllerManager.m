//
//  DS_FriendCricleControllerManager.m
//  WeChat
//
//  Created by wangyang on 16/5/31.
//  Copyright © 2016年 wangyang. All rights reserved.
//

#import "DS_FriendCricleControllerManager.h"
#import "DS_FriendCricleModel.h"

@interface DS_FriendCricleControllerManager ()
@property (nonatomic,copy)acceptDataBlock dataBlock;
@end

@implementation DS_FriendCricleControllerManager

+ (instancetype)shareInstance
{
    static DS_FriendCricleControllerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DS_FriendCricleControllerManager new];
    });
    return manager;
}

- (void)requestWebData
{
    self.dataBlock([self configFalseData]);
}

- (void)dataSourceWithBlock:(acceptDataBlock)block
{
    _dataBlock = block;
}

- (NSArray *)configFalseData
{
    DS_FriendCricleModel *model0 = [[DS_FriendCricleModel alloc] init];
    model0.headIcon = @"icon1.jpg";
    model0.name = @"说好的幸福了";
    model0.dec = @"杜特尔特阵营此前指控菲律宾总统阿基诺和国会参议员安东尼奥·特里兰尼斯犯有“叛国罪”和“间谍罪”，因两人在黄岩岛“对峙事件”中曾进行“秘密谈判”，泄露了国家机密。阿基诺在为自己开脱时对记者揭露表示，当时由于美国参与了事件调停，菲律宾才采取撤离措施";
    model0.feedType = 1;
    model0.timeStamp = @"22:45";
    model0.comments = @[[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel],[DS_FriendCricleControllerManager configCommentModel]];
    
    DS_FriendCricleModel *model1 = [[DS_FriendCricleModel alloc] init];
    model1.headIcon = @"icon2.jpg";
    model1.name = @"说好的幸福了";
    DS_FriendCricleFeedModel *feed = [[DS_FriendCricleFeedModel alloc] init];
    feed.pictures = @[@"icon1.jpg",@"icon2.jpg"];
    model1.feedModel = feed;
    model1.feedType = 2;
    model1.timeStamp = @"22:40";
    
    DS_FriendCricleModel *model2 = [[DS_FriendCricleModel alloc] init];
    model2.headIcon = @"icon1.jpg";
    model2.name = @"说好的幸福了";
    model2.dec = @"杜特尔特阵营此前指控菲律宾总统阿基诺和国会参议员安东尼奥·特里兰尼斯犯有“叛国罪”和“间谍罪”，因两人在黄岩岛“对峙事件”中曾进行“秘密谈判”，泄露了国家机密。阿基诺在为自己开脱时对记者揭露表示，当时由于美国参与了事件调停，菲律宾才采取撤离措施";
    model2.feedType = 2;
    DS_FriendCricleFeedModel *feed1 = [[DS_FriendCricleFeedModel alloc] init];
    feed1.pictures = @[@"icon1.jpg",@"icon2.jpg"];
    model2.feedModel = feed1;
    model2.timeStamp = @"22:45";
    
    DS_FriendCricleModel *model3 = [[DS_FriendCricleModel alloc] init];
    model3.headIcon = @"icon1.jpg";
    model3.name = @"说好的幸福了";
    model3.dec = @"杜特尔特阵营此前";
    model3.feedType = 2;
    DS_FriendCricleFeedModel *feed2 = [[DS_FriendCricleFeedModel alloc] init];
    feed2.pictures = @[@"icon1.jpg",@"icon2.jpg",@"icon1.jpg",@"icon2.jpg"];
    model3.feedModel = feed2;
    model3.timeStamp = @"22:45";
    DS_FriendCricleModel *model4 = [DS_FriendCricleControllerManager cofigPictureModelWithPictureNums:3];
    DS_FriendCricleModel *model5 = [DS_FriendCricleControllerManager cofigPictureModelWithPictureNums:4];
    DS_FriendCricleModel *model6 = [DS_FriendCricleControllerManager cofigPictureModelWithPictureNums:3];
    DS_FriendCricleModel *model7 = [DS_FriendCricleControllerManager cofigPictureModelWithPictureNums:8];
    DS_FriendCricleModel *model8 = [DS_FriendCricleControllerManager cofigPictureModelWithPictureNums:9];
    
    DS_FriendCricleModel *model9 = [DS_FriendCricleControllerManager configRssNew];
    
    DS_FriendCricleModel *model10 = [DS_FriendCricleControllerManager configRssSignNew];
    DS_FriendCricleModel *model11 = [DS_FriendCricleControllerManager configRssSignNew];
    return @[model10,model11,model0,model11,model1,model2,model3,model10,model9,model4,model5,model6,model7,model8,model9,model10,model0,model1,model2,model11,model9,model3,model4,model5,model6,model10,model10,model7,model8,model11,model9,model9,model10];
}

+ (DS_FriendCricleCommentModel *)configCommentModel
{
    DS_FriendCricleCommentModel *model = [[DS_FriendCricleCommentModel alloc] init];
    model.fromUserId = @"213456";
    model.fromUserName = @"隔壁老王";
    if (arc4random()%2 == 0) {
        model.toUserId = @"000000";
        model.toUserName = @"Dscore";
    }else {
        model.toUserId = @"213457";
        model.toUserName = @"小王";
    }
    NSString *des = @"杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特";
    NSInteger count = arc4random() % des.length;
    if (count == 0) {
        count = 10;
    }
    model.comment = [des substringToIndex:count];
    return model;
}

+ (DS_FriendCricleModel *)configRssSignNew
{
    DS_FriendCricleModel *model = [[DS_FriendCricleModel alloc] init];
    model.headIcon = @"icon1.jpg";
    model.name = @"说好的幸福了";
    NSString *des = @"杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前";
    NSInteger count = arc4random() % des.length;
    if (count == 0) {
        count = 10;
    }
    model.dec = [des substringToIndex:count];
    model.feedType = 3;
    DS_FriendCricleFeedModel *feed1 = [[DS_FriendCricleFeedModel alloc] init];
    feed1.signPicture = @"icon1.jpg";
    NSString *title = @"这是主标题这是主标题这是主标这是主标题这是主标题这是主标";
    feed1.title = [title substringToIndex:arc4random() % title.length];
    model.feedModel = feed1;
    model.timeStamp = @"22:45";
//    model.comments = @[];
    return model;
}

+ (DS_FriendCricleModel *)configRssNew
{
    DS_FriendCricleModel *model = [[DS_FriendCricleModel alloc] init];
    model.headIcon = @"icon1.jpg";
    model.name = @"说好的幸福了";
    NSString *des = @"杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前";
    NSInteger count = arc4random() % des.length;
    model.dec = [des substringToIndex:count];
    model.feedType = 4;
    DS_FriendCricleFeedModel *feed1 = [[DS_FriendCricleFeedModel alloc] init];
    feed1.signPicture = @"icon1.jpg";
    NSString *title = @"这是主标题这是主标题这是主标题这是主标题这是主标题这是主标题这是主标题这是主标题这是主标题这是主标题这是主标题";
    feed1.title = [title substringToIndex:arc4random() % title.length];
    NSString *subTitle = @"这是副标题这是副标题这是副标题这是副标题这是副标题这是副标题这是副标题这是副标题这是副标题这是副标题这是副标题";
    feed1.subTitle = [subTitle substringToIndex:arc4random() % subTitle.length];
    model.feedModel = feed1;
    model.timeStamp = @"22:45";
    return model;
}

+ (DS_FriendCricleModel *)cofigPictureModelWithPictureNums:(NSInteger)nums
{
    DS_FriendCricleModel *model = [[DS_FriendCricleModel alloc] init];
    model.headIcon = @"icon1.jpg";
    model.name = @"说好的幸福了";
    NSString *des = @"杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前杜特尔特阵营此前";
    NSInteger count = arc4random() % des.length;
    model.dec = [des substringToIndex:count];
    model.feedType = 2;
    DS_FriendCricleFeedModel *feed1 = [[DS_FriendCricleFeedModel alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < nums; i++) {
        if (i % 2 == 0) {
            [array addObject:@"icon1.jpg"];
        }else {
            [array addObject:@"icon2.jpg"];
        }
    }
    feed1.pictures = array;
    model.feedModel = feed1;
    model.timeStamp = @"22:45";
//    model.comments = @[];
    return model;

}
@end
