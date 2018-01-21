#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include "mnistqbin8100.h"

#define points 1875
#define dims 1024

int main(void){
 FILE *fp;
 int i,j,k;
 int temp;
 fp = fopen("test_mnistqbin8100.h","w+");
 fprintf(fp,"signed int test_images[%d][%d]={\n",points,dims);
 for(i=0;i<points;i++){
 fprintf(fp,"{");
 for(j=0;j<dims;j++){
 temp = test_images[i][j]-127;
 fprintf(fp,"%d,",temp);
 }
 fprintf(fp,"},\n");
 }
 fprintf(fp,"};\n");
 fclose(fp);
 return 0;
}

