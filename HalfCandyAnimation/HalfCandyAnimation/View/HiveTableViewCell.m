//
//  HiveTableViewCell.m
//  HalfCandyAnimation
//
//  Created by QC.L on 16/5/18.
//  Copyright © 2016年 QC.L. All rights reserved.
//

#import "HiveTableViewCell.h"
#import "Sub.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HiveTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *myTitleView;

@end

@implementation HiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSub:(Sub *)sub {
    _sub = sub;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:sub.pic]];
    self.myTitleView.text = sub.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
