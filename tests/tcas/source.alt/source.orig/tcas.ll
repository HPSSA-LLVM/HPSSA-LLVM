; ModuleID = 'tcas.c'
source_filename = "tcas.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque

@Positive_RA_Alt_Thresh = dso_local global [4 x i32] zeroinitializer, align 16
@Alt_Layer_Value = dso_local global i32 0, align 4
@Climb_Inhibit = dso_local global i32 0, align 4
@Up_Separation = dso_local global i32 0, align 4
@Down_Separation = dso_local global i32 0, align 4
@Cur_Vertical_Sep = dso_local global i32 0, align 4
@Own_Tracked_Alt = dso_local global i32 0, align 4
@Other_Tracked_Alt = dso_local global i32 0, align 4
@High_Confidence = dso_local global i32 0, align 4
@Own_Tracked_Alt_Rate = dso_local global i32 0, align 4
@Other_Capability = dso_local global i32 0, align 4
@Two_of_Three_Reports_Valid = dso_local global i32 0, align 4
@Other_RAC = dso_local global i32 0, align 4
@stdout = external dso_local global %struct._IO_FILE*, align 8
@.str = private unnamed_addr constant [35 x i8] c"Error: Command line arguments are\0A\00", align 1
@.str.1 = private unnamed_addr constant [63 x i8] c"Cur_Vertical_Sep, High_Confidence, Two_of_Three_Reports_Valid\0A\00", align 1
@.str.2 = private unnamed_addr constant [58 x i8] c"Own_Tracked_Alt, Own_Tracked_Alt_Rate, Other_Tracked_Alt\0A\00", align 1
@.str.3 = private unnamed_addr constant [49 x i8] c"Alt_Layer_Value, Up_Separation, Down_Separation\0A\00", align 1
@.str.4 = private unnamed_addr constant [44 x i8] c"Other_RAC, Other_Capability, Climb_Inhibit\0A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @initialize() #0 {
entry:
  store i32 400, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @Positive_RA_Alt_Thresh, i64 0, i64 0), align 16
  store i32 500, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @Positive_RA_Alt_Thresh, i64 0, i64 1), align 4
  store i32 640, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @Positive_RA_Alt_Thresh, i64 0, i64 2), align 8
  store i32 740, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @Positive_RA_Alt_Thresh, i64 0, i64 3), align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @ALIM() #0 {
entry:
  %0 = load i32, i32* @Alt_Layer_Value, align 4
  %idxprom = sext i32 %0 to i64
  %arrayidx = getelementptr inbounds [4 x i32], [4 x i32]* @Positive_RA_Alt_Thresh, i64 0, i64 %idxprom
  %1 = load i32, i32* %arrayidx, align 4
  ret i32 %1
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @Inhibit_Biased_Climb() #0 {
entry:
  %0 = load i32, i32* @Climb_Inhibit, align 4
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load i32, i32* @Up_Separation, align 4
  %add = add nsw i32 %1, 100
  br label %cond.end

cond.false:                                       ; preds = %entry
  %2 = load i32, i32* @Up_Separation, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %add, %cond.true ], [ %2, %cond.false ]
  ret i32 %cond
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @Non_Crossing_Biased_Climb() #0 {
entry:
  %upward_preferred = alloca i32, align 4
  %upward_crossing_situation = alloca i32, align 4
  %result = alloca i32, align 4
  %call = call i32 @Inhibit_Biased_Climb()
  %0 = load i32, i32* @Down_Separation, align 4
  %cmp = icmp sgt i32 %call, %0
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* %upward_preferred, align 4
  %1 = load i32, i32* %upward_preferred, align 4
  %tobool = icmp ne i32 %1, 0
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call1 = call i32 @Own_Below_Threat()
  %tobool2 = icmp ne i32 %call1, 0
  br i1 %tobool2, label %lor.rhs, label %lor.end

lor.rhs:                                          ; preds = %if.then
  %call3 = call i32 @Own_Below_Threat()
  %tobool4 = icmp ne i32 %call3, 0
  br i1 %tobool4, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %lor.rhs
  %2 = load i32, i32* @Down_Separation, align 4
  %call5 = call i32 @ALIM()
  %cmp6 = icmp sge i32 %2, %call5
  %lnot = xor i1 %cmp6, true
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs
  %3 = phi i1 [ false, %lor.rhs ], [ %lnot, %land.rhs ]
  br label %lor.end

lor.end:                                          ; preds = %land.end, %if.then
  %4 = phi i1 [ true, %if.then ], [ %3, %land.end ]
  %lor.ext = zext i1 %4 to i32
  store i32 %lor.ext, i32* %result, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  %call8 = call i32 @Own_Above_Threat()
  %tobool9 = icmp ne i32 %call8, 0
  br i1 %tobool9, label %land.lhs.true, label %land.end16

land.lhs.true:                                    ; preds = %if.else
  %5 = load i32, i32* @Cur_Vertical_Sep, align 4
  %cmp10 = icmp sge i32 %5, 300
  br i1 %cmp10, label %land.rhs12, label %land.end16

land.rhs12:                                       ; preds = %land.lhs.true
  %6 = load i32, i32* @Up_Separation, align 4
  %call13 = call i32 @ALIM()
  %cmp14 = icmp sge i32 %6, %call13
  br label %land.end16

land.end16:                                       ; preds = %land.rhs12, %land.lhs.true, %if.else
  %7 = phi i1 [ false, %land.lhs.true ], [ false, %if.else ], [ %cmp14, %land.rhs12 ]
  %land.ext = zext i1 %7 to i32
  store i32 %land.ext, i32* %result, align 4
  br label %if.end

if.end:                                           ; preds = %land.end16, %lor.end
  %8 = load i32, i32* %result, align 4
  ret i32 %8
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @Non_Crossing_Biased_Descend() #0 {
entry:
  %upward_preferred = alloca i32, align 4
  %upward_crossing_situation = alloca i32, align 4
  %result = alloca i32, align 4
  %call = call i32 @Inhibit_Biased_Climb()
  %0 = load i32, i32* @Down_Separation, align 4
  %cmp = icmp sgt i32 %call, %0
  %conv = zext i1 %cmp to i32
  store i32 %conv, i32* %upward_preferred, align 4
  %1 = load i32, i32* %upward_preferred, align 4
  %tobool = icmp ne i32 %1, 0
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call1 = call i32 @Own_Below_Threat()
  %tobool2 = icmp ne i32 %call1, 0
  br i1 %tobool2, label %land.lhs.true, label %land.end

land.lhs.true:                                    ; preds = %if.then
  %2 = load i32, i32* @Cur_Vertical_Sep, align 4
  %cmp3 = icmp sge i32 %2, 300
  br i1 %cmp3, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %land.lhs.true
  %3 = load i32, i32* @Down_Separation, align 4
  %call5 = call i32 @ALIM()
  %cmp6 = icmp sge i32 %3, %call5
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %if.then
  %4 = phi i1 [ false, %land.lhs.true ], [ false, %if.then ], [ %cmp6, %land.rhs ]
  %land.ext = zext i1 %4 to i32
  store i32 %land.ext, i32* %result, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  %call8 = call i32 @Own_Above_Threat()
  %tobool9 = icmp ne i32 %call8, 0
  br i1 %tobool9, label %lor.rhs, label %lor.end

lor.rhs:                                          ; preds = %if.else
  %call10 = call i32 @Own_Above_Threat()
  %tobool11 = icmp ne i32 %call10, 0
  br i1 %tobool11, label %land.rhs12, label %land.end16

land.rhs12:                                       ; preds = %lor.rhs
  %5 = load i32, i32* @Up_Separation, align 4
  %call13 = call i32 @ALIM()
  %cmp14 = icmp sge i32 %5, %call13
  br label %land.end16

land.end16:                                       ; preds = %land.rhs12, %lor.rhs
  %6 = phi i1 [ false, %lor.rhs ], [ %cmp14, %land.rhs12 ]
  br label %lor.end

lor.end:                                          ; preds = %land.end16, %if.else
  %7 = phi i1 [ true, %if.else ], [ %6, %land.end16 ]
  %lor.ext = zext i1 %7 to i32
  store i32 %lor.ext, i32* %result, align 4
  br label %if.end

if.end:                                           ; preds = %lor.end, %land.end
  %8 = load i32, i32* %result, align 4
  ret i32 %8
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @Own_Below_Threat() #0 {
entry:
  %0 = load i32, i32* @Own_Tracked_Alt, align 4
  %1 = load i32, i32* @Other_Tracked_Alt, align 4
  %cmp = icmp slt i32 %0, %1
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @Own_Above_Threat() #0 {
entry:
  %0 = load i32, i32* @Other_Tracked_Alt, align 4
  %1 = load i32, i32* @Own_Tracked_Alt, align 4
  %cmp = icmp slt i32 %0, %1
  %conv = zext i1 %cmp to i32
  ret i32 %conv
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @alt_sep_test() #0 {
entry:
  %enabled = alloca i32, align 4
  %tcas_equipped = alloca i32, align 4
  %intent_not_known = alloca i32, align 4
  %need_upward_RA = alloca i32, align 4
  %need_downward_RA = alloca i32, align 4
  %alt_sep = alloca i32, align 4
  %0 = load i32, i32* @High_Confidence, align 4
  %tobool = icmp ne i32 %0, 0
  br i1 %tobool, label %land.lhs.true, label %land.end

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* @Own_Tracked_Alt_Rate, align 4
  %cmp = icmp sle i32 %1, 600
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %land.lhs.true
  %2 = load i32, i32* @Cur_Vertical_Sep, align 4
  %cmp1 = icmp sgt i32 %2, 600
  br label %land.end

land.end:                                         ; preds = %land.rhs, %land.lhs.true, %entry
  %3 = phi i1 [ false, %land.lhs.true ], [ false, %entry ], [ %cmp1, %land.rhs ]
  %land.ext = zext i1 %3 to i32
  store i32 %land.ext, i32* %enabled, align 4
  %4 = load i32, i32* @Other_Capability, align 4
  %cmp2 = icmp eq i32 %4, 1
  %conv = zext i1 %cmp2 to i32
  store i32 %conv, i32* %tcas_equipped, align 4
  %5 = load i32, i32* @Two_of_Three_Reports_Valid, align 4
  %tobool3 = icmp ne i32 %5, 0
  br i1 %tobool3, label %land.rhs4, label %land.end7

land.rhs4:                                        ; preds = %land.end
  %6 = load i32, i32* @Other_RAC, align 4
  %cmp5 = icmp eq i32 %6, 0
  br label %land.end7

land.end7:                                        ; preds = %land.rhs4, %land.end
  %7 = phi i1 [ false, %land.end ], [ %cmp5, %land.rhs4 ]
  %land.ext8 = zext i1 %7 to i32
  store i32 %land.ext8, i32* %intent_not_known, align 4
  store i32 0, i32* %alt_sep, align 4
  %8 = load i32, i32* %enabled, align 4
  %tobool9 = icmp ne i32 %8, 0
  br i1 %tobool9, label %land.lhs.true10, label %if.end40

land.lhs.true10:                                  ; preds = %land.end7
  %9 = load i32, i32* %tcas_equipped, align 4
  %tobool11 = icmp ne i32 %9, 0
  br i1 %tobool11, label %land.lhs.true12, label %lor.lhs.false

land.lhs.true12:                                  ; preds = %land.lhs.true10
  %10 = load i32, i32* %intent_not_known, align 4
  %tobool13 = icmp ne i32 %10, 0
  br i1 %tobool13, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %land.lhs.true12, %land.lhs.true10
  %11 = load i32, i32* %tcas_equipped, align 4
  %tobool14 = icmp ne i32 %11, 0
  br i1 %tobool14, label %if.end40, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %land.lhs.true12
  %call = call i32 @Non_Crossing_Biased_Climb()
  %tobool15 = icmp ne i32 %call, 0
  br i1 %tobool15, label %land.rhs16, label %land.end19

land.rhs16:                                       ; preds = %if.then
  %call17 = call i32 @Own_Below_Threat()
  %tobool18 = icmp ne i32 %call17, 0
  br label %land.end19

land.end19:                                       ; preds = %land.rhs16, %if.then
  %12 = phi i1 [ false, %if.then ], [ %tobool18, %land.rhs16 ]
  %land.ext20 = zext i1 %12 to i32
  store i32 %land.ext20, i32* %need_upward_RA, align 4
  %call21 = call i32 @Non_Crossing_Biased_Descend()
  %tobool22 = icmp ne i32 %call21, 0
  br i1 %tobool22, label %land.rhs23, label %land.end26

land.rhs23:                                       ; preds = %land.end19
  %call24 = call i32 @Own_Above_Threat()
  %tobool25 = icmp ne i32 %call24, 0
  br label %land.end26

land.end26:                                       ; preds = %land.rhs23, %land.end19
  %13 = phi i1 [ false, %land.end19 ], [ %tobool25, %land.rhs23 ]
  %land.ext27 = zext i1 %13 to i32
  store i32 %land.ext27, i32* %need_downward_RA, align 4
  %14 = load i32, i32* %need_upward_RA, align 4
  %tobool28 = icmp ne i32 %14, 0
  br i1 %tobool28, label %land.lhs.true29, label %if.else

land.lhs.true29:                                  ; preds = %land.end26
  %15 = load i32, i32* %need_downward_RA, align 4
  %tobool30 = icmp ne i32 %15, 0
  br i1 %tobool30, label %if.then31, label %if.else

if.then31:                                        ; preds = %land.lhs.true29
  store i32 0, i32* %alt_sep, align 4
  br label %if.end39

if.else:                                          ; preds = %land.lhs.true29, %land.end26
  %16 = load i32, i32* %need_upward_RA, align 4
  %tobool32 = icmp ne i32 %16, 0
  br i1 %tobool32, label %if.then33, label %if.else34

if.then33:                                        ; preds = %if.else
  store i32 1, i32* %alt_sep, align 4
  br label %if.end38

if.else34:                                        ; preds = %if.else
  %17 = load i32, i32* %need_downward_RA, align 4
  %tobool35 = icmp ne i32 %17, 0
  br i1 %tobool35, label %if.then36, label %if.else37

if.then36:                                        ; preds = %if.else34
  store i32 2, i32* %alt_sep, align 4
  br label %if.end

if.else37:                                        ; preds = %if.else34
  store i32 0, i32* %alt_sep, align 4
  br label %if.end

if.end:                                           ; preds = %if.else37, %if.then36
  br label %if.end38

if.end38:                                         ; preds = %if.end, %if.then33
  br label %if.end39

if.end39:                                         ; preds = %if.end38, %if.then31
  br label %if.end40

if.end40:                                         ; preds = %if.end39, %lor.lhs.false, %land.end7
  %18 = load i32, i32* %alt_sep, align 4
  ret i32 %18
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %argc, i8** %argv) #0 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 8
  %0 = load i32, i32* %argc.addr, align 4
  %cmp = icmp slt i32 %0, 13
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %call = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %1, i8* getelementptr inbounds ([35 x i8], [35 x i8]* @.str, i64 0, i64 0))
  %2 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %call1 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %2, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @.str.1, i64 0, i64 0))
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %call2 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %3, i8* getelementptr inbounds ([58 x i8], [58 x i8]* @.str.2, i64 0, i64 0))
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %call3 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %4, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @.str.3, i64 0, i64 0))
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %call4 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %5, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @.str.4, i64 0, i64 0))
  call void @exit(i32 1) #3
  unreachable

if.end:                                           ; preds = %entry
  call void @initialize()
  %6 = load i8**, i8*** %argv.addr, align 8
  %arrayidx = getelementptr inbounds i8*, i8** %6, i64 1
  %7 = load i8*, i8** %arrayidx, align 8
  %call5 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %7)
  store i32 %call5, i32* @Cur_Vertical_Sep, align 4
  %8 = load i8**, i8*** %argv.addr, align 8
  %arrayidx6 = getelementptr inbounds i8*, i8** %8, i64 2
  %9 = load i8*, i8** %arrayidx6, align 8
  %call7 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %9)
  store i32 %call7, i32* @High_Confidence, align 4
  %10 = load i8**, i8*** %argv.addr, align 8
  %arrayidx8 = getelementptr inbounds i8*, i8** %10, i64 3
  %11 = load i8*, i8** %arrayidx8, align 8
  %call9 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %11)
  store i32 %call9, i32* @Two_of_Three_Reports_Valid, align 4
  %12 = load i8**, i8*** %argv.addr, align 8
  %arrayidx10 = getelementptr inbounds i8*, i8** %12, i64 4
  %13 = load i8*, i8** %arrayidx10, align 8
  %call11 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %13)
  store i32 %call11, i32* @Own_Tracked_Alt, align 4
  %14 = load i8**, i8*** %argv.addr, align 8
  %arrayidx12 = getelementptr inbounds i8*, i8** %14, i64 5
  %15 = load i8*, i8** %arrayidx12, align 8
  %call13 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %15)
  store i32 %call13, i32* @Own_Tracked_Alt_Rate, align 4
  %16 = load i8**, i8*** %argv.addr, align 8
  %arrayidx14 = getelementptr inbounds i8*, i8** %16, i64 6
  %17 = load i8*, i8** %arrayidx14, align 8
  %call15 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %17)
  store i32 %call15, i32* @Other_Tracked_Alt, align 4
  %18 = load i8**, i8*** %argv.addr, align 8
  %arrayidx16 = getelementptr inbounds i8*, i8** %18, i64 7
  %19 = load i8*, i8** %arrayidx16, align 8
  %call17 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %19)
  store i32 %call17, i32* @Alt_Layer_Value, align 4
  %20 = load i8**, i8*** %argv.addr, align 8
  %arrayidx18 = getelementptr inbounds i8*, i8** %20, i64 8
  %21 = load i8*, i8** %arrayidx18, align 8
  %call19 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %21)
  store i32 %call19, i32* @Up_Separation, align 4
  %22 = load i8**, i8*** %argv.addr, align 8
  %arrayidx20 = getelementptr inbounds i8*, i8** %22, i64 9
  %23 = load i8*, i8** %arrayidx20, align 8
  %call21 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %23)
  store i32 %call21, i32* @Down_Separation, align 4
  %24 = load i8**, i8*** %argv.addr, align 8
  %arrayidx22 = getelementptr inbounds i8*, i8** %24, i64 10
  %25 = load i8*, i8** %arrayidx22, align 8
  %call23 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %25)
  store i32 %call23, i32* @Other_RAC, align 4
  %26 = load i8**, i8*** %argv.addr, align 8
  %arrayidx24 = getelementptr inbounds i8*, i8** %26, i64 11
  %27 = load i8*, i8** %arrayidx24, align 8
  %call25 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %27)
  store i32 %call25, i32* @Other_Capability, align 4
  %28 = load i8**, i8*** %argv.addr, align 8
  %arrayidx26 = getelementptr inbounds i8*, i8** %28, i64 12
  %29 = load i8*, i8** %arrayidx26, align 8
  %call27 = call i32 (i8*, ...) bitcast (i32 (...)* @atoi to i32 (i8*, ...)*)(i8* %29)
  store i32 %call27, i32* @Climb_Inhibit, align 4
  %30 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %call28 = call i32 @alt_sep_test()
  %call29 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %30, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.5, i64 0, i64 0), i32 %call28)
  call void @exit(i32 0) #3
  unreachable
}

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #1

; Function Attrs: noreturn
declare dso_local void @exit(i32) #2

declare dso_local i32 @atoi(...) #1

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { noreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 13.0.0 (https://github.com/llvm/llvm-project.git 604bd1e49e27416e8ecb846d30f1c801f3106c94)"}
