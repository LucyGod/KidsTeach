
//
//  ASOPublicEnum.h
//  KidTeach
//
//  Created by Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#ifndef FAPPublicEnum
#define FAPPublicEnum


/** 行情详情底部 */
typedef enum : NSUInteger {
    
    marketDetailBottomNews,
    marketDetailBottomVideil,
    marketDetailBottomAbout,
    marketDetailBottomNilData
    
}marketDetailBottom;

/** 网络状态 */
typedef enum : NSUInteger {
    
    NetWorkingStateNotReachable = 0,
    NetWorkingStateReachableViaWWAN = 1,
    NetWorkingStateReachableViaWiFi = 2,
    
}NetWorkingState;

/** 用户状态 */
typedef enum : NSUInteger {
    
    ASOUserStateGuest = 0,          // 游客
    ASOUserStateverified = 1,       // 已登录
}ASOUserState;

/* K线主图样式 */
typedef enum : NSUInteger {
    KLineMainViewTypeKLine = 1,     // K线图(蜡烛图)
    KLineMainViewTypeKLineWithMA,   // K线图包含MA
    KLineMainViewTypeTimeLine,      // 分时图
    KLineMainViewTypeTimeLineWithMA,// 分时图包含MA
    KLineMainViewTypeKLineWithBOLL, // K线图包含BOLL指数
} KLineMainViewType;

/* K线附图样式 */
typedef enum : NSUInteger {
    KLineAssistantViewTypeVol = 1,      // 成交量
    KLineAssistantViewTypeVolWithMA,    // 成交量包含MA
    KLineAssistantViewTypeKDJ,          // KDJ
    KLineAssistantViewTypeMACD,         // MACD
    KLineAssistantViewTypeRSI,          // RSI
} KLineAssistantViewType;


/** 挂单列表的展示数据类型 */
typedef enum : NSUInteger {
    
    OrderBookDisPlayDataTypeAmount,             // 金额 / 币量
    OrderBookDisPlayDataTypeCount,              // 数量
    
}OrderBookDisPlayDataType;

///* 排行榜列表类型 */
//typedef enum : NSUInteger {
//    ASOSimulateRankTypeTotal,       // 总盈利榜
//    ASOSimulateRankTypeShortLine,   // 短线榜
//    ASOSimulateRankTypeSteady,      // 稳健榜
//    ASOSimulateRankTypeSucRate,     // 成功率榜
//    ASOSimulateRankTypeLately,      // 近期牛人
//    ASOSimulateRankTypeUp           // 涨停榜
//} ASOSimulateRankType;
#endif /* ZSHPublicEnum_h */
