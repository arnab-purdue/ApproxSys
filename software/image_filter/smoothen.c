/* Created by Arnab Raha
 * 6/3/2016
 * BLAS implementation
 * Image Smoothening Function
 * Last edited: 6/3/2016
 */ 

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
//#include "mt_nz.h"
#include "mt_nz4xqbin8100.h"
#define smooth_dim 9

#define H 600
#define W 800

int out_image[H][W];

int main(){

int i,j,k,l,x,y,z;
int temp;
int total;

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

for(i=0;i<smooth_dim;i++){
for(j=0;j<smooth_dim;j++){
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

for(i=4;i<H-4;i++){
for(j=4;j<W-4;j++){
temp = 0;
for(x=-4;x<5;x++){
for(y=-4;y<5;y++){
temp += image[x+i][y+j]*smooth1[x+4][y+4];
}}
temp = temp/(total);
out_image[i][j]= temp;
}}

FILE *fp;
fp = fopen("smooth_mt_nz4xqbin8100.m","w+");
//fp = fopen("smooth.m","w+");

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

