#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include "mnistqbin840.h"

#define points 1875
#define dims 512

int main(void){
 FILE *fp;
 int i,j,k;
 int temp;
 fp = fopen("test2x_mnistqbin8100.h","w+");
 fprintf(fp,"unsigned char test_images[%d][%d]={\n",points,dims);
 for(i=0;i<points;i++){
 fprintf(fp,"{");
 for(j=0;j<dims;j++){
 temp = test_images[i][2*j];
 fprintf(fp,"%d,",temp);
 }
 fprintf(fp,"},\n");
 }
 fprintf(fp,"};\n");
 fclose(fp);
 return 0;
}

