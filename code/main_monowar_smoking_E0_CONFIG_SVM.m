function G=main_monowar_smoking_E0_CONFIG_SVM(G)
G.SVM.RIP_MPUFF.IND=[1:7, 10:12,14,19:21,23,29,32];G.SVM.RIP_MPUFF.NAME='rip_mpuff';
G.SVM.RIP_MPUFF_ROC.IND=[1:7, 10:12,14,19:21,23,29,32,8,9];G.SVM.RIP_MPUFF_ROC.NAME='rip_mpuff_roc';
G.SVM.RIP_MPUFF_ROC.C=5;G.SVM.RIP_MPUFF_ROC.G=5.56;G.SVM.RIP_MPUFF_ROC.TH=0.2;

G.SVM.RIP_ALL.IND=1:36*3;
G.SVM.RIP_RAW.IND=1:36;
G.SVM.RIP_DISP.IND=36+1:36*2;
G.SVM.RIP_RATIO.IND=36*2+1:36*3;
%G.SVM.RIP_SELECTED.IND=[6,8,14,15,23,24,39,42,45,50,51,53,54,60,63,79,100,105,108];
G.SVM.WRIST_ALL.IND=109:133;G.SVM.WRIST_ALL.NAME='wrist_all';
G.SVM.WRIST_MRP.IND=109:121;G.SVM.WRIST_MRP.NAME='wrist_mrp';
G.SVM.WRIST_MRP.C=10;G.SVM.WRIST_MRP.G=8;
G.SVM.RIP_ALL_WRIST_ALL.IND=1:138; G.SVM.RIP_ALL_WRIST_ALL.NAME='rip_all_wrist_all';
G.SVM.RIP_MPUFF_ROC_WRIST_MRP_TIME.IND=[G.SVM.RIP_MPUFF_ROC.IND, G.SVM.WRIST_MRP.IND,134:138];
G.SVM.RIP_MPUFF_ROC_WRIST_MRP_TIME.NAME='rip_mpuff_roc_wrist_mrp_time';
G.SVM.RIP_MPUFF_ROC_WRIST_MRP_TIME.C=3;
G.SVM.RIP_MPUFF_ROC_WRIST_MRP_TIME.G=1.2;
G.SVM.RIP_MPUFF_ROC_WRIST_MRP_TIME.TH=0.054;


G.SVM.RIP_SELECTED_WRIST_SELECTED.IND=[6,8,14,15,23,24,39,42,45,50,51,53,54,60,63,79,100,105,108,110,112,113,115,118,119,126,127,130,136,138];
G.SVM.RIP_SELECTED_WRIST_SELECTED.NAME='rip_selected_wrist_selected';
G.SVM.RIP_SELECTED_WRIST_SELECTED.C=5;%8;
G.SVM.RIP_SELECTED_WRIST_SELECTED.G=1;%9.5;
G.SVM.RIP_SELECTED_WRIST_SELECTED.TH=0.02;

G.SVM.H_RIP_SELECTED_WRIST_SELECTED.IND=[6,14,21,23,32,8,9,110,113,115,118,119,136];
G.SVM.H_RIP_SELECTED_WRIST_SELECTED.NAME='h_rip_selected_wrist_selected';
G.SVM.H_RIP_SELECTED_WRIST_SELECTED.C=2;%8;
G.SVM.H_RIP_SELECTED_WRIST_SELECTED.G=2;%9.5;
G.SVM.H_RIP_SELECTED_WRIST_SELECTED.TH=0.02;

G.SVM.HN_RIP_SELECTED_WRIST_SELECTED.IND=[6,14,17,18,26,27,21,23,32,8,9,110,113,115,118,119,136];
G.SVM.HN_RIP_SELECTED_WRIST_SELECTED.NAME='hn_rip_selected_wrist_selected';
G.SVM.HN_RIP_SELECTED_WRIST_SELECTED.C=4;%8;
G.SVM.HN_RIP_SELECTED_WRIST_SELECTED.G=2;%9.5;
G.SVM.HN_RIP_SELECTED_WRIST_SELECTED.TH=0.05;

%G.SVM.MODEL=G.SVM.H_RIP_SELECTED_WRIST_SELECTED;
%G.SVM.MODEL=G.SVM.RIP_MPUFF_ROC_WRIST_MRP_TIME;
G.SVM.MODEL=G.SVM.RIP_MPUFF_ROC;
%G.SVM.MODEL=G.SVM.WRIST_MRP;

%G.SVM.MODEL=G.SVM.RIP_MPUFF_ROC_WRIST_MRP_TIME;
%G.SVM.MODEL=G.SVM.RIP_MPUFF_ROC_WRIST_MRP_TIME;
