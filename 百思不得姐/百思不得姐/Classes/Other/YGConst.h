

#import <UIKit/UIKit.h>

typedef enum {
    YGBaseTopicTypeAll = 1,
    YGBaseTopicTypeVideo = 41,
    YGBaseTopicTypeVoice = 31,
    YGBaseTopicTypePicture = 10,
    YGBaseTopicTypeWord = 29
    
    
} YGBaseTopicType;
/**
 *  精华-导航栏高度
 */
UIKIT_EXTERN CGFloat const YGTitleViewH;
/**
 *  精华-导航栏Y值
 */
UIKIT_EXTERN CGFloat const YGTitleViewY;
/**
 *  精华-cell底部工具条高度
 */
UIKIT_EXTERN CGFloat const YGTopicCellBottomToolH;
/**
 *  精华-cell内部间距
 */
UIKIT_EXTERN CGFloat const YGTopicCellMargin;
/**
 *  精华-cell头像高度 = 宽度
 */
UIKIT_EXTERN CGFloat const YGTopicCellIconH;
/**
 *  大图的判断标准
 */
UIKIT_EXTERN CGFloat const YGTopicPictureMaxH;
/**
 *  裁剪后的高度
 */
UIKIT_EXTERN CGFloat const YGTopicPictureClipH;
/**
 *  用户模型性别属性-女
 */
UIKIT_EXTERN NSString * const YGUserSexFemale;
/**
 *  用户模型性别属性-男
 */
UIKIT_EXTERN NSString * const YGUserSexMale;
/**
 *  最热评论标题的高度
 */
UIKIT_EXTERN CGFloat const YGTopicCellCommentTitleH;
