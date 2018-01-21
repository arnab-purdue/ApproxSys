/* Created by Arnab Raha
 * 6/3/2016
 * BLAS implementation
 * Image Smoothening Function
 * Last edited: 5/15/2017
 */ 

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
//#include "mt_nz_4x_qbin8.h"
#include "mt_nz.h"
#include <time.h>
#include <sys/timeb.h>
#define smooth_dim 9
int out_image[H][W];

int main(){



//Arnab added for calculating time
long long int start_time,time_difference;
long long int start_time_sec, time_difference_sec;
struct timespec gettime_now;
clock_gettime(CLOCK_REALTIME, &gettime_now);
start_time_sec = gettime_now.tv_sec;
start_time = gettime_now.tv_nsec;

int skipi,skipj,skipx,skipy;
int i,j,k,l,x,y,z;
int temp;
int total;


//approximation knobs setting
skipi=4;
skipj=4;
skipx=4;
skipy=4;

static int smooth1[smooth_dim][smooth_dim] ={
{0,1,2,4,8,4,2,1,0},
{1,2,4,8,16,8,4,2,1},
{2,4,8,16,32,16,8,4,2},
{4,8,16,32,64,32,16,8,4},
{8,16,32,64,128,64,32,16,8},
{4,8,16,32,64,32,16,8,4},
{2,4,8,16,32,16,8,4,2},
{1,2,4,8,16,8,4,2,1},
{0,1,2,4,8,4,2,1,0},
};

for(i=0;i<smooth_dim;i=i+skipx){
for(j=0;j<smooth_dim;j=j+skipy){
total += smooth1[i][j];
}}

for(i=0;i<4;i++){
for(j=0;j<W;j++){
out_image[i][j] = image[i][j];
}}


for(i=H-4;i<H;i++){
for(j=0;j<W;j++){
out_image[i][j] = image[i][j];
}}

for(i=0;i<H;i++){
for(j=0;j<4;j++){
out_image[i][j] = image[i][j];
}}

for(i=0;i<H;i++){
for(j=W-4;j<W;j++){
out_image[i][j] = image[i][j];
}}

for(i=4;i<H-4;i=i+skipi){
for(j=4;j<W-4;j=j+skipj){
temp = 0;
for(x=-4;x<5;x=x+skipx){
for(y=-4;y<5;y=y+skipy){
temp += image[x+i][y+j]*smooth1[x+4][y+4];
}}
temp = temp/(total);
out_image[i][j]= temp;

out_image[i+1][j]= temp;
out_image[i][j+1]= temp;
out_image[i+1][j+1]= temp;

out_image[i+2][j]= temp;
out_image[i][j+2]= temp;
out_image[i+1][j+2]= temp;
out_image[i+2][j+1]= temp;
out_image[i+2][j+2]= temp;


out_image[i+3][j]= temp;
out_image[i][j+3]= temp;
out_image[i+3][j+1]= temp;
out_image[i+1][j+3]= temp;
out_image[i+3][j+2]= temp;
out_image[i+2][j+3]= temp;
out_image[i+3][j+3]= temp;
}}
// Arnab added
struct timespec gettime_now_2;
clock_gettime(CLOCK_REALTIME, &gettime_now_2);
time_difference_sec = gettime_now_2.tv_sec - start_time_sec; 
time_difference = gettime_now_2.tv_nsec - start_time + 1000000000LL*time_difference_sec;
float time_sec = (float) time_difference/1000000000.0;
//printf("Main = %llu\n",time_difference);
//printf("Main = %f\n",time_sec);

//output to a matlab file
FILE *fp;
fp = fopen("smooth_app_skip4_4_xy_4_4.m","w+");
//fp = fopen("smooth_orig.m","w+");
//
fprintf(fp,"smooth_image = [\n");
for(i=0;i<H;i++){
fprintf(fp,"[");
for(j=0;j<W;j++){
fprintf(fp,"%d,",out_image[i][j]);
}
fprintf(fp,"]\n");
}
fprintf(fp,"];");

return 0;
}

