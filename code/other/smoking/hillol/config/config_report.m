%% FILENAME
function REPORT=config_report(G)
% option=wear,start,end,miss,valid
REPORT.SHORT.FRMTRAW.BASIC='pid,sid,date'; % option: pid, sid, date
REPORT.SHORT.FRMTRAW.SENSOR{G.SENSOR.R_RIPID}='RIP(wear),RIP(start),RIP(end),RIP(miss)';
REPORT.SHORT.FRMTRAW.SENSOR{G.SENSOR.R_ECGID}='ECG(miss)';
REPORT.SHORT.FRMTRAW.SENSOR{G.SENSOR.R_ECGID}='ACLX(miss)';
%REPORT.SHORT.FRMTRAW.SENSOR{G.SENSOR.P_ACLXID}='PhoneACLX(wear)';
REPORT.SHORT.FRMTRAW.SELFREPORT=['Report('  G.SELFREPORT.ID(G.SELFREPORT.SMKID).NAME '),Report('  G.SELFREPORT.ID(G.SELFREPORT.CRVID).NAME ')']; % Report(drinking)
REPORT.SHORT.FRMTRAW.EMA='EMA(triggered),EMA(answered)';
end
