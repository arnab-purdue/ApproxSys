#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "val_trupchun.h"
#define tbin0 0
#define tbin1 1
#define tbin2 2
#define tbin3 3
#define tbin4 4

int main(){

int i,j,k,l,m,n;
int temp;
FILE *fp;


int val_tbin0=0;
int val_tbin1=10;
int val_tbin2=50;
int val_tbin3=125;
int val_tbin4=200;
int tbin_n=5;

fp = fopen("val_trupchun_tbin.h","w+");
fprintf(fp,"#define tbin_n %d",tbin_n);
fprintf(fp,"int val_tbin[tbin_n] = {%d,%d,%d,%d,%d};",val_tbin0,val_tbin1,val_tbin2,val_tbin3,val_tbin4);
fprintf(fp,"int image_tbin[H][W]={\n");

for(i=0;i<H;i++){
fprintf(fp,"{");
for(j=0;j<W;j++){
if (image[i][j]==0){
temp = tbin0;
}
else if (image[i][j]<=25){
temp = tbin1;
}
else if (image[i][j]<=75){
temp = tbin2;
}
else if (image[i][j]<=150){
temp = tbin3;
}
else{
temp = tbin4;
}
fprintf(fp,"%d,",temp);
}
fprintf(fp,"},\n");
}

fprintf(fp,"};\n");

return 0;
}
