function [erpsMapsByTrialByROIs,erpsByROIs, meanERPSMap, R, Pboot, Rboot, ERP, freqs, timesout, mbase, maskersp, maskitc, g,PboottrialsByROI] = PlotERPS(patientROI,EEG,tlimits,cycles,frequencyRange,alpha,fdrCorrect,titleName,weightedSignificance,surroundingsWeight,scale,baseline,basenorm,erpsMax,marktimes)
%function [erpsByROIs, meanERPSMap, R, Pboot, Rboot, ERP, freqs, timesout,
%mbase, maskersp, maskitc, g] = PlotERPSByROI(patientROI,EEG,tlimits,frequencyRange,titleName)

erpsByROIs = [];
PboottrialsByROI = [];


[erpsMapsByTrial meanERPSMap, R, Pboot, Rboot, ERP, freqs, timesout, mbase, maskersp, maskitc, g,Pboottrials] = PlotERPSMap2(EEG,channels,tlimits,cycles,frequencyRange,alpha,fdrCorrect,[patientROI(1).prueba ' ' patientROI(1).tipo ' ' patientROI(1).condicion ' ' patientROI(i).name],weightedSignificance,surroundingsWeight,scale,baseline,basenorm,erpsMax,marktimes);

erps = meanERPSMap;
erpsMapsByTrial = erpsMapsByTrial;
Pboottrials.pboot = Pboottrials;

