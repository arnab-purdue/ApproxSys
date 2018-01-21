#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include "pointval.h"
#include "pointsnew.h"
#include "input.h"


int main(){
FILE *fp1;

fp1 = fopen("input4x.h","w");

int i = 0;
int j = 0;
int m = 0;
int skip = 1;
int noip,nump;
int dim_res;
int dimc;
dimc = dim;
int single_dim = sqrt(dimc);
int skiprow,skipcol;


skipcol=2;
skiprow=2; //skip
noip = no_inputs;
nump = num_points;
dim_res = dimc/(skipcol*skiprow);

printf("%d\n",single_dim);

//fprintf(fp1,"#ifndef POINTS_H\n");
//fprintf(fp1,"#define POINTS_H\n");

fprintf(fp1,"#define dim %d\n",dim_res);
fprintf(fp1,"int input[%d][%d]={\n",noip,dim_res);
for(j=0;j<no_inputs;j++){
fprintf(fp1,"{");
for(m=0;m<dim;m=m+skiprow*single_dim){
for(i=m;i<m+single_dim;i=i+skipcol){
fprintf(fp1,"%d,",input[j][i]);}
}
fprintf(fp1,"},\n");
}
fprintf(fp1,"};\n\n\n");
//fprintf(fp1,"#endif /*POINTS_H*/");

fclose(fp1);

fp1 = fopen("pointval4x.h","w");

fprintf(fp1,"int point_val[%d][%d]={\n",nump,dim_res);
for(j=0;j<num_points;j++){
fprintf(fp1,"{");
for(m=0;m<dim;m=m+skiprow*single_dim){
for(i=m;i<m+single_dim;i=i+skipcol){
fprintf(fp1,"%d,",point_val[j][i]);}
}
fprintf(fp1,"},\n");
}
fprintf(fp1,"};\n\n\n");



}
