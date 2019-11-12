//
//  ASOLocalStoragePublicKey.h
//  KidTeach
//
//  Created by Mac on 2019/4/16.
//  Copyright © 2019 GhostLord. All rights reserved.
//

/* 持久化需要用到的部分Key */

#ifndef FAPLocalStoragePublicKey_h
#define FAPLocalStoragePublicKey_h

// 用户信息存储 
#define ASO_ArchiverPath_UserData           [@"ASO_ArchiverPath_UserData" pathInDocumentDirectory]

/* 账号密码表 */
#define ASO_ArchiverPath_Account            [@"ASO_ArchiverPath_Account" pathInDocumentDirectory]

/* 自选列表 */
#define ASO_ArchiverPath_Fav                [@"ASO_ArchiverPath_Fav" pathInDocumentDirectory]

/** 关注列表 */
#define ASO_ArchiverPath_WatchList          [@"ASO_ArchiverPath_WatchList" pathInDocumentDirectory]

/** 模拟炒股持仓列表 */
#define ASO_ArchiverPath_SimulatePostion    [@"ASO_ArchiverPath_SimulatePostion" pathInDocumentDirectory]


#endif /* ASOLocalStoragePublicKey_h */
