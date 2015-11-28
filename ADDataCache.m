//
//  ADDataCache.m
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADDataCache.h"
#import "FMDB.h"

@implementation ADDataCache

/*如果我们的 app 需要多线程操作数据库，那么就需要使用 FMDatabaseQueue 来保证线程安全了。
切记不能在多个线程中共同一个 FMDatabase 对象并且在多个线程中同时使用，
 这个类本身不是线程安全的，这样使用会造成数据混乱等问题。
 */
static FMDatabaseQueue *_queue;

+(void)initialize{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"news.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL b = [db executeUpdate:@"create table if not exists info(ID integer primary key autoincrement,data blob,idstr text)"];
        if (!b) {
            NSLog(@"建表失败");
        }
    }];
    
}

//返回数组
+(NSArray *)dataWithDic:(NSString *)ID{
    __block NSMutableArray *arr = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:@"select * from info where idstr=?",ID];
        if (result) {
            arr = [NSMutableArray array];
            while ([result next]) {
                NSData *data = [result dataForColumn:@"data"];
                //转字典
                //NSKeyedUnarchiver   从二进制流读取对象。
                NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                [arr addObject:dict];
            }
        }
    }];
    return arr;
}

//删除旧数据
+(void)deleteWithId:(NSString *)ID{
    [_queue inDatabase:^(FMDatabase *db) {
        //delete from info where idstr='T1348648517839'
        BOOL b = [db executeUpdate:@"delete  from info where idstr=?",ID];
        if (!b) {
            NSLog(@"删除失败");
        }
    }];
}

+(void)addArr:(NSArray *)arr andID:(NSString *)idStr{
    for (NSDictionary *dict in arr) {
        [self addDict:dict andID:idStr];
    }
}
+(void)addDict:(NSDictionary *)dict andID:(NSString *)idStr{
    [_queue inDatabase:^(FMDatabase *db) {
        //二进制流写进数据库
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [db executeUpdate:@"insert into info(data,idstr) values(?,?)",data,idStr];
    }];
    
}
                       

@end
