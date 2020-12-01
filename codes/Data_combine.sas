
data nhanes_11_12 ;
	merge source.demo_g(in=a) source.alq_g(in=b) source.bmx_g(in = c) source.bpq_g(in = d) source.diq_g(in = e) source.mcq_g(in=f) source.smq_g (in=g) ;
	by SEQN;
	keep SEQN MCQ075 SDDSRVYR RIDRETH3 RIAGENDR RIDAGEYR DMDBORN4 DMDCITZN INDFMPIR SEQN BMXBMI SMQ020 BPQ020 ALQ120Q DIQ010;
	if a=1 and b=1 and c=1 and d=1 and e=1 and f=1 and g=1;
run;

data nhanes_13_14 ;
	merge source.demo_h(in=a) source.alq_h(in=b) source.bmx_h(in = c) source.bpq_h(in = d) source.diq_h(in = e) source.mcq_h(in=f) source.smq_h(in=g) ;
	by SEQN;
	keep SEQN MCQ075 SDDSRVYR RIDRETH3 RIAGENDR RIDAGEYR DMDBORN4 DMDCITZN INDFMPIR SEQN BMXBMI SMQ020 BPQ020 ALQ120Q DIQ010;
	if a=1 and b=1 and c=1 and d=1 and e=1 and f=1 and g=1;
run;

data nhanes_psoriasis;	
set nhanes_11_12 nhanes_13_14; 
if MCQ075 in (1,2,3,4);
run;


	proc export data=nhanes_psoriasis
	outfile='C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\nhanes_psoriasis.csv'
	dbms=csv
	replace;
	run;

