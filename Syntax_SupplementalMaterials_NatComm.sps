* Encoding: UTF-8.
*Supplemental analyses for R00 MRS submission to Nature Communications 
    *these are run on the main dataset. other analyses that use the TRT datasets are saved in separate syntax files. 

*calculate the mean and SD of cortisol concentration immediately before the stressor and post stress. 
*this is for the effect size calculation to compare to previous work. 

*limiting to ONLY subjects with valid cortisol at each timepoint. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2 & Sample2nmoll > -1 & Sample3nmoll > -1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 & Sample2nmoll > -1 & Sample3nmoll > -1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

DESCRIPTIVES VARIABLES=Sample2nmoll Sample3nmoll 
  /STATISTICS=MEAN STDDEV MIN MAX.


*Demographic effects on percent change glu and interaction with PSS. 
*demographics interactions with PSS 
 * SELECT ONLY Good_MRS == 1 & group ~= 2 & group ~=4. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2 & group ~=4). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 & group ~=4 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 


 REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER Group1and3_PSS_MC Sex_dummy 
  /METHOD=STEPWISE HC_Sex_byPSS scanner.
  

*compare change in glutamate for male and female participants. 
T-TEST GROUPS=Sex_dummy(0 1) 
  /MISSING=ANALYSIS 
  /VARIABLES=Glu_Percent_Change 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

*GLX sex interaction for table. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glx_Percent_Change 
  /METHOD=ENTER Group1and3_PSS_MC Sex_dummy 
  /METHOD=STEPWISE HC_Sex_byPSS scanner.

*Glu age x pss interaction. 
 REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER Group1and3_PSS_MC Group1and3_Age_MC 
  /METHOD=STEPWISE Group1and3_PssXAge scanner.

*Glx age x pss interaction. 
REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glx_Percent_Change 
  /METHOD=ENTER Group1and3_PSS_MC Group1and3_Age_MC 
  /METHOD=STEPWISE Group1and3_PssXAge scanner.

*Birth control analysis. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2 & group ~=4 & Sex_dummy=0). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 & group ~=4 & Sex_dummy=0 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

 REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glu_Percent_Change 
  /METHOD=ENTER PSS_MS_forBC BC_code_dummy 
  /METHOD=STEPWISE BCxPSSint scanner.


REGRESSION 
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT Glx_Percent_Change 
  /METHOD=ENTER PSS_MS_forBC BC_code_dummy 
  /METHOD=STEPWISE BCxPSSint scanner.




*Supplemental analysis - correlations between PSS, cortisol percent change, or VAMS percent change (percent change T1 to T3 in figure, called T2 and T4 here). 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2 & group ~=4). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 & group ~=4 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

CORRELATIONS 
  /VARIABLES=Glu_Percent_Change VAMS_Percent_Change Cortisol2 Cortisol3 postscan_unpleasant postscan_stressful postscan_difficult 
  /PRINT=TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.

NONPAR CORR 
  /VARIABLES=Glu_Percent_Change VAMS_Percent_Change Cortisol2 Cortisol3 postscan_unpleasant postscan_stressful postscan_difficult 
  /PRINT=SPEARMAN TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.

USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group =4). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group =4 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

CORRELATIONS 
  /VARIABLES=Glu_Percent_Change VAMS_Percent_Change Cortisol2 Cortisol3 postscan_unpleasant postscan_stressful postscan_difficult 
  /PRINT=TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.

NONPAR CORR 
  /VARIABLES=Glu_Percent_Change VAMS_Percent_Change Cortisol2 Cortisol3 postscan_unpleasant postscan_stressful postscan_difficult 
  /PRINT=SPEARMAN TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.

*comparison of each metabolite (and get means and sds) for supplemental tables. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 

SORT CASES  BY group. 
SPLIT FILE SEPARATE BY group. 

DESCRIPTIVES VARIABLES=Asp_SD1 Asp_SD2 Cho_SD1 Cho_SD2 Glu_SD1 Glu_SD2 Gln_SD1 Gln_SD2 Myo_SD1 Myo_SD2 NAA_SD1 NAA_SD2
  /STATISTICS=MEAN STDDEV MIN MAX.

T-TEST PAIRS=Asp_CR_1 Cho_CR_1 Glu_CR_1 Gln_CR_1 Myo_CR_1 NAA_CR_1 Glx_CR_1 WITH Asp_CR_2 Cho_CR_2 Glu_CR_2 Gln_CR_2 Myo_CR_2 NAA_CR_2 Glx_CR_2 (PAIRED) 
  /ES DISPLAY(TRUE) STANDARDIZER(SD) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.




*low PSS only analysis. 
*values for supplemental table (low PSS metabolite effects). 
SPLIT FILE OFF. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group ~= 2 & group~=4 & PSS_hi_lo = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group ~= 2 & group~=4 & PSS_hi_lo = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
DESCRIPTIVES VARIABLES=Asp_SD1 Asp_SD2 Cho_SD1 Cho_SD2 Glu_SD1 Glu_SD2 Gln_SD1 Gln_SD2 Myo_SD1 Myo_SD2 NAA_SD1 NAA_SD2 PSS_screening
  /STATISTICS=MEAN STDDEV MIN MAX.

T-TEST PAIRS=Asp_CR_1 Cho_CR_1 Glu_CR_1 Gln_CR_1 Myo_CR_1 NAA_CR_1 Glx_CR_1 WITH Asp_CR_2 Cho_CR_2 Glu_CR_2 Gln_CR_2 Myo_CR_2 NAA_CR_2 Glx_CR_2 (PAIRED) 
  /ES DISPLAY(TRUE) STANDARDIZER(SD) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.


*NOTE- values for some supplementary tables are from regression models above and in the syntax file for the main manuscript. 



*Note-- the ICC values calculated here are to make supplemental ICC figure. 
*calculate ICCs for each group (NSC, HC stress, MDD) for Glu, NAA, Myo, and Choline. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE
    
SORT CASES  BY condiiton_1WC_2CC_3PT. 
SPLIT FILE SEPARATE BY condiiton_1WC_2CC_3PT. 


RELIABILITY 
  /VARIABLES=Glu_CR_1 Glu_CR_2 
  /SCALE('ALL VARIABLES') ALL 
  /MODEL=ALPHA 
  /ICC=MODEL(MIXED) TYPE(ABSOLUTE) CIN=95 TESTVAL=0.

RELIABILITY
  /VARIABLES=Cho_CR_1 Cho_CR_2
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /ICC=MODEL(MIXED) TYPE(ABSOLUTE) CIN=95 TESTVAL=0.

RELIABILITY
  /VARIABLES=NAA_CR_1 NAA_CR_2
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /ICC=MODEL(MIXED) TYPE(ABSOLUTE) CIN=95 TESTVAL=0.

RELIABILITY
  /VARIABLES=Myo_CR_1 Myo_CR_2
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /ICC=MODEL(MIXED) TYPE(ABSOLUTE) CIN=95 TESTVAL=0.


*get Z scores for all metabolites. to note influential datapoints for NAA in group 3. 
*includes the subject excluded for being an outlier on glu (this was used to get the z scores). 
SPLIT FILE OFF. 
FILTER OFF. 
USE ALL. 
EXECUTE. 
DESCRIPTIVES VARIABLES=Glu_Percent_Change Glx_Percent_Change Cho_Percent_Change NAA_Percent_Change 
    Myo_Percent_Change Asp_Percent_Change 
  /SAVE 
  /STATISTICS=MEAN STDDEV MIN MAX.

*sort by NAA. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 & group = 3 & ZNAA_Percent_Change > -2.5 & ZNAA_Percent_Change  < 
    2.5). 
VARIABLE LABELS filter_$ 'Good_MRS = 1 & group = 3 & ZNAA_Percent_Change > -2.5 & '+ 
    'ZNAA_Percent_Change  < 2.5 (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE.

*NAA without influential datapoints for supplemental table note. 
T-TEST PAIRS=NAA_CR_1 WITH NAA_CR_2 (PAIRED) 
  /ES DISPLAY(TRUE) STANDARDIZER(SD) 
  /CRITERIA=CI(.9500) 
  /MISSING=ANALYSIS.


*look at glutamate effects by age. 
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 ). 
VARIABLE LABELS filter_$ 'Good_MRS = 1  (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
SORT CASES  BY patient. 
SPLIT FILE SEPARATE BY patient.
CORRELATIONS 
  /VARIABLES=Glu_CR_1 age 
  /PRINT=TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.
 
*sex effects in patients and controls sep.   
T-TEST GROUPS=sex(1 2) 
  /MISSING=ANALYSIS 
  /VARIABLES=Glu_CR_1 Glu_CR_2 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

*all subjects. 
SPLIT FILE OFF.
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 ). 
VARIABLE LABELS filter_$ 'Good_MRS = 1  (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
CORRELATIONS 
  /VARIABLES=Glu_CR_1 age 
  /PRINT=TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.

*sex effects in all subjs. 
T-TEST GROUPS=sex(1 2) 
  /MISSING=ANALYSIS 
  /VARIABLES=Glu_CR_1 Glu_CR_2 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).
   
USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 ). 
VARIABLE LABELS filter_$ 'Good_MRS = 1  (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
SORT CASES  BY condiiton_1WC_2CC_3PT. 
SPLIT FILE SEPARATE BY condiiton_1WC_2CC_3PT. 
CORRELATIONS 
  /VARIABLES=Glu_CR_2 age 
  /PRINT=TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.
   
*sex effects in post stress Glu, look at stress only (condition 2). 
T-TEST GROUPS=sex(1 2) 
  /MISSING=ANALYSIS 
  /VARIABLES=Glu_CR_2 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).


USE ALL. 
COMPUTE filter_$=(Good_MRS = 1 ). 
VARIABLE LABELS filter_$ 'Good_MRS = 1  (FILTER)'. 
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'. 
FORMATS filter_$ (f1.0). 
FILTER BY filter_$. 
EXECUTE. 
SORT CASES  BY Stress. 
SPLIT FILE SEPARATE BY Stress. 
CORRELATIONS 
  /VARIABLES=Glu_CR_2 age 
  /PRINT=TWOTAIL NOSIG FULL 
  /MISSING=PAIRWISE.
   
*sex effects in post stress Glu, look at stress only (condition 2). 
T-TEST GROUPS=sex(1 2) 
  /MISSING=ANALYSIS 
  /VARIABLES=Glu_CR_2 
  /ES DISPLAY(TRUE) 
  /CRITERIA=CI(.95).

