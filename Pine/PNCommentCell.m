//
//  PNCommentCell.m
//  Pine
//
//  Created by soojin on 7/19/14.
//  Copyright (c) 2014 Recover39. All rights reserved.
//

#import "PNCommentCell.h"
#import "PureLayout.h"
#import "TMPComment.h"

@interface PNCommentCell()

@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *likeCountButton;

@property (nonatomic) BOOL isLiked;

@end

@implementation PNCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.1];
        UIView *superView = self.contentView;
        
        self.contentLabel = [[UILabel alloc] initForAutoLayout];
        [self.contentLabel setNumberOfLines:0];
        [self.contentLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [self.contentLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentLabel setFont:[UIFont systemFontOfSize:15.0f]];
        //self.contentLabel.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
        [superView addSubview:self.contentLabel];
        
        self.dateLabel = [[UILabel alloc] initForAutoLayout];
        [self.dateLabel setNumberOfLines:1];
        [self.dateLabel setFont:[UIFont systemFontOfSize:12.0f]];
        //self.dateLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
        [superView addSubview:self.dateLabel];
        
        self.likeButton = [[UIButton alloc] initForAutoLayout];
        [self.likeButton addTarget:self action:@selector(likeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.likeButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        //self.likeButton.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.1];
        //self.likeButton.backgroundColor = [UIColor yellowColor];
        [self.likeButton sizeToFit];
        [superView addSubview:self.likeButton];
        
//        self.likeCountLabel = [[UILabel alloc] initForAutoLayout];
//        [self.likeCountLabel setNumberOfLines:1];
//        [self.likeCountLabel setFont:[UIFont systemFontOfSize:12.0f]];
//        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
//        UIImage *heartIcon = [UIImage imageNamed:@"hearted.png"];
//        attachment.image = heartIcon;
//        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
//        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithAttributedString:attachmentString];
//        [labelString appendAttributedString:[[NSAttributedString alloc] initWithString:@""]];
//        self.likeCountLabel.attributedText = labelString;
//        [self.likeCountLabel sizeToFit];
//        [superView addSubview:self.likeCountLabel];
        
        self.likeCountButton = [[UIButton alloc] initForAutoLayout];
        [self.likeCountButton setImage:[UIImage imageNamed:@"hearted.png"] forState:UIControlStateNormal];
        [self.likeCountButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
        [self.likeCountButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [self.likeCountButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.likeCountButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.likeCountButton setEnabled:NO];
        [self.likeCountButton sizeToFit];
        [superView addSubview:self.likeCountButton];
        
    }
    return self;
}

- (void)awakeFromNib
{
    //Initialization code
}

- (void)updateConstraints
{
    NSLayoutConstraint *cL1 = [NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:13.0f];
    NSLayoutConstraint *cL2 = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentLabel attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:35.0f];
    NSLayoutConstraint *cL3 = [NSLayoutConstraint constraintWithItem:self.contentLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:13.0f];
    
    NSLayoutConstraint *dL1 = [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:13.0f];
    NSLayoutConstraint *dL2 = [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:2.0f];
    NSLayoutConstraint *dL3 = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:7.0f];
    dL3.priority = 750;
    
    NSLayoutConstraint *lB1 = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:10.0f];
    NSLayoutConstraint *lB2 = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:2.0f];
    NSLayoutConstraint *lB3 = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.likeButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:7.0f];
    NSLayoutConstraint *lB4 = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
    NSLayoutConstraint *heightlB = [NSLayoutConstraint constraintWithItem:self.likeButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.dateLabel attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *lC1 = [NSLayoutConstraint constraintWithItem:self.likeCountButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.likeButton attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:5.0f];
    NSLayoutConstraint *lC2 = [NSLayoutConstraint constraintWithItem:self.likeCountButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:2.0f];
    NSLayoutConstraint *lC3 = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.likeCountButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:7.0f];
    NSLayoutConstraint *heightlC = [NSLayoutConstraint constraintWithItem:self.likeCountButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.likeButton attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0];
    
    [self.contentView addConstraints:@[cL1, cL2, cL3, dL1, dL2, dL3, lB1, lB2, lB3, lB4, heightlB, lC1, lC2, lC3, heightlC]];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];    
    self.contentLabel.preferredMaxLayoutWidth = self.contentLabel.frame.size.width;
    [super layoutSubviews];
}

- (void)configureCellWithComment:(TMPComment *)comment
{
    self.comment = comment;
    self.contentLabel.text = comment.content;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [formatter stringFromDate:comment.publishedDate];
    self.isLiked = [comment.userLiked boolValue];
    if (self.isLiked) {
        [self.likeButton setTitle:@"좋아요 취소" forState:UIControlStateNormal];
    } else {
        [self.likeButton setTitle:@"좋아요" forState:UIControlStateNormal];
    }
    
    NSNumber *likeCount = comment.likeCount;
    [self.likeCountButton setTitle:[NSString stringWithFormat:@"%@", likeCount] forState:UIControlStateNormal];
    if ([likeCount isEqualToNumber:@0] || likeCount == nil) {
        self.likeCountButton.hidden = YES;
    } else {
        self.likeCountButton.hidden = NO;
    }
    
    switch ([comment.commentType intValue]) {
        case 0:
            //Normal Comment
            break;
        case 1:
            //my comment
            self.contentView.backgroundColor = [UIColor colorWithRed:255.0/255.0f green:141.0/255.0f blue:129.0/255.0f alpha:1.0f];
            break;
        case 2:
            //thread author's comment
            self.contentView.backgroundColor = [UIColor colorWithRed:189.0/255.0f green:158.0/255.0f blue:255.0/255.0f alpha:1.0f];
            break;
        case 3:
            //I'm the thread author AND comment writer
            self.contentView.backgroundColor = [UIColor colorWithRed:255.0/255.0f green:141.0/255.0f blue:129.0/255.0f alpha:1.0f];
            break;
        default:
            break;
    }
}

- (void)likeButtonPressed
{
    if (self.isLiked) {
        //Cancel Like
        [self cancelLike];
    } else {
        //Like!
        [self likeComment];
    }
}

- (void)likeComment
{
    NSError *error;
    NSString *urlString = [NSString stringWithFormat:@"http://%@/comments/%@/like", kMainServerURL, self.comment.commentID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *contentDictionary = @{@"user" : kUserID};
    NSData *contentData = [NSJSONSerialization dataWithJSONObject:contentDictionary options:0 error:&error];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setHTTPBody:contentData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            //NSLog(@"Data : %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if ([httpResponse statusCode] == 200) {
                //SUCCESS!
                self.isLiked = YES;
                self.comment.likeCount = @([self.comment.likeCount intValue] + 1);
                self.comment.userLiked = [NSNumber numberWithBool:YES];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"like success");
                    self.likeCountButton.titleLabel.text = [self.comment.likeCount stringValue];
                    self.likeCountButton.hidden = NO;
                    [self.likeButton setTitle:@"좋아요 취소" forState:UIControlStateNormal];
                });
            } else NSLog(@"HTTP %ld Error", (long)[httpResponse statusCode]);
        } else {
            NSLog(@"Error : %@", error);
        }
    }];
    [task resume];
}

- (void)cancelLike
{
    NSError *error;
    NSString *urlString = [NSString stringWithFormat:@"http://%@/comments/%@/unlike", kMainServerURL, self.comment.commentID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSDictionary *contentDictionary = @{@"user" : kUserID};
    NSData *contentData = [NSJSONSerialization dataWithJSONObject:contentDictionary options:0 error:&error];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setHTTPBody:contentData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            //NSLog(@"Data : %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if ([httpResponse statusCode] == 200) {
                //SUCCESS!
                self.isLiked = NO;
                self.comment.likeCount = @([self.comment.likeCount intValue] - 1);
                self.comment.userLiked = [NSNumber numberWithBool:NO];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"unlike success");
                    if ([self.comment.likeCount isEqualToNumber:@0]) {
                        self.likeCountButton.hidden = YES;
                    }
                    self.likeCountButton.titleLabel.text = [self.comment.likeCount stringValue];
                    [self.likeButton setTitle:@"좋아요" forState:UIControlStateNormal];
                });
            } else NSLog(@"HTTP %ld Error", (long)[httpResponse statusCode]);
        } else {
            NSLog(@"Error : %@", error);
        }
    }];
    [task resume];
}

@end
