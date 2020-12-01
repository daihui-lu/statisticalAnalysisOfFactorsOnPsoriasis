libname source "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project";
*demographic;
libname demoa xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\DEMO_G.xpt";
libname demob xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\DEMO_H.xpt";
proc copy in = demoa out = source memtype = data;run;
proc copy in = demob out = source memtype = data;run;

*alcohol use;
libname alcohola xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\ALQ_G.xpt";
libname alcoholb xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\ALQ_H.xpt";
proc copy in = alcohola out = source memtype = data;run;
proc copy in = alcoholb out = source memtype = data;run;

*bmi;
libname bmia xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\BMX_G.xpt";
libname bmib xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\BMX_H.xpt";
proc copy in = bmia out = source memtype = data;run;
proc copy in = bmib out = source memtype = data;run;

*blood pressure;
libname bpa xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\BPQ_G.xpt";
libname bpb xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\BPQ_H.xpt";
proc copy in = bpa out = source memtype = data;run;
proc copy in = bpb out = source memtype = data;run;

*diq;
libname diqa xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\DIQ_G.xpt";
libname diqb xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\DIQ_H.xpt";
proc copy in = diqa out = source memtype = data;run;
proc copy in = diqb out = source memtype = data;run;

*medical questionnaire;
libname mcqa xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\MCQ_G.xpt";
libname mcqb xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\MCQ_H.xpt";
proc copy in = mcqa out = source memtype = data;run;
proc copy in = mcqb out = source memtype = data;run;

*smoking;
libname smqa xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\SMQ_G.xpt";
libname smqb xport "C:\Users\Min Kyung Lee\Desktop\Purdue\School\STAT526\Project\SMQ_H.xpt";
proc copy in = smqa out = source memtype = data;run;
proc copy in = smqb out = source memtype = data;run;
