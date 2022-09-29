* Encoding: UTF-8.
*Syntax for analyses in MRS manuscript submitted to nature communications. 
*separate files include syntax used for analysis on ICCs and bootstrapped correlations to generate values for figures. 
 
*note that group 1 is mclean stress, 2 is no stress control, 3 is emory stress, 4 is patients. some analyses only use subsets of participants 
*if participants are not filtered, filter data using dropdown menus 

*data file included one participant with MRS that passed inspection for spectral quality but was excluded from analyses for having an unreasonable change in glu (noted in manuscript). 
*filtering out Good_MRS = 1 removes this participant. 

USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE
    
SORT CASES  BY group. 
SPLIT FILE SEPARATE BY group. 
DESCRIPTIVES VARIABLES=pss_screening age 
  /STATISTICS=MEAN STDDEV MIN MAX.
 

*manipulation checks 
*Cortisol, VAMS, etc. 
*include all subjects who have good MRS. 


*starting with VAMS. 
*Participants were included in a 4 (Timepoint) by 3 (Group) repeated-measures ANOVA if they had complete VAMS data from all four timepoints (N=75). 
    *Group included No Stress Control (NSC), Healthy Control Stress (combined samples), and participants with major depressive disorder (MDD). 
SPLIT FILE OFF.
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE

GLM Mood_T2_MeanNeg Mood_T3_MeanNeg Mood_T4_MeanNeg Mood_T5_MeanNeg BY condiiton_1WC_2CC_3PT 
  /WSFACTOR=timepoint 4 Polynomial 
  /METHOD=SSTYPE(3) 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=timepoint 
  /DESIGN=condiiton_1WC_2CC_3PT.

*and now only subjects who were in the stress condition. 
*Among participants who completed the acute stress manipulation, we observed ...
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE
    
GLM Mood_T2_MeanNeg Mood_T3_MeanNeg Mood_T4_MeanNeg Mood_T5_MeanNeg BY condiiton_1WC_2CC_3PT 
  /WSFACTOR=timepoint 4 Polynomial 
  /METHOD=SSTYPE(3) 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=timepoint 
  /DESIGN=condiiton_1WC_2CC_3PT.

*and now only HC to test effect of stress. 
*We additionally compared healthy control participants who completed the stressor vs no stress control.
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 4). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 4 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE

GLM Mood_T2_MeanNeg Mood_T3_MeanNeg Mood_T4_MeanNeg Mood_T5_MeanNeg BY condiiton_1WC_2CC_3PT 
  /WSFACTOR=timepoint 4 Polynomial 
  /METHOD=SSTYPE(3) 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=timepoint 
  /DESIGN=condiiton_1WC_2CC_3PT.


*cortisol effects. 
SPLIT FILE OFF.
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE

GLM Cortisol1 Cortisol2 Cortisol3 BY condiiton_1WC_2CC_3PT 
  /WSFACTOR=timepoint 3 Polynomial 
  /METHOD=SSTYPE(3) 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=timepoint 
  /DESIGN=condiiton_1WC_2CC_3PT.


*look at only subjects who got the stress manipulation (HC and MDD). 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE

GLM Cortisol1 Cortisol2 Cortisol3 BY condiiton_1WC_2CC_3PT 
  /WSFACTOR=timepoint 3 Polynomial 
  /METHOD=SSTYPE(3) 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=timepoint 
  /DESIGN=condiiton_1WC_2CC_3PT.


*and now only HC to test effect of stress in HC (excluding group 4 MDD). 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 4). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 4 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE

GLM Cortisol1 Cortisol2 Cortisol3 BY condiiton_1WC_2CC_3PT 
  /WSFACTOR=timepoint 3 Polynomial 
  /METHOD=SSTYPE(3) 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=timepoint 
  /DESIGN=condiiton_1WC_2CC_3PT.

*t-test between cortisol 1 and cortisol 2 for healthy controls stress and NSC. 
*"Whereas cortisol increased relative to baseline for healthy controls at the first timepoint following the stress. 
    *manipulation (t42 = 3.33, p = .002), participants in the NSC group showed a slight decrease in cortisol concentration following the no stress control manipulation (t17 = -2.18, p = .044)". 
*output is sorted by condition to look at group 1 (NSC) separately from group 2 (all stress HCs). 
SORT CASES  BY condiiton_1WC_2CC_3PT. 
SPLIT FILE SEPARATE BY condiiton_1WC_2CC_3PT. 
T-TEST PAIRS=Cortisol1 WITH Cortisol2 (PAIRED) 
  /ES DISPLAY(TRUE) STANDARDIZER(SD) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.


*look at splitting by Stress to compute effect size for comparison to known work. 
*we don't actually report this cohen's d, the value that we report is slightly different and the equation used to 
*calculate it is reported in the supplement. we had to use to the equation from Dickerson and Kemeny (2004) 
*to get an effect size that we could directly compare.  
SPLIT FILE OFF.
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE
SORT CASES  BY Stress. 
SPLIT FILE SEPARATE BY Stress. 
T-TEST PAIRS=Sample2nmoll WITH Sample3nmoll (PAIRED) 
  /ES DISPLAY(TRUE) STANDARDIZER(SD) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.


*look at post scan ratings. 
SPLIT FILE OFF.
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE

GLM postscan_unpleasant postscan_stressful postscan_difficult BY condiiton_1WC_2CC_3PT 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN= condiiton_1WC_2CC_3PT.

*for For participants who completed the stress manipulation, no significant effects of Diagnostic Group were observed for subjective levels of stress, unpleasantness, or difficulty (ps>.18). 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE

GLM postscan_unpleasant postscan_stressful postscan_difficult BY condiiton_1WC_2CC_3PT 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /CRITERIA=ALPHA(.05) 
  /DESIGN= condiiton_1WC_2CC_3PT.



*Glu and glx correlations by group.
*correlations for each sample glutamate and glx for the supplement. 
SORT CASES  BY group. 
SPLIT FILE SEPARATE BY group. 

USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE.

NONPAR CORR 
  /VARIABLES=pss_screening Glu_Percent_Change Glx_Percent_Change
  /PRINT=SPEARMAN TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.

*"No main effects of acute stress on Glu/Cr or Glx/Cr were observed for either sample". 
*running paired t tests (pre stress vs post stress). output is still separated by groups. 
*this runs for all groups but what we are reporting here is group 1 and group 3 (HC stress). 
T-TEST PAIRS=Glu_CR_1 Glx_CR_1 WITH Glu_CR_2 Glx_CR_2 (PAIRED) 
  /ES DISPLAY(TRUE) STANDARDIZER(SD) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.

*reporting paired t-tests for low PSS only pre and post metabolites. need to select only low PSS and group 1 or 3.  
*analysis with other metabolites will be included for the supplement. 
SPLIT FILE OFF.
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 4 & group ~= 2 & PSS_hi_lo = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 4 & group ~= 2 & PSS_hi_lo = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE
 
T-TEST PAIRS=Glu_CR_1 Glx_CR_1 WITH Glu_CR_2 Glx_CR_2 (PAIRED) 
  /ES DISPLAY(TRUE) STANDARDIZER(SD) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.


*Analyze effects of PSS*Stress in ONLY HC 
*Select Good_MRS = 1 & group ~= 4 (to exclude patients). 
*To confirm that the association between PSS scores and Glu was significantly stronger during the acute stress manipulation relative 
    to the NSC condition, we additionally examined the interaction between the acute stress manipulation and PSS using hierarchical linear regression. 
*NOTE that for all analyses glx is also included and is reported in supplemental tables. 

SPLIT FILE OFF.    
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 4). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 4 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE
 
*GLU. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER Stress HC_PSS_MC 
  /METHOD=STEPWISE HC_Age_MC HC_PSSMC_byStress Sex_dummy scanner.

*GLX. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glx_Percent_Change 
  /METHOD=ENTER Stress HC_PSS_MC 
  /METHOD=STEPWISE HC_Age_MC HC_PSSMC_byStress Sex_dummy scanner.


*GLU with CR SD. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER Stress HC_PSS_MC  CR_Glu_Average 
  /METHOD=STEPWISE HC_Age_MC HC_PSSMC_byStress Sex_dummy scanner.

*model testing choline for supplement. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Cho_Percent_Change 
  /METHOD=ENTER Stress HC_PSS_MC 
  /METHOD=STEPWISE HC_Age_MC HC_PSSMC_byStress Sex_dummy scanner.



*STRAIN analysis. 
*includes only group 3 (healthy control stress subjects). 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group = 3). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group = 3 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

NONPAR CORR 
  /VARIABLES=pss_screening Glu_Percent_Change StressCT StressTH EvntCT DiffCT EvntTH DiffTH Past1YrTotCT Past1YrTotTH Past1YrEveCT 
    Past1YrEveTH Past1YrDifCT Past1YrDifTH
  /PRINT=SPEARMAN TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.




*PATIENT X PSS interaction models. 
*Filter to EXCLUDE group 2 Good_MRS = 1 & group ~= 2.    
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE.
*CHECK FILTERING AND ENTER MANUALLY IF NOT CORRECT. 
*Diagnosis Effects (Patient X PSS). 
*Glu. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER Patient Stress_PSS_MC 
  /METHOD=STEPWISE Stress_PSSMC_byPatient Stress_Age_MC Sex_dummy scanner.

*Glx. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glx_Percent_Change 
  /METHOD=ENTER Patient Stress_PSS_MC
  /METHOD=STEPWISE Stress_PSSMC_byPatient Stress_Age_MC Sex_dummy scanner.



*GLU with CR SD average. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER Patient Stress_PSS_MC CR_Glu_Average 
  /METHOD=STEPWISE Stress_PSSMC_byPatient Stress_Age_MC Sex_dummy scanner.
  

*PSS and PSS squared regression model 
    *PSS and PSS squared terms are not mean centered 
    *SELECT ONLY  Good_MRS == 1 & group ~= 2. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE.
*VERIFY FILTER AND FILTER MANUALLY IF NOT. 
*GLU. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER pss_screening 
  /METHOD=STEPWISE PSS_squared.

*Glx. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glx_Percent_Change 
  /METHOD=ENTER pss_screening 
  /METHOD=STEPWISE PSS_squared.

*GLU and include CR_glu_Average. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER pss_screening CR_Glu_Average 
  /METHOD=STEPWISE PSS_squared.




*differences in glu change between groups. 
*"Main Effect of Depression on mPFC Glutamate". 
*select all but NSC for ANOVA. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

GLM Glu_CR_1 Glu_CR_2 BY condiiton_1WC_2CC_3PT 
  /WSFACTOR=timepoint 2 Polynomial 
  /METHOD=SSTYPE(3) 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=timepoint 
  /DESIGN=condiiton_1WC_2CC_3PT.

GLM Glx_CR_1 Glx_CR_2 BY condiiton_1WC_2CC_3PT 
  /WSFACTOR=timepoint 2 Polynomial 
  /METHOD=SSTYPE(3) 
  /CRITERIA=ALPHA(.05) 
  /WSDESIGN=timepoint 
  /DESIGN=condiiton_1WC_2CC_3PT.


*compare glu and glx of patients and controls (all subject) before the stress manipulation. 
*Glu/Cr and Glx/Cr ratios at baseline showed no differences between MDD participants and healthy controls.
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
T-TEST GROUPS=patient(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES= Glu_CR_1 Glx_CR_1
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).
*note that comparison of glu pre-stress was a lower p value for stress HC vs MDD (rather than ALL HC vs MDD, so we report 
*>.4 rather than >.59 to be more conservative. 


*compare glu and glx of patients and controls after stress manipulation. 
*"nor were Glu/Cr and Glx/Cr ratios different between the diagnostic groups after being exposed to the acute stress manipulation". 
*included the pre-stress values too for the comparison mentioned above. 

T-TEST GROUPS=condiiton_1WC_2CC_3PT(2 3) 
  /MISSING=ANALYSIS 
  /VARIABLES= Glu_CR_2 Glx_CR_2 Glu_CR_1 Glx_CR_1
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).




*t-tests for EMA. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2 & group ~=1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 & group ~=1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
T-TEST GROUPS=group(3 4) 
  /MISSING=ANALYSIS 
  /VARIABLES=mean_PA mean_NA PE_abs avg_neg_PE avg_pos_PE pos_PE_freq neg_PE_freq no_PE_freq 
    mean_expected_value mean_actual_value 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).


*EMA correlations. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2 & group ~=1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 & group ~=1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

*initial correlation controls for age, sex, and diagnostic group. 
PARTIAL CORR 
  /VARIABLES=Residual_MGR mean_PA mean_NA PE_abs avg_neg_PE avg_pos_PE mean_expected_value 
    mean_actual_value BY age Sex_dummy patient
  /SIGNIFICANCE=TWOTAIL 
  /MISSING=ANALYSIS.

*additionally controls for PSS. 
PARTIAL CORR 
  /VARIABLES=Residual_MGR mean_PA mean_NA PE_abs avg_neg_PE avg_pos_PE mean_expected_value 
    mean_actual_value BY age Sex_dummy patient pss_screening
  /SIGNIFICANCE=TWOTAIL 
  /MISSING=ANALYSIS.

*additionally controls for frequency of positive PE (pessimistic expectations). 
PARTIAL CORR 
  /VARIABLES=Residual_MGR mean_PA mean_NA PE_abs avg_neg_PE avg_pos_PE mean_expected_value 
    mean_actual_value BY age Sex_dummy patient pss_screening pos_PE_freq
  /SIGNIFICANCE=TWOTAIL 
  /MISSING=ANALYSIS.

*for steiger's z, calculate  the MGR - pos PE relationship, and MGR-neg PE relationship, only including the subjects 
 *who have neg PE. 
*actual steiger's z calculation uses online calculator: http://quantpsy.org/corrtest/corrtest2.htm 
. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2 & group ~=1 & avg_neg_PE < 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 & group ~=1 & avg_neg_PE < 1) (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

PARTIAL CORR 
  /VARIABLES=Residual_MGR mean_PA mean_NA PE_abs avg_neg_PE avg_pos_PE mean_expected_value 
    mean_actual_value BY age Sex_dummy patient
  /SIGNIFICANCE=TWOTAIL 
  /MISSING=LISTWISE.
   


