* Encoding: UTF-8.
*compute the variables that we need. 
*starting with verything relative to creatine. 
*create stress variable for groups 1, 3, and 4. 


COMPUTE Glu_CR_1=Glu1/Cr1. 
EXECUTE.

COMPUTE Glu_CR_2=Glu2/Cr2. 
EXECUTE.

COMPUTE Asp_CR_1=Asp1/Cr1. 
EXECUTE.

COMPUTE Asp_CR_2=Asp2/Cr2. 
EXECUTE.

COMPUTE Cho_CR_1=Cho1/Cr1. 
EXECUTE.

COMPUTE Cho_CR_2=Cho2/Cr2. 
EXECUTE.

COMPUTE Gln_CR_1=Gln1/Cr1. 
EXECUTE.

COMPUTE Gln_CR_2=Gln2/Cr2. 
EXECUTE.

COMPUTE Myo_CR_1=Myo1/Cr1. 
EXECUTE.

COMPUTE Myo_CR_2=Myo2/Cr2. 
EXECUTE.

COMPUTE NAA_CR_1=NAA1/Cr1. 
EXECUTE.

COMPUTE NAA_CR_2=NAA2/Cr2. 
EXECUTE.

COMPUTE Glx_CR_1=(Gln1+Glu1)/Cr1. 
EXECUTE.

COMPUTE Glx_CR_2=(Gln2+Glu2)/Cr2. 
EXECUTE.

COMPUTE Glu_Percent_Change=((Glu_CR_2-Glu_CR_1)/Glu_CR_1)*100. 
EXECUTE.

COMPUTE Glx_Percent_Change=((Glx_CR_2-Glx_CR_1)/Glx_CR_1)*100. 
EXECUTE.

COMPUTE Cho_Percent_Change=((Cho_CR_2-Cho_CR_1)/Cho_CR_1)*100. 
EXECUTE.

COMPUTE NAA_Percent_Change=((NAA_CR_2-NAA_CR_1)/NAA_CR_1)*100. 
EXECUTE.


COMPUTE Myo_Percent_Change=((Myo_CR_2-Myo_CR_1)/Myo_CR_1)*100. 
EXECUTE.

COMPUTE Asp_Percent_Change=((Asp_CR_2-Asp_CR_1)/Asp_CR_1)*100. 
EXECUTE.

COMPUTE Gln_Percent_Change=((Gln_CR_2-Gln_CR_1)/Gln_CR_1)*100. 
EXECUTE.

*compute residual using the mclean sample regression line. 
COMPUTE Residual_MGR=Glu_Percent_Change-(35.647-3.093*pss_screening). 
EXECUTE.

*include a variable for dummy coded sex 0 for female and 1 for male. 
COMPUTE Sex_dummy=2-Sex. 
EXECUTE.



*compute cortisol concentrations relative to the first (beginning of scan) sample. 
COMPUTE Cortisol1=(Sample2nmoll/Sample2nmoll)*100.
EXECUTE.

COMPUTE Cortisol2=(Sample3nmoll/Sample2nmoll)*100. 
EXECUTE.

COMPUTE Cortisol3=(Sample4nmoll/Sample2nmoll)*100. 
EXECUTE.


COMPUTE CR_Glu_Average=(Glu_SD1+Glu_SD2)/2. 
EXECUTE.



COMPUTE PSS_hi_lo=1. 
EXECUTE.
IF  (pss_screening > 9) PSS_hi_lo=2. 
EXECUTE.


*create mean centered age and pss variables (and interaction terms) for regressions. 
*the HC will be used for the regressions that are stress and no stress HCs .

COMPUTE HC_Age_MC=Age-26.107692. 
EXECUTE.

COMPUTE HC_PSS_MC=pss_screening-10.292308. 
EXECUTE.

COMPUTE HC_PSSMC_byStress=HC_PSS_MC*Stress. 
EXECUTE.


*calculate the mean-centered PSS for ONLY groups 1 and 3 (HC stress conditions). 
*make interaction terms using this mean centered PSS variable 
*to look at PSS*age and PSS*sex interactions on glutamate change in the 
*HC stress samples. 

COMPUTE Group1and3_PSS_MC=pss_screening-9.595745. 
EXECUTE.

COMPUTE Group1and3_Age_MC = Age-27.127660. 

COMPUTE Group1and3_PssXAge = Group1and3_PSS_MC*Group1and3_Age_MC. 
EXECUTE.

COMPUTE Group1and3_PssXSex = Group1and3_PSS_MC*Sex_dummy. 
EXECUTE.

COMPUTE HC_Sex_byPSS=Sex_dummy*HC_PSS_MC. 
EXECUTE.



COMPUTE Stress_PSS_MC=pss_screening-15.471429. 
EXECUTE.

COMPUTE Stress_Age_MC=Age-28.028571. 
EXECUTE.

COMPUTE Stress_PSSMC_byPatient=Stress_PSS_MC*Patient. 
EXECUTE.

COMPUTE Stress_PSSMC_squared=Stress_PSS_MC*Stress_PSS_MC. 
EXECUTE.

COMPUTE PSS_squared=pss_screening*pss_screening. 
EXECUTE.

*for birth control interaction with PSS. 
COMPUTE PSS_MS_forBC = pss_screening - 8.718750. 
EXECUTE.

COMPUTE BC_code_dummy=2-BC_code. 
EXECUTE.

COMPUTE BCxPSSint=PSS_MS_forBC*BC_code_dummy. 
EXECUTE.

*VAMS percent change for supplementary analysis. 
COMPUTE VAMS_Percent_Change=(Mood_T4_MeanNeg-Mood_T2_MeanNeg)/Mood_T2_MeanNeg*100. 
EXECUTE.

