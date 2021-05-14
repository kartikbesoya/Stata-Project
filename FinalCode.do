*EXTENT TO WHICH STUDENT LEARNING IS HINDERED

import excel "C:\Users\ARJUN A  P  Y\Desktop\IIM RA\Dataset.xlsx", sheet("School Questionnaire") firstrow clear
 
 keep CNTSCHID SC061Q01TA SC061Q02TA SC061Q03TA SC061Q04TA SC061Q05TA SC061Q11HA SC061Q06TA SC061Q07TA SC061Q08TA SC061Q09TA SC061Q10TA 

 
global xlist SC061Q01TA SC061Q02TA SC061Q03TA SC061Q04TA SC061Q05TA SC061Q11HA SC061Q06TA SC061Q07TA SC061Q08TA SC061Q09TA SC061Q10TA
global id CNTSCHID
global ncomp 3

 *To get descriptive statistics of the data like no. of observations, mean, std. dev. and min/max
 summarize
 
 *we observe no missing values here, but a misreported value as 9. which we treat as an outlier
 
 drop if SC061Q01TA >4
 drop if SC061Q03TA >4
 drop if SC061Q04TA >4
 drop if SC061Q05TA >4
 drop if SC061Q06TA >4 
 drop if SC061Q08TA >4
 
 summarize
 

. label variable SC061Q01TA "Student truancy"

. label variable SC061Q02TA "Students skipping classes"

. label variable SC061Q03TA "Students lacking respect for te"

. label variable SC061Q04TA "Student use of alcohol or illeg"

. label variable SC061Q05TA "Students intimidating or bullyi"

. label variable SC061Q11HA "Students not being attentive"

. label variable SC061Q06TA "Teachers not meeting individual"

. label variable SC061Q07TA "Teacher absenteeism"

. label variable SC061Q08TA "Staff resisting change"

. label variable SC061Q09TA "Teachers being too strict with "

. label variable SC061Q10TA "Teachers not being well prepare"


* Factor analysis
factor $xlist

* Scree plot of the eigenvalues
screeplot
screeplot, yline(1)

* Factor analysis (pf principal factors, pcf principal component factors)
factor $xlist, mineigen(1)
factor $xlist, factor($ncomp) 
factor $xlist, factor($ncomp) blanks(0.3)
factor $xlist, factor($ncomp) pcf

* Factor rotations
rotate, varimax 
rotate, varimax blanks(.3)
rotate, clear

rotate, promax
rotate, promax blanks(.3)
rotate, clear

estat common

* Scatter plots of the loadings and score variables
loadingplot
scoreplot

* Scores of the components
predict y1 y2 y3

* KMO measure of sampling adequacy
estat kmo

* Average interitem covariance
alpha $xlist

* Barlett's test for sphericity 
ssc install factortest
factortest $xlist

save "C:\Users\ARJUN A  P  Y\Desktop\hindrance.dta"





*DIGITAL CAPACITY OF SCHOOL- INDEPENDENT VARIABLE

import excel "C:\Users\ARJUN A  P  Y\Desktop\IIM RA\Dataset.xlsx", sheet("School Questionnaire") firstrow clear
 
keep CNTSCHID SC155Q01HA SC155Q02HA SC155Q03HA SC155Q04HA SC155Q05HA SC155Q06HA SC155Q07HA SC155Q08HA SC155Q09HA SC155Q10HA SC155Q11HA 
global zlist SC155Q01HA SC155Q02HA SC155Q03HA SC155Q04HA SC155Q05HA SC155Q06HA SC155Q07HA SC155Q08HA SC155Q09HA SC155Q10HA SC155Q11HA 
global id CNTSCHID
global ncomp 3

 *To get descriptive statistics of the data like no. of observations, mean, std. dev. and min/max
 summarize
 
 *we observe no missing values here, but a misreported value as 9. which we treat as an outlier
 
 drop if SC155Q01HA >4
 drop if SC155Q02HA >4
 drop if SC155Q03HA >4
 drop if SC155Q04HA >4
 drop if SC155Q05HA >4
 drop if SC155Q06HA >4
 drop if SC155Q07HA >4
 drop if SC155Q08HA >4
 drop if SC155Q09HA >4
 drop if SC155Q10HA >4
 drop if SC155Q11HA >4
 
 summarize
 

. label variable SC155Q01HA "The number of digital devices connected to the Internet is sufficient"

. label variable SC155Q02HA " The school's Internet bandwidth or speed is sufficient"

. label variable SC155Q03HA "The number of digital devices for instruction is sufficient"

. label variable SC155Q04HA "Digital devices [...] are sufficiently powerful in terms of computing capacity"

. label variable SC155Q05HA "The availability of adequate software is sufficient"

. label variable SC155Q06HA "Teachers have the [...] skills to integrate digital devices in instruction"

. label variable SC155Q07HA "Teachers have sufficient time to prepare lessons integrating digital devices"

. label variable SC155Q08HA "Effective professional resources for teachers to learn how to use digital [...]"

. label variable SC155Q09HA "An effective online learning support platform is available"

. label variable SC155Q10HA "Teachers are provided with incentives to integrate digital devices in [...] "

. label variable SC155Q11HA "The school has sufficient qualified technical assistant staff"


* Factor analysis
factor $zlist

* Scree plot of the eigenvalues
screeplot
screeplot, yline(1)

* Factor analysis (pf principal factors, pcf principal component factors)
factor $zlist, mineigen(1)
factor $zlist, factor($ncomp) 
factor $zlist, factor($ncomp) blanks(0.3)
factor $zlist, factor($ncomp) pcf

* Factor rotations
rotate, varimax 
rotate, varimax blanks(.3)
rotate, clear

rotate, promax
rotate, promax blanks(.3)
rotate, clear

estat common

* Scatter plots of the loadings and score variables
loadingplot
scoreplot

* Scores of the components
predict x1 x2 x3

* KMO measure of sampling adequacy
estat kmo

* Average interitem covariance
alpha $zlist

* Barlett's test for sphericity 
ssc install factortest
factortest $zlist

save "C:\Users\ARJUN A  P  Y\Desktop\digitalcapacity.dta"

merge 1:1 CNTSCHID using "C:\Users\ARJUN A  P  Y\Desktop\hindrance.dta"

drop if mi(y1)
drop if mi(x1)

reg y1 x1

save "C:\Users\ARJUN A  P  Y\Desktop\FinalDataset.dta"

