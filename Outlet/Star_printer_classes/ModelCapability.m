//
//  ModelCapability.m
//  ObjectiveC SDK
//
//  Created by Yuji on 2015/**/**.
//  Copyright © 2015年 Star Micronics. All rights reserved.
//

#import "ModelCapability.h"

typedef NS_ENUM(NSInteger, ModelCapabilityIndex) {
    ModelCapabilityIndexTitle = 0,
    ModelCapabilityIndexEmulation,
    ModelCapabilityIndexCashDrawerOpenActive,
    ModelCapabilityIndexPortSettings,
    ModelCapabilityIndexModelNameArray
};

static const NSArray      *_modelIndexArray;
static const NSDictionary *_modelCapabilityDictionary;

@implementation ModelCapability

+ (void)initialize {
    if (self == [ModelCapability class]) {
        _modelIndexArray = @ [
            @(ModelIndexMPOP),
            @(ModelIndexFVP10),
            @(ModelIndexTSP100),
            @(ModelIndexTSP650II),
            @(ModelIndexTSP700II),
            @(ModelIndexTSP800II),
            @(ModelIndexSP700),                 // <-
            @(ModelIndexSM_S210I),
            @(ModelIndexSM_S220I),
            @(ModelIndexSM_S230I),
            @(ModelIndexSM_T300I),
            @(ModelIndexSM_T400I),
            @(ModelIndexSM_L200),               // <-
            @(ModelIndexSM_L300),               // <-
            @(ModelIndexBSC10),
            @(ModelIndexSM_S210I_StarPRNT),
            @(ModelIndexSM_S220I_StarPRNT),
            @(ModelIndexSM_S230I_StarPRNT),
            @(ModelIndexSM_T300I_StarPRNT),
            @(ModelIndexSM_T400I_StarPRNT)
//          @(ModelIndexSM_L200),
//          @(ModelIndexSP700),
//          @(ModelIndexSM_L300)
        ];
        
        _modelCapabilityDictionary = @ {
            @(ModelIndexMPOP)              : @[@"mPOP",              @(StarIoExtEmulationStarPRNT),      @NO,  @"",         @[@"POP10"]],
            @(ModelIndexFVP10)             : @[@"FVP10",             @(StarIoExtEmulationStarLine),      @YES, @"",         @[@"FVP10 (STR_T-001)"]],      // Only LAN model
            @(ModelIndexTSP100)            : @[@"TSP100",            @(StarIoExtEmulationStarGraphic),   @YES, @"",         @[@"TSP113",
                                                                                                                              @"TSP143"]],
            @(ModelIndexTSP650II)          : @[@"TSP650II",          @(StarIoExtEmulationStarLine),      @YES, @"",         @[@"TSP654II (STR_T-001)",     // Only LAN model->
                                                                                                                              @"TSP654 (STR_T-001)",
                                                                                                                              @"TSP651 (STR_T-001)"]],
            @(ModelIndexTSP700II)          : @[@"TSP700II",          @(StarIoExtEmulationStarLine),      @YES, @"",         @[@"TSP743II (STR_T-001)",
                                                                                                                              @"TSP743 (STR_T-001)"]],
            @(ModelIndexTSP800II)          : @[@"TSP800II",          @(StarIoExtEmulationStarLine),      @YES, @"",         @[@"TSP847II (STR_T-001)",
                                                                                                                              @"TSP847 (STR_T-001)"]],     // <-Only LAN model
            @(ModelIndexSM_S210I)          : @[@"SM-S210i",          @(StarIoExtEmulationEscPosMobile),  @NO,  @"mini",     @[@"SM-S210i"]],               // Sample->
            @(ModelIndexSM_S220I)          : @[@"SM-S220i",          @(StarIoExtEmulationEscPosMobile),  @NO,  @"mini",     @[@"SM-S220i"]],
            @(ModelIndexSM_S230I)          : @[@"SM-S230i",          @(StarIoExtEmulationEscPosMobile),  @NO,  @"mini",     @[@"SM-S230i"]],
            @(ModelIndexSM_T300I)          : @[@"SM-T300i",          @(StarIoExtEmulationEscPosMobile),  @NO,  @"mini",     @[@"SM-T300i"]],
            @(ModelIndexSM_T400I)          : @[@"SM-T400i",          @(StarIoExtEmulationEscPosMobile),  @NO,  @"mini",     @[@"SM-T400i"]],               // <-Sample
            @(ModelIndexBSC10)             : @[@"BSC10",             @(StarIoExtEmulationEscPos),        @YES, @"escpos",   @[@"BSC10"]],
            @(ModelIndexSM_S210I_StarPRNT) : @[@"SM-S210i StarPRNT", @(StarIoExtEmulationStarPRNT),      @NO,  @"Portable", @[@"SM-S210i StarPRNT"]],      // Sample->
            @(ModelIndexSM_S220I_StarPRNT) : @[@"SM-S220i StarPRNT", @(StarIoExtEmulationStarPRNT),      @NO,  @"Portable", @[@"SM-S220i StarPRNT"]],
            @(ModelIndexSM_S230I_StarPRNT) : @[@"SM-S230i StarPRNT", @(StarIoExtEmulationStarPRNT),      @NO,  @"Portable", @[@"SM-S230i StarPRNT"]],
            @(ModelIndexSM_T300I_StarPRNT) : @[@"SM-T300i StarPRNT", @(StarIoExtEmulationStarPRNT),      @NO,  @"Portable", @[@"SM-T300i StarPRNT"]],
            @(ModelIndexSM_T400I_StarPRNT) : @[@"SM-T400i StarPRNT", @(StarIoExtEmulationStarPRNT),      @NO,  @"Portable", @[@"SM-T400i StarPRNT"]],      // <-Sample
            @(ModelIndexSM_L200)           : @[@"SM-L200",           @(StarIoExtEmulationStarPRNT),      @NO,  @"Portable", @[@"SM-L200"]],
            @(ModelIndexSP700)             : @[@"SP700",             @(StarIoExtEmulationStarDotImpact), @YES, @"",         @[@"SP712 (STR-001)",          // Only LAN model
                                                                                                                              @"SP717 (STR-001)",
                                                                                                                              @"SP742 (STR-001)",
                                                                                                                              @"SP747 (STR-001)"]],
            @(ModelIndexSM_L300)           : @[@"SM-L300",           @(StarIoExtEmulationStarPRNT),      @NO,  @"Portable", @[@"SM-L300"]]
        };
    }
}

+ (NSInteger)modelIndexCount {
    return _modelIndexArray.count;
}

+ (ModelIndex)modelIndexAtIndex:(NSInteger)index {
    return [_modelIndexArray[index] integerValue];
}

+ (NSString *)titleAtModelIndex:(ModelIndex)modelIndex {
    return _modelCapabilityDictionary[@(modelIndex)][ModelCapabilityIndexTitle];
}

+ (StarIoExtEmulation)emulationAtModelIndex:(ModelIndex)modelIndex {
    return [_modelCapabilityDictionary[@(modelIndex)][ModelCapabilityIndexEmulation] integerValue];
}

+ (BOOL)cashDrawerOpenActiveAtModelIndex:(ModelIndex)modelIndex {
    return [_modelCapabilityDictionary[@(modelIndex)][ModelCapabilityIndexCashDrawerOpenActive] boolValue];
}

+ (NSString *)portSettingsAtModelIndex:(ModelIndex)modelIndex {
    return _modelCapabilityDictionary[@(modelIndex)][ModelCapabilityIndexPortSettings];
}

+ (ModelIndex)modelIndexAtModelName:(NSString *)modelName {
    for (id modelIndex in _modelCapabilityDictionary) {
        NSArray *modelNameArray = _modelCapabilityDictionary[modelIndex][ModelCapabilityIndexModelNameArray];
        
        for (int i = 0; i < modelNameArray.count; i++) {
            if ([modelName hasPrefix:modelNameArray[i]] == YES) {
                return [modelIndex integerValue];
            }
        }
    }
    
    return ModelIndexNone;
}

@end
