#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include "orig_pixels.h"
//#include "orig_pixels_6_8.h"
//#include "orig_pixels_3_4.h"
//#include "orig_pixels_1_5_2.h"
//#include "orig_pixels_128_72.h"
//#include "orig_pixels_64_36.h"
//#include "orig_pixels_32_18.h"
//#include "orig_pixels_6_16.h"
#include "raw_pixels.h"

#define H 1200
#define W 1600

//#define H 600
//#define W 800

//#define H 300
//#define W 400

//#define H 150
//#define W 200

//#define H 720
//#define W 1280

//#define H 360
//#define W 640

//#define H 180
//#define W 320

//#define H 600
//#define W 1600

int main(){
int i,j;
int sadapp,sumorig;

sadapp=0;
sumorig=0;

for (i=0;i<H;i++){
for (j=0;j<W;j++){
sumorig+=orig[i][j];
}}


for (i=0;i<H;i++){
for (j=0;j<W;j++){
sadapp+=abs(app[i][j]-orig[i][j]);
}
float err_perc = (float) sadapp/(float)sumorig*100.0;
printf("Perc. Error => %f\n",err_perc);
return 0;
}

}
