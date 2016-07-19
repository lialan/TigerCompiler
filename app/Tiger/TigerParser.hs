{-# OPTIONS_GHC -w #-}
module Tiger.TigerParser where
import Tiger.TigerLanguage
import Tiger.TigerLexer
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26
	= HappyTerminal (TigerLexerToken)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26

action_0 (27) = happyShift action_10
action_0 (28) = happyShift action_11
action_0 (30) = happyShift action_12
action_0 (31) = happyShift action_13
action_0 (38) = happyShift action_14
action_0 (43) = happyShift action_15
action_0 (44) = happyShift action_16
action_0 (45) = happyShift action_17
action_0 (46) = happyShift action_18
action_0 (50) = happyShift action_19
action_0 (4) = happyGoto action_20
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 (9) = happyGoto action_6
action_0 (10) = happyGoto action_7
action_0 (13) = happyGoto action_8
action_0 (26) = happyGoto action_9
action_0 _ = happyFail

action_1 (27) = happyShift action_10
action_1 (28) = happyShift action_11
action_1 (30) = happyShift action_12
action_1 (31) = happyShift action_13
action_1 (38) = happyShift action_14
action_1 (43) = happyShift action_15
action_1 (44) = happyShift action_16
action_1 (45) = happyShift action_17
action_1 (46) = happyShift action_18
action_1 (50) = happyShift action_19
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 (9) = happyGoto action_6
action_1 (10) = happyGoto action_7
action_1 (13) = happyGoto action_8
action_1 (26) = happyGoto action_9
action_1 _ = happyFail

action_2 (57) = happyShift action_33
action_2 (58) = happyShift action_34
action_2 (59) = happyShift action_35
action_2 (60) = happyShift action_36
action_2 (61) = happyShift action_37
action_2 (62) = happyShift action_38
action_2 (63) = happyShift action_39
action_2 (64) = happyShift action_40
action_2 (65) = happyShift action_41
action_2 (66) = happyShift action_42
action_2 (68) = happyShift action_43
action_2 (69) = happyShift action_44
action_2 _ = happyReduce_1

action_3 _ = happyReduce_7

action_4 _ = happyReduce_8

action_5 _ = happyReduce_9

action_6 _ = happyReduce_10

action_7 _ = happyReduce_11

action_8 _ = happyReduce_12

action_9 (50) = happyShift action_30
action_9 (56) = happyShift action_31
action_9 (67) = happyShift action_32
action_9 _ = happyReduce_2

action_10 (27) = happyShift action_10
action_10 (28) = happyShift action_11
action_10 (30) = happyShift action_12
action_10 (31) = happyShift action_13
action_10 (38) = happyShift action_14
action_10 (43) = happyShift action_15
action_10 (44) = happyShift action_16
action_10 (45) = happyShift action_17
action_10 (46) = happyShift action_18
action_10 (50) = happyShift action_19
action_10 (5) = happyGoto action_29
action_10 (6) = happyGoto action_3
action_10 (7) = happyGoto action_4
action_10 (8) = happyGoto action_5
action_10 (9) = happyGoto action_6
action_10 (10) = happyGoto action_7
action_10 (13) = happyGoto action_8
action_10 (26) = happyGoto action_9
action_10 _ = happyFail

action_11 (44) = happyShift action_28
action_11 _ = happyFail

action_12 _ = happyReduce_18

action_13 (14) = happyGoto action_27
action_13 _ = happyReduce_40

action_14 (27) = happyShift action_10
action_14 (28) = happyShift action_11
action_14 (30) = happyShift action_12
action_14 (31) = happyShift action_13
action_14 (38) = happyShift action_14
action_14 (43) = happyShift action_15
action_14 (44) = happyShift action_16
action_14 (45) = happyShift action_17
action_14 (46) = happyShift action_18
action_14 (50) = happyShift action_19
action_14 (5) = happyGoto action_26
action_14 (6) = happyGoto action_3
action_14 (7) = happyGoto action_4
action_14 (8) = happyGoto action_5
action_14 (9) = happyGoto action_6
action_14 (10) = happyGoto action_7
action_14 (13) = happyGoto action_8
action_14 (26) = happyGoto action_9
action_14 _ = happyFail

action_15 _ = happyReduce_3

action_16 (50) = happyShift action_24
action_16 (52) = happyShift action_25
action_16 _ = happyReduce_66

action_17 _ = happyReduce_5

action_18 _ = happyReduce_6

action_19 (27) = happyShift action_10
action_19 (28) = happyShift action_11
action_19 (30) = happyShift action_12
action_19 (31) = happyShift action_13
action_19 (38) = happyShift action_14
action_19 (43) = happyShift action_15
action_19 (44) = happyShift action_16
action_19 (45) = happyShift action_17
action_19 (46) = happyShift action_18
action_19 (50) = happyShift action_19
action_19 (51) = happyShift action_23
action_19 (5) = happyGoto action_21
action_19 (6) = happyGoto action_3
action_19 (7) = happyGoto action_4
action_19 (8) = happyGoto action_5
action_19 (9) = happyGoto action_6
action_19 (10) = happyGoto action_7
action_19 (13) = happyGoto action_8
action_19 (24) = happyGoto action_22
action_19 (26) = happyGoto action_9
action_19 _ = happyFail

action_20 (70) = happyAccept
action_20 _ = happyFail

action_21 (57) = happyShift action_33
action_21 (58) = happyShift action_34
action_21 (59) = happyShift action_35
action_21 (60) = happyShift action_36
action_21 (61) = happyShift action_37
action_21 (62) = happyShift action_38
action_21 (63) = happyShift action_39
action_21 (64) = happyShift action_40
action_21 (65) = happyShift action_41
action_21 (66) = happyShift action_42
action_21 (68) = happyShift action_43
action_21 (69) = happyShift action_44
action_21 _ = happyReduce_61

action_22 (49) = happyShift action_77
action_22 (51) = happyShift action_78
action_22 _ = happyFail

action_23 _ = happyReduce_4

action_24 (27) = happyShift action_10
action_24 (28) = happyShift action_11
action_24 (30) = happyShift action_12
action_24 (31) = happyShift action_13
action_24 (38) = happyShift action_14
action_24 (43) = happyShift action_15
action_24 (44) = happyShift action_76
action_24 (45) = happyShift action_17
action_24 (46) = happyShift action_18
action_24 (47) = happyReduce_63
action_24 (50) = happyShift action_19
action_24 (51) = happyReduce_63
action_24 (5) = happyGoto action_72
action_24 (6) = happyGoto action_3
action_24 (7) = happyGoto action_4
action_24 (8) = happyGoto action_5
action_24 (9) = happyGoto action_6
action_24 (10) = happyGoto action_7
action_24 (11) = happyGoto action_73
action_24 (12) = happyGoto action_74
action_24 (13) = happyGoto action_8
action_24 (25) = happyGoto action_75
action_24 (26) = happyGoto action_9
action_24 _ = happyReduce_63

action_25 (27) = happyShift action_10
action_25 (28) = happyShift action_11
action_25 (30) = happyShift action_12
action_25 (31) = happyShift action_13
action_25 (38) = happyShift action_14
action_25 (43) = happyShift action_15
action_25 (44) = happyShift action_16
action_25 (45) = happyShift action_17
action_25 (46) = happyShift action_18
action_25 (50) = happyShift action_19
action_25 (5) = happyGoto action_71
action_25 (6) = happyGoto action_3
action_25 (7) = happyGoto action_4
action_25 (8) = happyGoto action_5
action_25 (9) = happyGoto action_6
action_25 (10) = happyGoto action_7
action_25 (13) = happyGoto action_8
action_25 (26) = happyGoto action_9
action_25 _ = happyFail

action_26 (39) = happyShift action_70
action_26 (57) = happyShift action_33
action_26 (58) = happyShift action_34
action_26 (59) = happyShift action_35
action_26 (60) = happyShift action_36
action_26 (61) = happyShift action_37
action_26 (62) = happyShift action_38
action_26 (63) = happyShift action_39
action_26 (64) = happyShift action_40
action_26 (65) = happyShift action_41
action_26 (66) = happyShift action_42
action_26 (68) = happyShift action_43
action_26 (69) = happyShift action_44
action_26 _ = happyFail

action_27 (32) = happyShift action_67
action_27 (35) = happyShift action_68
action_27 (36) = happyShift action_69
action_27 (15) = happyGoto action_62
action_27 (16) = happyGoto action_63
action_27 (17) = happyGoto action_64
action_27 (18) = happyGoto action_65
action_27 (19) = happyGoto action_66
action_27 _ = happyReduce_50

action_28 (67) = happyShift action_61
action_28 _ = happyFail

action_29 (41) = happyShift action_60
action_29 (57) = happyShift action_33
action_29 (58) = happyShift action_34
action_29 (59) = happyShift action_35
action_29 (60) = happyShift action_36
action_29 (61) = happyShift action_37
action_29 (62) = happyShift action_38
action_29 (63) = happyShift action_39
action_29 (64) = happyShift action_40
action_29 (65) = happyShift action_41
action_29 (66) = happyShift action_42
action_29 (68) = happyShift action_43
action_29 (69) = happyShift action_44
action_29 _ = happyFail

action_30 (27) = happyShift action_10
action_30 (28) = happyShift action_11
action_30 (30) = happyShift action_12
action_30 (31) = happyShift action_13
action_30 (38) = happyShift action_14
action_30 (43) = happyShift action_15
action_30 (44) = happyShift action_16
action_30 (45) = happyShift action_17
action_30 (46) = happyShift action_18
action_30 (50) = happyShift action_19
action_30 (5) = happyGoto action_59
action_30 (6) = happyGoto action_3
action_30 (7) = happyGoto action_4
action_30 (8) = happyGoto action_5
action_30 (9) = happyGoto action_6
action_30 (10) = happyGoto action_7
action_30 (13) = happyGoto action_8
action_30 (26) = happyGoto action_9
action_30 _ = happyFail

action_31 (44) = happyShift action_58
action_31 _ = happyFail

action_32 (27) = happyShift action_10
action_32 (28) = happyShift action_11
action_32 (30) = happyShift action_12
action_32 (31) = happyShift action_13
action_32 (38) = happyShift action_14
action_32 (43) = happyShift action_15
action_32 (44) = happyShift action_16
action_32 (45) = happyShift action_17
action_32 (46) = happyShift action_18
action_32 (50) = happyShift action_19
action_32 (5) = happyGoto action_57
action_32 (6) = happyGoto action_3
action_32 (7) = happyGoto action_4
action_32 (8) = happyGoto action_5
action_32 (9) = happyGoto action_6
action_32 (10) = happyGoto action_7
action_32 (13) = happyGoto action_8
action_32 (26) = happyGoto action_9
action_32 _ = happyFail

action_33 (27) = happyShift action_10
action_33 (28) = happyShift action_11
action_33 (30) = happyShift action_12
action_33 (31) = happyShift action_13
action_33 (38) = happyShift action_14
action_33 (43) = happyShift action_15
action_33 (44) = happyShift action_16
action_33 (45) = happyShift action_17
action_33 (46) = happyShift action_18
action_33 (50) = happyShift action_19
action_33 (5) = happyGoto action_56
action_33 (6) = happyGoto action_3
action_33 (7) = happyGoto action_4
action_33 (8) = happyGoto action_5
action_33 (9) = happyGoto action_6
action_33 (10) = happyGoto action_7
action_33 (13) = happyGoto action_8
action_33 (26) = happyGoto action_9
action_33 _ = happyFail

action_34 (27) = happyShift action_10
action_34 (28) = happyShift action_11
action_34 (30) = happyShift action_12
action_34 (31) = happyShift action_13
action_34 (38) = happyShift action_14
action_34 (43) = happyShift action_15
action_34 (44) = happyShift action_16
action_34 (45) = happyShift action_17
action_34 (46) = happyShift action_18
action_34 (50) = happyShift action_19
action_34 (5) = happyGoto action_55
action_34 (6) = happyGoto action_3
action_34 (7) = happyGoto action_4
action_34 (8) = happyGoto action_5
action_34 (9) = happyGoto action_6
action_34 (10) = happyGoto action_7
action_34 (13) = happyGoto action_8
action_34 (26) = happyGoto action_9
action_34 _ = happyFail

action_35 (27) = happyShift action_10
action_35 (28) = happyShift action_11
action_35 (30) = happyShift action_12
action_35 (31) = happyShift action_13
action_35 (38) = happyShift action_14
action_35 (43) = happyShift action_15
action_35 (44) = happyShift action_16
action_35 (45) = happyShift action_17
action_35 (46) = happyShift action_18
action_35 (50) = happyShift action_19
action_35 (5) = happyGoto action_54
action_35 (6) = happyGoto action_3
action_35 (7) = happyGoto action_4
action_35 (8) = happyGoto action_5
action_35 (9) = happyGoto action_6
action_35 (10) = happyGoto action_7
action_35 (13) = happyGoto action_8
action_35 (26) = happyGoto action_9
action_35 _ = happyFail

action_36 (27) = happyShift action_10
action_36 (28) = happyShift action_11
action_36 (30) = happyShift action_12
action_36 (31) = happyShift action_13
action_36 (38) = happyShift action_14
action_36 (43) = happyShift action_15
action_36 (44) = happyShift action_16
action_36 (45) = happyShift action_17
action_36 (46) = happyShift action_18
action_36 (50) = happyShift action_19
action_36 (5) = happyGoto action_53
action_36 (6) = happyGoto action_3
action_36 (7) = happyGoto action_4
action_36 (8) = happyGoto action_5
action_36 (9) = happyGoto action_6
action_36 (10) = happyGoto action_7
action_36 (13) = happyGoto action_8
action_36 (26) = happyGoto action_9
action_36 _ = happyFail

action_37 (27) = happyShift action_10
action_37 (28) = happyShift action_11
action_37 (30) = happyShift action_12
action_37 (31) = happyShift action_13
action_37 (38) = happyShift action_14
action_37 (43) = happyShift action_15
action_37 (44) = happyShift action_16
action_37 (45) = happyShift action_17
action_37 (46) = happyShift action_18
action_37 (50) = happyShift action_19
action_37 (5) = happyGoto action_52
action_37 (6) = happyGoto action_3
action_37 (7) = happyGoto action_4
action_37 (8) = happyGoto action_5
action_37 (9) = happyGoto action_6
action_37 (10) = happyGoto action_7
action_37 (13) = happyGoto action_8
action_37 (26) = happyGoto action_9
action_37 _ = happyFail

action_38 (27) = happyShift action_10
action_38 (28) = happyShift action_11
action_38 (30) = happyShift action_12
action_38 (31) = happyShift action_13
action_38 (38) = happyShift action_14
action_38 (43) = happyShift action_15
action_38 (44) = happyShift action_16
action_38 (45) = happyShift action_17
action_38 (46) = happyShift action_18
action_38 (50) = happyShift action_19
action_38 (5) = happyGoto action_51
action_38 (6) = happyGoto action_3
action_38 (7) = happyGoto action_4
action_38 (8) = happyGoto action_5
action_38 (9) = happyGoto action_6
action_38 (10) = happyGoto action_7
action_38 (13) = happyGoto action_8
action_38 (26) = happyGoto action_9
action_38 _ = happyFail

action_39 (27) = happyShift action_10
action_39 (28) = happyShift action_11
action_39 (30) = happyShift action_12
action_39 (31) = happyShift action_13
action_39 (38) = happyShift action_14
action_39 (43) = happyShift action_15
action_39 (44) = happyShift action_16
action_39 (45) = happyShift action_17
action_39 (46) = happyShift action_18
action_39 (50) = happyShift action_19
action_39 (5) = happyGoto action_50
action_39 (6) = happyGoto action_3
action_39 (7) = happyGoto action_4
action_39 (8) = happyGoto action_5
action_39 (9) = happyGoto action_6
action_39 (10) = happyGoto action_7
action_39 (13) = happyGoto action_8
action_39 (26) = happyGoto action_9
action_39 _ = happyFail

action_40 (27) = happyShift action_10
action_40 (28) = happyShift action_11
action_40 (30) = happyShift action_12
action_40 (31) = happyShift action_13
action_40 (38) = happyShift action_14
action_40 (43) = happyShift action_15
action_40 (44) = happyShift action_16
action_40 (45) = happyShift action_17
action_40 (46) = happyShift action_18
action_40 (50) = happyShift action_19
action_40 (5) = happyGoto action_49
action_40 (6) = happyGoto action_3
action_40 (7) = happyGoto action_4
action_40 (8) = happyGoto action_5
action_40 (9) = happyGoto action_6
action_40 (10) = happyGoto action_7
action_40 (13) = happyGoto action_8
action_40 (26) = happyGoto action_9
action_40 _ = happyFail

action_41 (27) = happyShift action_10
action_41 (28) = happyShift action_11
action_41 (30) = happyShift action_12
action_41 (31) = happyShift action_13
action_41 (38) = happyShift action_14
action_41 (43) = happyShift action_15
action_41 (44) = happyShift action_16
action_41 (45) = happyShift action_17
action_41 (46) = happyShift action_18
action_41 (50) = happyShift action_19
action_41 (5) = happyGoto action_48
action_41 (6) = happyGoto action_3
action_41 (7) = happyGoto action_4
action_41 (8) = happyGoto action_5
action_41 (9) = happyGoto action_6
action_41 (10) = happyGoto action_7
action_41 (13) = happyGoto action_8
action_41 (26) = happyGoto action_9
action_41 _ = happyFail

action_42 (27) = happyShift action_10
action_42 (28) = happyShift action_11
action_42 (30) = happyShift action_12
action_42 (31) = happyShift action_13
action_42 (38) = happyShift action_14
action_42 (43) = happyShift action_15
action_42 (44) = happyShift action_16
action_42 (45) = happyShift action_17
action_42 (46) = happyShift action_18
action_42 (50) = happyShift action_19
action_42 (5) = happyGoto action_47
action_42 (6) = happyGoto action_3
action_42 (7) = happyGoto action_4
action_42 (8) = happyGoto action_5
action_42 (9) = happyGoto action_6
action_42 (10) = happyGoto action_7
action_42 (13) = happyGoto action_8
action_42 (26) = happyGoto action_9
action_42 _ = happyFail

action_43 (27) = happyShift action_10
action_43 (28) = happyShift action_11
action_43 (30) = happyShift action_12
action_43 (31) = happyShift action_13
action_43 (38) = happyShift action_14
action_43 (43) = happyShift action_15
action_43 (44) = happyShift action_16
action_43 (45) = happyShift action_17
action_43 (46) = happyShift action_18
action_43 (50) = happyShift action_19
action_43 (5) = happyGoto action_46
action_43 (6) = happyGoto action_3
action_43 (7) = happyGoto action_4
action_43 (8) = happyGoto action_5
action_43 (9) = happyGoto action_6
action_43 (10) = happyGoto action_7
action_43 (13) = happyGoto action_8
action_43 (26) = happyGoto action_9
action_43 _ = happyFail

action_44 (27) = happyShift action_10
action_44 (28) = happyShift action_11
action_44 (30) = happyShift action_12
action_44 (31) = happyShift action_13
action_44 (38) = happyShift action_14
action_44 (43) = happyShift action_15
action_44 (44) = happyShift action_16
action_44 (45) = happyShift action_17
action_44 (46) = happyShift action_18
action_44 (50) = happyShift action_19
action_44 (5) = happyGoto action_45
action_44 (6) = happyGoto action_3
action_44 (7) = happyGoto action_4
action_44 (8) = happyGoto action_5
action_44 (9) = happyGoto action_6
action_44 (10) = happyGoto action_7
action_44 (13) = happyGoto action_8
action_44 (26) = happyGoto action_9
action_44 _ = happyFail

action_45 (57) = happyShift action_33
action_45 (58) = happyShift action_34
action_45 (59) = happyShift action_35
action_45 (60) = happyShift action_36
action_45 (61) = happyShift action_37
action_45 (62) = happyShift action_38
action_45 (63) = happyShift action_39
action_45 (64) = happyShift action_40
action_45 (65) = happyShift action_41
action_45 (66) = happyShift action_42
action_45 (68) = happyShift action_43
action_45 (69) = happyShift action_44
action_45 _ = happyReduce_33

action_46 (57) = happyShift action_33
action_46 (58) = happyShift action_34
action_46 (59) = happyShift action_35
action_46 (60) = happyShift action_36
action_46 (61) = happyShift action_37
action_46 (62) = happyShift action_38
action_46 (63) = happyShift action_39
action_46 (64) = happyShift action_40
action_46 (65) = happyShift action_41
action_46 (66) = happyShift action_42
action_46 (68) = happyShift action_43
action_46 (69) = happyShift action_44
action_46 _ = happyReduce_32

action_47 (57) = happyShift action_33
action_47 (58) = happyShift action_34
action_47 (59) = happyShift action_35
action_47 (60) = happyShift action_36
action_47 (61) = happyShift action_37
action_47 (62) = happyShift action_38
action_47 (63) = happyShift action_39
action_47 (64) = happyShift action_40
action_47 (65) = happyShift action_41
action_47 (66) = happyShift action_42
action_47 (68) = happyShift action_43
action_47 (69) = happyShift action_44
action_47 _ = happyReduce_29

action_48 (57) = happyShift action_33
action_48 (58) = happyShift action_34
action_48 (59) = happyShift action_35
action_48 (60) = happyShift action_36
action_48 (61) = happyShift action_37
action_48 (62) = happyShift action_38
action_48 (63) = happyShift action_39
action_48 (64) = happyShift action_40
action_48 (65) = happyShift action_41
action_48 (66) = happyShift action_42
action_48 (68) = happyShift action_43
action_48 (69) = happyShift action_44
action_48 _ = happyReduce_28

action_49 (57) = happyShift action_33
action_49 (58) = happyShift action_34
action_49 (59) = happyShift action_35
action_49 (60) = happyShift action_36
action_49 (61) = happyShift action_37
action_49 (62) = happyShift action_38
action_49 (63) = happyShift action_39
action_49 (64) = happyShift action_40
action_49 (65) = happyShift action_41
action_49 (66) = happyShift action_42
action_49 (68) = happyShift action_43
action_49 (69) = happyShift action_44
action_49 _ = happyReduce_31

action_50 (57) = happyShift action_33
action_50 (58) = happyShift action_34
action_50 (59) = happyShift action_35
action_50 (60) = happyShift action_36
action_50 (61) = happyShift action_37
action_50 (62) = happyShift action_38
action_50 (63) = happyShift action_39
action_50 (64) = happyShift action_40
action_50 (65) = happyShift action_41
action_50 (66) = happyShift action_42
action_50 (68) = happyShift action_43
action_50 (69) = happyShift action_44
action_50 _ = happyReduce_30

action_51 (57) = happyShift action_33
action_51 (58) = happyShift action_34
action_51 (59) = happyShift action_35
action_51 (60) = happyShift action_36
action_51 (61) = happyShift action_37
action_51 (62) = happyShift action_38
action_51 (63) = happyShift action_39
action_51 (64) = happyShift action_40
action_51 (65) = happyShift action_41
action_51 (66) = happyShift action_42
action_51 (68) = happyShift action_43
action_51 (69) = happyShift action_44
action_51 _ = happyReduce_27

action_52 (57) = happyShift action_33
action_52 (58) = happyShift action_34
action_52 (59) = happyShift action_35
action_52 (60) = happyShift action_36
action_52 (61) = happyShift action_37
action_52 (62) = happyShift action_38
action_52 (63) = happyShift action_39
action_52 (64) = happyShift action_40
action_52 (65) = happyShift action_41
action_52 (66) = happyShift action_42
action_52 (68) = happyShift action_43
action_52 (69) = happyShift action_44
action_52 _ = happyReduce_26

action_53 (57) = happyShift action_33
action_53 (58) = happyShift action_34
action_53 (59) = happyShift action_35
action_53 (60) = happyShift action_36
action_53 (61) = happyShift action_37
action_53 (62) = happyShift action_38
action_53 (63) = happyShift action_39
action_53 (64) = happyShift action_40
action_53 (65) = happyShift action_41
action_53 (66) = happyShift action_42
action_53 (68) = happyShift action_43
action_53 (69) = happyShift action_44
action_53 _ = happyReduce_25

action_54 (57) = happyShift action_33
action_54 (58) = happyShift action_34
action_54 (59) = happyShift action_35
action_54 (60) = happyShift action_36
action_54 (61) = happyShift action_37
action_54 (62) = happyShift action_38
action_54 (63) = happyShift action_39
action_54 (64) = happyShift action_40
action_54 (65) = happyShift action_41
action_54 (66) = happyShift action_42
action_54 (68) = happyShift action_43
action_54 (69) = happyShift action_44
action_54 _ = happyReduce_24

action_55 (57) = happyShift action_33
action_55 (58) = happyShift action_34
action_55 (59) = happyShift action_35
action_55 (60) = happyShift action_36
action_55 (61) = happyShift action_37
action_55 (62) = happyShift action_38
action_55 (63) = happyShift action_39
action_55 (64) = happyShift action_40
action_55 (65) = happyShift action_41
action_55 (66) = happyShift action_42
action_55 (68) = happyShift action_43
action_55 (69) = happyShift action_44
action_55 _ = happyReduce_23

action_56 (57) = happyShift action_33
action_56 (58) = happyShift action_34
action_56 (59) = happyShift action_35
action_56 (60) = happyShift action_36
action_56 (61) = happyShift action_37
action_56 (62) = happyShift action_38
action_56 (63) = happyShift action_39
action_56 (64) = happyShift action_40
action_56 (65) = happyShift action_41
action_56 (66) = happyShift action_42
action_56 (68) = happyShift action_43
action_56 (69) = happyShift action_44
action_56 _ = happyReduce_22

action_57 (57) = happyShift action_33
action_57 (58) = happyShift action_34
action_57 (59) = happyShift action_35
action_57 (60) = happyShift action_36
action_57 (61) = happyShift action_37
action_57 (62) = happyShift action_38
action_57 (63) = happyShift action_39
action_57 (64) = happyShift action_40
action_57 (65) = happyShift action_41
action_57 (66) = happyShift action_42
action_57 (68) = happyShift action_43
action_57 (69) = happyShift action_44
action_57 _ = happyReduce_13

action_58 _ = happyReduce_69

action_59 (51) = happyShift action_96
action_59 (57) = happyShift action_33
action_59 (58) = happyShift action_34
action_59 (59) = happyShift action_35
action_59 (60) = happyShift action_36
action_59 (61) = happyShift action_37
action_59 (62) = happyShift action_38
action_59 (63) = happyShift action_39
action_59 (64) = happyShift action_40
action_59 (65) = happyShift action_41
action_59 (66) = happyShift action_42
action_59 (68) = happyShift action_43
action_59 (69) = happyShift action_44
action_59 _ = happyFail

action_60 (27) = happyShift action_10
action_60 (28) = happyShift action_11
action_60 (30) = happyShift action_12
action_60 (31) = happyShift action_13
action_60 (38) = happyShift action_14
action_60 (43) = happyShift action_15
action_60 (44) = happyShift action_16
action_60 (45) = happyShift action_17
action_60 (46) = happyShift action_18
action_60 (50) = happyShift action_19
action_60 (5) = happyGoto action_95
action_60 (6) = happyGoto action_3
action_60 (7) = happyGoto action_4
action_60 (8) = happyGoto action_5
action_60 (9) = happyGoto action_6
action_60 (10) = happyGoto action_7
action_60 (13) = happyGoto action_8
action_60 (26) = happyGoto action_9
action_60 _ = happyFail

action_61 (27) = happyShift action_10
action_61 (28) = happyShift action_11
action_61 (30) = happyShift action_12
action_61 (31) = happyShift action_13
action_61 (38) = happyShift action_14
action_61 (43) = happyShift action_15
action_61 (44) = happyShift action_16
action_61 (45) = happyShift action_17
action_61 (46) = happyShift action_18
action_61 (50) = happyShift action_19
action_61 (5) = happyGoto action_94
action_61 (6) = happyGoto action_3
action_61 (7) = happyGoto action_4
action_61 (8) = happyGoto action_5
action_61 (9) = happyGoto action_6
action_61 (10) = happyGoto action_7
action_61 (13) = happyGoto action_8
action_61 (26) = happyGoto action_9
action_61 _ = happyFail

action_62 _ = happyReduce_41

action_63 _ = happyReduce_46

action_64 (36) = happyShift action_69
action_64 (16) = happyGoto action_93
action_64 _ = happyReduce_42

action_65 _ = happyReduce_43

action_66 (34) = happyShift action_92
action_66 (20) = happyGoto action_91
action_66 _ = happyReduce_44

action_67 (27) = happyShift action_10
action_67 (28) = happyShift action_11
action_67 (30) = happyShift action_12
action_67 (31) = happyShift action_13
action_67 (38) = happyShift action_14
action_67 (43) = happyShift action_15
action_67 (44) = happyShift action_16
action_67 (45) = happyShift action_17
action_67 (46) = happyShift action_18
action_67 (50) = happyShift action_19
action_67 (5) = happyGoto action_90
action_67 (6) = happyGoto action_3
action_67 (7) = happyGoto action_4
action_67 (8) = happyGoto action_5
action_67 (9) = happyGoto action_6
action_67 (10) = happyGoto action_7
action_67 (13) = happyGoto action_8
action_67 (26) = happyGoto action_9
action_67 _ = happyFail

action_68 (44) = happyShift action_89
action_68 _ = happyFail

action_69 (44) = happyShift action_88
action_69 _ = happyFail

action_70 (27) = happyShift action_10
action_70 (28) = happyShift action_11
action_70 (30) = happyShift action_12
action_70 (31) = happyShift action_13
action_70 (38) = happyShift action_14
action_70 (43) = happyShift action_15
action_70 (44) = happyShift action_16
action_70 (45) = happyShift action_17
action_70 (46) = happyShift action_18
action_70 (50) = happyShift action_19
action_70 (5) = happyGoto action_87
action_70 (6) = happyGoto action_3
action_70 (7) = happyGoto action_4
action_70 (8) = happyGoto action_5
action_70 (9) = happyGoto action_6
action_70 (10) = happyGoto action_7
action_70 (13) = happyGoto action_8
action_70 (26) = happyGoto action_9
action_70 _ = happyFail

action_71 (53) = happyShift action_86
action_71 (57) = happyShift action_33
action_71 (58) = happyShift action_34
action_71 (59) = happyShift action_35
action_71 (60) = happyShift action_36
action_71 (61) = happyShift action_37
action_71 (62) = happyShift action_38
action_71 (63) = happyShift action_39
action_71 (64) = happyShift action_40
action_71 (65) = happyShift action_41
action_71 (66) = happyShift action_42
action_71 (68) = happyShift action_43
action_71 (69) = happyShift action_44
action_71 _ = happyFail

action_72 (51) = happyShift action_85
action_72 (57) = happyShift action_33
action_72 (58) = happyShift action_34
action_72 (59) = happyShift action_35
action_72 (60) = happyShift action_36
action_72 (61) = happyShift action_37
action_72 (62) = happyShift action_38
action_72 (63) = happyShift action_39
action_72 (64) = happyShift action_40
action_72 (65) = happyShift action_41
action_72 (66) = happyShift action_42
action_72 (68) = happyShift action_43
action_72 (69) = happyShift action_44
action_72 _ = happyReduce_64

action_73 (47) = happyShift action_83
action_73 (51) = happyShift action_84
action_73 _ = happyFail

action_74 _ = happyReduce_36

action_75 (47) = happyShift action_81
action_75 (51) = happyShift action_82
action_75 _ = happyFail

action_76 (50) = happyShift action_24
action_76 (52) = happyShift action_25
action_76 (61) = happyShift action_80
action_76 _ = happyReduce_66

action_77 (27) = happyShift action_10
action_77 (28) = happyShift action_11
action_77 (30) = happyShift action_12
action_77 (31) = happyShift action_13
action_77 (38) = happyShift action_14
action_77 (43) = happyShift action_15
action_77 (44) = happyShift action_16
action_77 (45) = happyShift action_17
action_77 (46) = happyShift action_18
action_77 (50) = happyShift action_19
action_77 (5) = happyGoto action_79
action_77 (6) = happyGoto action_3
action_77 (7) = happyGoto action_4
action_77 (8) = happyGoto action_5
action_77 (9) = happyGoto action_6
action_77 (10) = happyGoto action_7
action_77 (13) = happyGoto action_8
action_77 (26) = happyGoto action_9
action_77 _ = happyFail

action_78 _ = happyReduce_20

action_79 (57) = happyShift action_33
action_79 (58) = happyShift action_34
action_79 (59) = happyShift action_35
action_79 (60) = happyShift action_36
action_79 (61) = happyShift action_37
action_79 (62) = happyShift action_38
action_79 (63) = happyShift action_39
action_79 (64) = happyShift action_40
action_79 (65) = happyShift action_41
action_79 (66) = happyShift action_42
action_79 (68) = happyShift action_43
action_79 (69) = happyShift action_44
action_79 _ = happyReduce_62

action_80 (27) = happyShift action_10
action_80 (28) = happyShift action_11
action_80 (30) = happyShift action_12
action_80 (31) = happyShift action_13
action_80 (38) = happyShift action_14
action_80 (43) = happyShift action_15
action_80 (44) = happyShift action_16
action_80 (45) = happyShift action_17
action_80 (46) = happyShift action_18
action_80 (50) = happyShift action_19
action_80 (5) = happyGoto action_108
action_80 (6) = happyGoto action_3
action_80 (7) = happyGoto action_4
action_80 (8) = happyGoto action_5
action_80 (9) = happyGoto action_6
action_80 (10) = happyGoto action_7
action_80 (13) = happyGoto action_8
action_80 (26) = happyGoto action_9
action_80 _ = happyFail

action_81 (27) = happyShift action_10
action_81 (28) = happyShift action_11
action_81 (30) = happyShift action_12
action_81 (31) = happyShift action_13
action_81 (38) = happyShift action_14
action_81 (43) = happyShift action_15
action_81 (44) = happyShift action_16
action_81 (45) = happyShift action_17
action_81 (46) = happyShift action_18
action_81 (50) = happyShift action_19
action_81 (5) = happyGoto action_107
action_81 (6) = happyGoto action_3
action_81 (7) = happyGoto action_4
action_81 (8) = happyGoto action_5
action_81 (9) = happyGoto action_6
action_81 (10) = happyGoto action_7
action_81 (13) = happyGoto action_8
action_81 (26) = happyGoto action_9
action_81 _ = happyFail

action_82 _ = happyReduce_21

action_83 (44) = happyShift action_106
action_83 (12) = happyGoto action_105
action_83 _ = happyFail

action_84 _ = happyReduce_34

action_85 _ = happyReduce_67

action_86 (42) = happyShift action_104
action_86 _ = happyFail

action_87 (40) = happyShift action_103
action_87 (57) = happyShift action_33
action_87 (58) = happyShift action_34
action_87 (59) = happyShift action_35
action_87 (60) = happyShift action_36
action_87 (61) = happyShift action_37
action_87 (62) = happyShift action_38
action_87 (63) = happyShift action_39
action_87 (64) = happyShift action_40
action_87 (65) = happyShift action_41
action_87 (66) = happyShift action_42
action_87 (68) = happyShift action_43
action_87 (69) = happyShift action_44
action_87 _ = happyReduce_15

action_88 (61) = happyShift action_102
action_88 _ = happyFail

action_89 (48) = happyShift action_100
action_89 (67) = happyShift action_101
action_89 _ = happyFail

action_90 (33) = happyShift action_99
action_90 (57) = happyShift action_33
action_90 (58) = happyShift action_34
action_90 (59) = happyShift action_35
action_90 (60) = happyShift action_36
action_90 (61) = happyShift action_37
action_90 (62) = happyShift action_38
action_90 (63) = happyShift action_39
action_90 (64) = happyShift action_40
action_90 (65) = happyShift action_41
action_90 (66) = happyShift action_42
action_90 (68) = happyShift action_43
action_90 (69) = happyShift action_44
action_90 _ = happyFail

action_91 _ = happyReduce_51

action_92 (44) = happyShift action_98
action_92 _ = happyFail

action_93 _ = happyReduce_47

action_94 (29) = happyShift action_97
action_94 (57) = happyShift action_33
action_94 (58) = happyShift action_34
action_94 (59) = happyShift action_35
action_94 (60) = happyShift action_36
action_94 (61) = happyShift action_37
action_94 (62) = happyShift action_38
action_94 (63) = happyShift action_39
action_94 (64) = happyShift action_40
action_94 (65) = happyShift action_41
action_94 (66) = happyShift action_42
action_94 (68) = happyShift action_43
action_94 (69) = happyShift action_44
action_94 _ = happyFail

action_95 (57) = happyShift action_33
action_95 (58) = happyShift action_34
action_95 (59) = happyShift action_35
action_95 (60) = happyShift action_36
action_95 (61) = happyShift action_37
action_95 (62) = happyShift action_38
action_95 (63) = happyShift action_39
action_95 (64) = happyShift action_40
action_95 (65) = happyShift action_41
action_95 (66) = happyShift action_42
action_95 (68) = happyShift action_43
action_95 (69) = happyShift action_44
action_95 _ = happyReduce_16

action_96 _ = happyReduce_68

action_97 (27) = happyShift action_10
action_97 (28) = happyShift action_11
action_97 (30) = happyShift action_12
action_97 (31) = happyShift action_13
action_97 (38) = happyShift action_14
action_97 (43) = happyShift action_15
action_97 (44) = happyShift action_16
action_97 (45) = happyShift action_17
action_97 (46) = happyShift action_18
action_97 (50) = happyShift action_19
action_97 (5) = happyGoto action_118
action_97 (6) = happyGoto action_3
action_97 (7) = happyGoto action_4
action_97 (8) = happyGoto action_5
action_97 (9) = happyGoto action_6
action_97 (10) = happyGoto action_7
action_97 (13) = happyGoto action_8
action_97 (26) = happyGoto action_9
action_97 _ = happyFail

action_98 (50) = happyShift action_117
action_98 _ = happyFail

action_99 _ = happyReduce_19

action_100 (44) = happyShift action_116
action_100 _ = happyFail

action_101 (27) = happyShift action_10
action_101 (28) = happyShift action_11
action_101 (30) = happyShift action_12
action_101 (31) = happyShift action_13
action_101 (38) = happyShift action_14
action_101 (43) = happyShift action_15
action_101 (44) = happyShift action_16
action_101 (45) = happyShift action_17
action_101 (46) = happyShift action_18
action_101 (50) = happyShift action_19
action_101 (5) = happyGoto action_115
action_101 (6) = happyGoto action_3
action_101 (7) = happyGoto action_4
action_101 (8) = happyGoto action_5
action_101 (9) = happyGoto action_6
action_101 (10) = happyGoto action_7
action_101 (13) = happyGoto action_8
action_101 (26) = happyGoto action_9
action_101 _ = happyFail

action_102 (37) = happyShift action_112
action_102 (44) = happyShift action_113
action_102 (54) = happyShift action_114
action_102 (21) = happyGoto action_111
action_102 _ = happyFail

action_103 (27) = happyShift action_10
action_103 (28) = happyShift action_11
action_103 (30) = happyShift action_12
action_103 (31) = happyShift action_13
action_103 (38) = happyShift action_14
action_103 (43) = happyShift action_15
action_103 (44) = happyShift action_16
action_103 (45) = happyShift action_17
action_103 (46) = happyShift action_18
action_103 (50) = happyShift action_19
action_103 (5) = happyGoto action_110
action_103 (6) = happyGoto action_3
action_103 (7) = happyGoto action_4
action_103 (8) = happyGoto action_5
action_103 (9) = happyGoto action_6
action_103 (10) = happyGoto action_7
action_103 (13) = happyGoto action_8
action_103 (26) = happyGoto action_9
action_103 _ = happyFail

action_104 (27) = happyShift action_10
action_104 (28) = happyShift action_11
action_104 (30) = happyShift action_12
action_104 (31) = happyShift action_13
action_104 (38) = happyShift action_14
action_104 (43) = happyShift action_15
action_104 (44) = happyShift action_16
action_104 (45) = happyShift action_17
action_104 (46) = happyShift action_18
action_104 (50) = happyShift action_19
action_104 (5) = happyGoto action_109
action_104 (6) = happyGoto action_3
action_104 (7) = happyGoto action_4
action_104 (8) = happyGoto action_5
action_104 (9) = happyGoto action_6
action_104 (10) = happyGoto action_7
action_104 (13) = happyGoto action_8
action_104 (26) = happyGoto action_9
action_104 _ = happyFail

action_105 _ = happyReduce_37

action_106 (61) = happyShift action_80
action_106 _ = happyFail

action_107 (57) = happyShift action_33
action_107 (58) = happyShift action_34
action_107 (59) = happyShift action_35
action_107 (60) = happyShift action_36
action_107 (61) = happyShift action_37
action_107 (62) = happyShift action_38
action_107 (63) = happyShift action_39
action_107 (64) = happyShift action_40
action_107 (65) = happyShift action_41
action_107 (66) = happyShift action_42
action_107 (68) = happyShift action_43
action_107 (69) = happyShift action_44
action_107 _ = happyReduce_65

action_108 (57) = happyShift action_33
action_108 (58) = happyShift action_34
action_108 (59) = happyShift action_35
action_108 (60) = happyShift action_36
action_108 (61) = happyShift action_37
action_108 (62) = happyShift action_38
action_108 (63) = happyShift action_39
action_108 (64) = happyShift action_40
action_108 (65) = happyShift action_41
action_108 (66) = happyShift action_42
action_108 (68) = happyShift action_43
action_108 (69) = happyShift action_44
action_108 _ = happyReduce_38

action_109 (57) = happyShift action_33
action_109 (58) = happyShift action_34
action_109 (59) = happyShift action_35
action_109 (60) = happyShift action_36
action_109 (61) = happyShift action_37
action_109 (62) = happyShift action_38
action_109 (63) = happyShift action_39
action_109 (64) = happyShift action_40
action_109 (65) = happyShift action_41
action_109 (66) = happyShift action_42
action_109 (68) = happyShift action_43
action_109 (69) = happyShift action_44
action_109 _ = happyReduce_39

action_110 (57) = happyShift action_33
action_110 (58) = happyShift action_34
action_110 (59) = happyShift action_35
action_110 (60) = happyShift action_36
action_110 (61) = happyShift action_37
action_110 (62) = happyShift action_38
action_110 (63) = happyShift action_39
action_110 (64) = happyShift action_40
action_110 (65) = happyShift action_41
action_110 (66) = happyShift action_42
action_110 (68) = happyShift action_43
action_110 (69) = happyShift action_44
action_110 _ = happyReduce_14

action_111 _ = happyReduce_45

action_112 (42) = happyShift action_125
action_112 _ = happyFail

action_113 _ = happyReduce_54

action_114 (44) = happyShift action_122
action_114 (22) = happyGoto action_120
action_114 (23) = happyGoto action_124
action_114 _ = happyReduce_58

action_115 (57) = happyShift action_33
action_115 (58) = happyShift action_34
action_115 (59) = happyShift action_35
action_115 (60) = happyShift action_36
action_115 (61) = happyShift action_37
action_115 (62) = happyShift action_38
action_115 (63) = happyShift action_39
action_115 (64) = happyShift action_40
action_115 (65) = happyShift action_41
action_115 (66) = happyShift action_42
action_115 (68) = happyShift action_43
action_115 (69) = happyShift action_44
action_115 _ = happyReduce_48

action_116 (67) = happyShift action_123
action_116 _ = happyFail

action_117 (44) = happyShift action_122
action_117 (22) = happyGoto action_120
action_117 (23) = happyGoto action_121
action_117 _ = happyReduce_58

action_118 (41) = happyShift action_119
action_118 (57) = happyShift action_33
action_118 (58) = happyShift action_34
action_118 (59) = happyShift action_35
action_118 (60) = happyShift action_36
action_118 (61) = happyShift action_37
action_118 (62) = happyShift action_38
action_118 (63) = happyShift action_39
action_118 (64) = happyShift action_40
action_118 (65) = happyShift action_41
action_118 (66) = happyShift action_42
action_118 (68) = happyShift action_43
action_118 (69) = happyShift action_44
action_118 _ = happyFail

action_119 (27) = happyShift action_10
action_119 (28) = happyShift action_11
action_119 (30) = happyShift action_12
action_119 (31) = happyShift action_13
action_119 (38) = happyShift action_14
action_119 (43) = happyShift action_15
action_119 (44) = happyShift action_16
action_119 (45) = happyShift action_17
action_119 (46) = happyShift action_18
action_119 (50) = happyShift action_19
action_119 (5) = happyGoto action_132
action_119 (6) = happyGoto action_3
action_119 (7) = happyGoto action_4
action_119 (8) = happyGoto action_5
action_119 (9) = happyGoto action_6
action_119 (10) = happyGoto action_7
action_119 (13) = happyGoto action_8
action_119 (26) = happyGoto action_9
action_119 _ = happyFail

action_120 _ = happyReduce_59

action_121 (47) = happyShift action_127
action_121 (51) = happyShift action_131
action_121 _ = happyFail

action_122 (48) = happyShift action_130
action_122 _ = happyFail

action_123 (27) = happyShift action_10
action_123 (28) = happyShift action_11
action_123 (30) = happyShift action_12
action_123 (31) = happyShift action_13
action_123 (38) = happyShift action_14
action_123 (43) = happyShift action_15
action_123 (44) = happyShift action_16
action_123 (45) = happyShift action_17
action_123 (46) = happyShift action_18
action_123 (50) = happyShift action_19
action_123 (5) = happyGoto action_129
action_123 (6) = happyGoto action_3
action_123 (7) = happyGoto action_4
action_123 (8) = happyGoto action_5
action_123 (9) = happyGoto action_6
action_123 (10) = happyGoto action_7
action_123 (13) = happyGoto action_8
action_123 (26) = happyGoto action_9
action_123 _ = happyFail

action_124 (47) = happyShift action_127
action_124 (55) = happyShift action_128
action_124 _ = happyFail

action_125 (44) = happyShift action_126
action_125 _ = happyFail

action_126 _ = happyReduce_56

action_127 (44) = happyShift action_122
action_127 (22) = happyGoto action_136
action_127 _ = happyFail

action_128 _ = happyReduce_55

action_129 (57) = happyShift action_33
action_129 (58) = happyShift action_34
action_129 (59) = happyShift action_35
action_129 (60) = happyShift action_36
action_129 (61) = happyShift action_37
action_129 (62) = happyShift action_38
action_129 (63) = happyShift action_39
action_129 (64) = happyShift action_40
action_129 (65) = happyShift action_41
action_129 (66) = happyShift action_42
action_129 (68) = happyShift action_43
action_129 (69) = happyShift action_44
action_129 _ = happyReduce_49

action_130 (44) = happyShift action_135
action_130 _ = happyFail

action_131 (48) = happyShift action_133
action_131 (61) = happyShift action_134
action_131 _ = happyFail

action_132 (57) = happyShift action_33
action_132 (58) = happyShift action_34
action_132 (59) = happyShift action_35
action_132 (60) = happyShift action_36
action_132 (61) = happyShift action_37
action_132 (62) = happyShift action_38
action_132 (63) = happyShift action_39
action_132 (64) = happyShift action_40
action_132 (65) = happyShift action_41
action_132 (66) = happyShift action_42
action_132 (68) = happyShift action_43
action_132 (69) = happyShift action_44
action_132 _ = happyReduce_17

action_133 (44) = happyShift action_138
action_133 _ = happyFail

action_134 (27) = happyShift action_10
action_134 (28) = happyShift action_11
action_134 (30) = happyShift action_12
action_134 (31) = happyShift action_13
action_134 (38) = happyShift action_14
action_134 (43) = happyShift action_15
action_134 (44) = happyShift action_16
action_134 (45) = happyShift action_17
action_134 (46) = happyShift action_18
action_134 (50) = happyShift action_19
action_134 (5) = happyGoto action_137
action_134 (6) = happyGoto action_3
action_134 (7) = happyGoto action_4
action_134 (8) = happyGoto action_5
action_134 (9) = happyGoto action_6
action_134 (10) = happyGoto action_7
action_134 (13) = happyGoto action_8
action_134 (26) = happyGoto action_9
action_134 _ = happyFail

action_135 _ = happyReduce_57

action_136 _ = happyReduce_60

action_137 (57) = happyShift action_33
action_137 (58) = happyShift action_34
action_137 (59) = happyShift action_35
action_137 (60) = happyShift action_36
action_137 (61) = happyShift action_37
action_137 (62) = happyShift action_38
action_137 (63) = happyShift action_39
action_137 (64) = happyShift action_40
action_137 (65) = happyShift action_41
action_137 (66) = happyShift action_42
action_137 (68) = happyShift action_43
action_137 (69) = happyShift action_44
action_137 _ = happyReduce_52

action_138 (61) = happyShift action_139
action_138 _ = happyFail

action_139 (27) = happyShift action_10
action_139 (28) = happyShift action_11
action_139 (30) = happyShift action_12
action_139 (31) = happyShift action_13
action_139 (38) = happyShift action_14
action_139 (43) = happyShift action_15
action_139 (44) = happyShift action_16
action_139 (45) = happyShift action_17
action_139 (46) = happyShift action_18
action_139 (50) = happyShift action_19
action_139 (5) = happyGoto action_140
action_139 (6) = happyGoto action_3
action_139 (7) = happyGoto action_4
action_139 (8) = happyGoto action_5
action_139 (9) = happyGoto action_6
action_139 (10) = happyGoto action_7
action_139 (13) = happyGoto action_8
action_139 (26) = happyGoto action_9
action_139 _ = happyFail

action_140 (57) = happyShift action_33
action_140 (58) = happyShift action_34
action_140 (59) = happyShift action_35
action_140 (60) = happyShift action_36
action_140 (61) = happyShift action_37
action_140 (62) = happyShift action_38
action_140 (63) = happyShift action_39
action_140 (64) = happyShift action_40
action_140 (65) = happyShift action_41
action_140 (66) = happyShift action_42
action_140 (68) = happyShift action_43
action_140 (69) = happyShift action_44
action_140 _ = happyReduce_53

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn5
		 (VarExp happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 _
	 =  HappyAbsSyn5
		 (VarExp (SimpleVar "nil")
	)

happyReduce_4 = happySpecReduce_2  5 happyReduction_4
happyReduction_4 _
	_
	 =  HappyAbsSyn5
		 (NilExp
	)

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyTerminal (TIntLit happy_var_1))
	 =  HappyAbsSyn5
		 (IntExp happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 (HappyTerminal (TStrLit happy_var_1))
	 =  HappyAbsSyn5
		 (StringExp happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  5 happyReduction_7
happyReduction_7 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  5 happyReduction_8
happyReduction_8 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  5 happyReduction_9
happyReduction_9 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  5 happyReduction_10
happyReduction_10 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  5 happyReduction_11
happyReduction_11 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  5 happyReduction_12
happyReduction_12 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  5 happyReduction_13
happyReduction_13 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn5
		 (AssignExp happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happyReduce 6 5 happyReduction_14
happyReduction_14 ((HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (IfExp happy_var_2 happy_var_4 (Just happy_var_6)
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 4 5 happyReduction_15
happyReduction_15 ((HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (IfExp happy_var_2 happy_var_4 Nothing
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 4 5 happyReduction_16
happyReduction_16 ((HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (WhileExp happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 8 5 happyReduction_17
happyReduction_17 ((HappyAbsSyn5  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (ForExp happy_var_2 False happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_1  5 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn5
		 (BreakExp
	)

happyReduce_19 = happyReduce 5 5 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (LetExp happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_3  5 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn24  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (SeqExp happy_var_2
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happyReduce 4 6 happyReduction_21
happyReduction_21 (_ `HappyStk`
	(HappyAbsSyn25  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (CallExp happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_3  7 happyReduction_22
happyReduction_22 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (OpExp happy_var_1 PlusOp happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  7 happyReduction_23
happyReduction_23 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (OpExp happy_var_1 MinusOp happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  7 happyReduction_24
happyReduction_24 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (OpExp happy_var_1 TimesOp happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  7 happyReduction_25
happyReduction_25 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn7
		 (OpExp happy_var_1 DivideOp happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  8 happyReduction_26
happyReduction_26 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn8
		 (OpExp happy_var_1 EqOp happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  8 happyReduction_27
happyReduction_27 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn8
		 (OpExp happy_var_1 NeqOp happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  8 happyReduction_28
happyReduction_28 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn8
		 (OpExp happy_var_1 LtOp happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  8 happyReduction_29
happyReduction_29 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn8
		 (OpExp happy_var_1 GtOp happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  8 happyReduction_30
happyReduction_30 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn8
		 (OpExp happy_var_1 LeOp happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  8 happyReduction_31
happyReduction_31 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn8
		 (OpExp happy_var_1 GeOp happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  9 happyReduction_32
happyReduction_32 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn9
		 (OpExp happy_var_1 AndOp happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  9 happyReduction_33
happyReduction_33 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn9
		 (OpExp happy_var_1 OrOp happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happyReduce 4 10 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (RecordExp happy_var_3 happy_var_1
	) `HappyStk` happyRest

happyReduce_35 = happySpecReduce_0  11 happyReduction_35
happyReduction_35  =  HappyAbsSyn11
		 ([]
	)

happyReduce_36 = happySpecReduce_1  11 happyReduction_36
happyReduction_36 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  11 happyReduction_37
happyReduction_37 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_3 : happy_var_1
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  12 happyReduction_38
happyReduction_38 (HappyAbsSyn5  happy_var_3)
	_
	(HappyTerminal (TIdent happy_var_1))
	 =  HappyAbsSyn12
		 ((happy_var_1, happy_var_3)
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happyReduce 6 13 happyReduction_39
happyReduction_39 ((HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (ArrayExp happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_40 = happySpecReduce_0  14 happyReduction_40
happyReduction_40  =  HappyAbsSyn14
		 ([]
	)

happyReduce_41 = happySpecReduce_2  14 happyReduction_41
happyReduction_41 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_2 : happy_var_1
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  15 happyReduction_42
happyReduction_42 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn15
		 (TypeDec happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  15 happyReduction_43
happyReduction_43 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  15 happyReduction_44
happyReduction_44 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn15
		 (FunctionDec happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happyReduce 4 16 happyReduction_45
happyReduction_45 ((HappyAbsSyn21  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 ((happy_var_2, happy_var_4)
	) `HappyStk` happyRest

happyReduce_46 = happySpecReduce_1  17 happyReduction_46
happyReduction_46 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  17 happyReduction_47
happyReduction_47 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_2 : happy_var_1
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happyReduce 4 18 happyReduction_48
happyReduction_48 ((HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (VarDec happy_var_2 True Nothing happy_var_4
	) `HappyStk` happyRest

happyReduce_49 = happyReduce 6 18 happyReduction_49
happyReduction_49 ((HappyAbsSyn5  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (VarDec happy_var_2 True (Just (NameTy happy_var_4)) happy_var_6
	) `HappyStk` happyRest

happyReduce_50 = happySpecReduce_0  19 happyReduction_50
happyReduction_50  =  HappyAbsSyn19
		 ([]
	)

happyReduce_51 = happySpecReduce_2  19 happyReduction_51
happyReduction_51 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_2 : happy_var_1
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happyReduce 7 20 happyReduction_52
happyReduction_52 ((HappyAbsSyn5  happy_var_7) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (FunDec happy_var_2 happy_var_4 Nothing happy_var_7
	) `HappyStk` happyRest

happyReduce_53 = happyReduce 9 20 happyReduction_53
happyReduction_53 ((HappyAbsSyn5  happy_var_9) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_7)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn23  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (FunDec happy_var_2 happy_var_4 (Just (NameTy happy_var_7)) happy_var_9
	) `HappyStk` happyRest

happyReduce_54 = happySpecReduce_1  21 happyReduction_54
happyReduction_54 (HappyTerminal (TIdent happy_var_1))
	 =  HappyAbsSyn21
		 (NameTy happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  21 happyReduction_55
happyReduction_55 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (RecordTy happy_var_2
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  21 happyReduction_56
happyReduction_56 (HappyTerminal (TIdent happy_var_3))
	_
	_
	 =  HappyAbsSyn21
		 (ArrayTy (NameTy happy_var_3)
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  22 happyReduction_57
happyReduction_57 (HappyTerminal (TIdent happy_var_3))
	_
	(HappyTerminal (TIdent happy_var_1))
	 =  HappyAbsSyn22
		 (Field happy_var_1 True (NameTy happy_var_3)
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_0  23 happyReduction_58
happyReduction_58  =  HappyAbsSyn23
		 ([]
	)

happyReduce_59 = happySpecReduce_1  23 happyReduction_59
happyReduction_59 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn23
		 ([happy_var_1]
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  23 happyReduction_60
happyReduction_60 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_3 : happy_var_1
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  24 happyReduction_61
happyReduction_61 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn24
		 ([happy_var_1]
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  24 happyReduction_62
happyReduction_62 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_3 : happy_var_1
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_0  25 happyReduction_63
happyReduction_63  =  HappyAbsSyn25
		 ([]
	)

happyReduce_64 = happySpecReduce_1  25 happyReduction_64
happyReduction_64 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn25
		 ([happy_var_1]
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  25 happyReduction_65
happyReduction_65 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_3 : happy_var_1
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_1  26 happyReduction_66
happyReduction_66 (HappyTerminal (TIdent happy_var_1))
	 =  HappyAbsSyn26
		 (SimpleVar happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happyReduce 4 26 happyReduction_67
happyReduction_67 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TIdent happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (SubscriptVar (SimpleVar happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_68 = happyReduce 4 26 happyReduction_68
happyReduction_68 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn26  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (SubscriptVar happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_69 = happySpecReduce_3  26 happyReduction_69
happyReduction_69 (HappyTerminal (TIdent happy_var_3))
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (FieldVar happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 70 70 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TWhile -> cont 27;
	TFor -> cont 28;
	TTo -> cont 29;
	TBreak -> cont 30;
	TLet -> cont 31;
	TIn -> cont 32;
	TEnd -> cont 33;
	TFunction -> cont 34;
	TVar -> cont 35;
	TType -> cont 36;
	TArray -> cont 37;
	TIf -> cont 38;
	TThen -> cont 39;
	TElse -> cont 40;
	TDo -> cont 41;
	TOf -> cont 42;
	TNil -> cont 43;
	TIdent happy_dollar_dollar -> cont 44;
	TIntLit happy_dollar_dollar -> cont 45;
	TStrLit happy_dollar_dollar -> cont 46;
	TComma -> cont 47;
	TColon -> cont 48;
	TSemicolon -> cont 49;
	TLParen -> cont 50;
	TRParen -> cont 51;
	TLBracket -> cont 52;
	TRBracket -> cont 53;
	TLBrace -> cont 54;
	TRBrace -> cont 55;
	TDot -> cont 56;
	TPlus -> cont 57;
	TMinus -> cont 58;
	TTimes -> cont 59;
	TDivide -> cont 60;
	TEq -> cont 61;
	TNeq -> cont 62;
	TLe -> cont 63;
	TGe -> cont 64;
	TLt -> cont 65;
	TGt -> cont 66;
	TAssign -> cont 67;
	TAnd -> cont 68;
	TOr -> cont 69;
	_ -> happyError' (tk:tks)
	}

happyError_ 70 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = return
    (<*>) = ap
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(TigerLexerToken)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

tigerParser tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [TigerLexerToken] -> a
parseError tokenList = undefined
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 16 "<built-in>" #-}
{-# LINE 1 "/Applications/ghc-7.10.2.app/Contents/lib/ghc-7.10.2/include/ghcversion.h" #-}


















{-# LINE 17 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 


{-# LINE 13 "templates/GenericTemplate.hs" #-}


{-# LINE 46 "templates/GenericTemplate.hs" #-}









{-# LINE 67 "templates/GenericTemplate.hs" #-}


{-# LINE 77 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

