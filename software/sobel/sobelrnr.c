/*ECE 695 SOC
Arnab Raha
Purdue University */

#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<float.h>
#include <time.h>
#include <sys/timeb.h>
#include"sobel_eagle_orig.h"
#include "eagle9x_qbin8.h"

#define MAX1 1200
#define MAX2 1600
//#define MAX3 H1 
//#define MAX4 W1
#define MAX3 600
#define MAX4 800
#define MAX_BRIGHTNESS 256
#define INTMAX 256
#define gbmin 0.5//0.1
#define gbmax 0.5//0.1

signed int image2[MAX1][MAX2];
signed int image2app[MAX1][MAX2];

int main(void )
{
  /* Definition of Sobel filter in horizontal direction */
signed int weight[3][3] = {{ -1,  0,  1 },
                  { -2,  0,  2 },
                  { -1,  0,  1 }};

 
//Arnab added for calculating time
long long int start_time,time_difference;
long long int start_time_sec, time_difference_sec;
struct timespec gettime_now;
clock_gettime(CLOCK_REALTIME, &gettime_now);
start_time_sec = gettime_now.tv_sec;
start_time = gettime_now.tv_nsec;
 
signed int pixel_value;
signed int min, max;
int x, y, i, j;  /* Loop variable */

min = INTMAX;
max = -INTMAX;
int cont = 0;
for (y = 1; y < MAX1 - 1; y++) {
  for (x = 1; x < MAX2 - 1; x++) {
    pixel_value = 0.0;
    for (j = -1; j <= 1; j++) {
        for (i = -1; i <= 1; i++) {
          pixel_value += weight[j + 1][i + 1] * image_sobel[y + j][x + i];
        }
    }
    if (pixel_value < min) min = pixel_value;
    if (pixel_value > max) max = pixel_value;
	cont = cont + 1;
  }
}
printf ("contorig->%d\n",cont);

  for (y = 0; y < MAX1; y++) {
    for (x = 0; x < MAX2; x++) {
      image2[y][x] = 0;
      image2app[y][x] = 0;
    }
  }
 
int origcnt=0;; 
for (y = 1; y < MAX1 - 1; y++) {
    for (x = 1; x < MAX2 - 1; x++) {
      pixel_value = 0.0;
      for (j = -1; j <= 1; j++) {
          for (i = -1; i <= 1; i++) {
            pixel_value += weight[j + 1][i + 1] * image_sobel[y + j][x + i];
           origcnt++;
   	   }
      }
      pixel_value = MAX_BRIGHTNESS * (pixel_value - min) / (max - min);
      image2[y][x] = abs(pixel_value);
    }
  }

int thresh = 150;
//0 for black and 1 for white

for (y = 0; y < MAX1 ; y++) {
    for (x = 0; x < MAX2 ; x++) {
	if(image2[y][x]>=thresh){
		image2[y][x]=0;}
	else{
		image2[y][x]=1;}
}}
// Arnab added
struct timespec gettime_now_2;
clock_gettime(CLOCK_REALTIME, &gettime_now_2);
time_difference_sec = gettime_now_2.tv_sec - start_time_sec; 
time_difference = gettime_now_2.tv_nsec - start_time + 1000000000LL*time_difference_sec;
float time_sec = (float) time_difference/1000000000.0;
//printf("Main Orig= %llu\n",time_difference);
//printf("Main Orig= %f\n",time_sec);
//book-keeping stuff
/*printf("Original output \n");
for (y = 1; y < MAX - 1; y++) {
for (x = 1; x < MAX - 1; x++) {
printf("%d ",image2[y][x]);
}
printf("\n");
}*/


//*************************************************************************
//for LD
/*approximate version*/
//Arnab added for calculating time
//long long int start_time,time_difference;
//long long int start_time_sec, time_difference_sec;
struct timespec gettime_now_3;
clock_gettime(CLOCK_REALTIME, &gettime_now_3);
start_time_sec = gettime_now_3.tv_sec;
start_time = gettime_now_3.tv_nsec;

signed int pixel_valueapp;
signed int minapp, maxapp;
minapp = INTMAX;
maxapp = -INTMAX;
//int check[MAX2-1];
int f;
int count = 0;
int cont1 = 0;
//Computational approx knobs - Arnab
//Value 0 for accurate
//int skipx = 100;//skipping in x direction
//int skipy = 100;//skipping in y direction 
//for (f= 0; f< MAX2-1; f++)
//{
//check[f] = 0;//araha: check for vertical direction skipping: high error
//}
for (y = 1 ; y < MAX3 - 1; y=y+1) {
  for (x = 1; x < MAX4 - 1; x=x+1) {
 //   if (check[x] == 0){
    cont1 = cont1 + 1;
    count++;
    pixel_valueapp = 0.0;
    for (j = -1; j <= 1; j++) {
        for (i = -1; i <= 1; i=i+1) {
          pixel_valueapp += weight[j + 1][i + 1] * image1_app[y + j][x + i];
          //pixel_valueapp += weight[j + 1][i + 1] * image_sobel[y + j][x + i];
        }
    }
    if (pixel_valueapp < minapp) {
	minapp = pixel_valueapp;
	}
    else if (pixel_valueapp > maxapp) {
	maxapp = pixel_valueapp; 
	}
  //  else if ((pixel_valueapp > gbmin*minapp) && (pixel_valueapp < gbmax*maxapp)){
  //  check[x] = skipy;
  //  x=x+skipx;
  //} 
//}
//else{
//check[x]--;
}
}
//}
printf ("contapprox->%d\n",cont1);

int approxcnt = 0;
int skippty = 1;
int skipptx = 1;
//Arnab skipped here
for (y = 1; y < MAX3 - 1; y=y+skippty) {
    for (x = 1; x < MAX4 - 1; x=x+skipptx) {
      pixel_valueapp = 0.0;
      for (j = -1; j <= 1; j++) {
          for (i = -1; i <= 1; i=i+1) {
            pixel_valueapp += weight[j + 1][i + 1] * image1_app[y + j][x + i];
            //pixel_valueapp += weight[j + 1][i + 1] * image_sobel[y + j][x + i];
	    approxcnt++;
          }
      }
      pixel_valueapp = MAX_BRIGHTNESS * (pixel_valueapp - minapp) / (maxapp - minapp);
      image2app[y][x] = abs(pixel_valueapp);
      //image2app[y][x+1] = abs(pixel_valueapp);
      //image2app[y+1][x+1] = abs(pixel_valueapp);
      //image2app[y+1][x] = image2app[y][x];
      //image2app[y+2][x] = image2app[y][x];
    }
  }

//Thresholding

thresh = 150;

		


//0 for black and 1 for white
for (y = 0; y < MAX3 ; y++) {
    for (x = 0; x < MAX4 ; x++) {
	if(image2app[y][x]>=thresh){
		image2app[y][x]=0;}
	else{
		image2app[y][x]=1;}
}}
		

// Arnab added
struct timespec gettime_now_4;
clock_gettime(CLOCK_REALTIME, &gettime_now_4);
time_difference_sec = gettime_now_4.tv_sec - start_time_sec; 
time_difference = gettime_now_4.tv_nsec - start_time + 1000000000LL*time_difference_sec;
time_sec = (float) time_difference/1000000000.0;
//printf("Main Approx= %llu\n",time_difference);
//printf("Main Approx= %f\n",time_sec);
//******************************************************************************





printf("Orig Count = %d; Approx Count = %d;\n",origcnt,approxcnt);
//book-keeping stuff
/*printf("---------------------------------------------------------------\n");
printf("Approximate output\n");
for (y = 1; y < MAX - 1; y++) {
for (x = 1; x < MAX - 1; x++) {
printf("%d ",image2app[y][x]);
}
printf("\n");
}*/

//Error calculation
float temp,temp2,temp3,temp4 = 0.0;
float err = 0.0000;
float errmin,errmax = 0.0;
/*
for (y = 1; y < MAX1 - 1; y++) {
for (x = 1; x < MAX2 - 1; x++) {
temp = temp + abs(image2[y][x] - image2app[y][x]);
temp2 = temp2 + abs(image2[y][x]);
}
}
*/

//Error calculation for unequal dimensions
for (y = 1; y < MAX1 - 1; y++) {
for (x = 1; x < MAX2 - 1; x++) {
temp = temp + image2[y][x];
}
}


for (y = 1; y < MAX3 - 1; y++) {
for (x = 1; x < MAX4 - 1; x++) {
temp2 = temp2 + image2app[y][x];
}
}

temp = temp/(MAX1*MAX2);
temp2 = temp2/(MAX3*MAX4);


//printf("%d\n",count);
//printf("%.2f, %.2f \n",temp,temp2);
//err = temp/temp2*100.0;
err = (temp-temp2)/temp*100.0000;
//err = (temp/(MAX*MAX));
temp3 = abs(min-minapp)/(float)abs(min);
errmin = temp3*100.0;
temp4 = abs(max-maxapp)/(float)abs(max);
errmax = temp4*100.0;
printf("temp= %.5f, temp2 = %.5f \n",temp, temp2);
printf("Percentage SADErr = %.5f \n",err);
printf("Percentage MinErr = %.2f \n",errmin);
printf("Percentage MaxErr = %.2f \n",errmax);
printf("%d %d %d %d \n",min,max,minapp,maxapp);

return 0;

}






