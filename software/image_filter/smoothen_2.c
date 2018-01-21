/* Created by Arnab Raha
 * 6/3/2016
 * BLAS implementation
 * Image Smoothening Function
 * Last edited: 6/3/2016
 */ 

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include "val_trupchun.h"
#define smooth_dim 15
#define margin 7 //(smooth_dim-1)/2

int out_image[H][W];

int main(){

int i,j,k,l,x,y,z;
int temp;
int total;

static int smooth1[smooth_dim][smooth_dim] ={
{0,1,2,4,8,16,32,64,32,16,8,4,2,1,0},
{1,2,4,8,16,32,64,128,64,32,16,8,4,2,1},
{2,4,8,16,32,64,128,256,128,64,32,16,8,4,2},
{4,8,16,32,64,128,256,512,256,128,64,32,16,8,4},
{8,16,32,64,128,256,512,1024,512,256,128,64,32,16,8},
{16,32,64,128,256,512,1024,2048,1024,512,256,128,64,32,16},
{32,64,128,256,512,1024,2048,4096,2048,1024,512,256,128,64,32},
{64,128,256,512,1024,2048,4096,8092,4096,2048,1024,512,256,128,64},
{32,64,128,256,512,1024,2048,4096,2048,1024,512,256,128,64,32},
{16,32,64,128,256,512,1024,2048,1024,512,256,128,64,32,16},
{8,16,32,64,128,256,512,1024,512,256,128,64,32,16,8},
{4,8,16,32,64,128,256,512,256,128,64,32,16,8,4},
{2,4,8,16,32,64,128,256,128,64,32,16,8,4,2},
{1,2,4,8,16,32,64,128,64,32,16,8,4,2,1},
{0,1,2,4,8,16,32,64,32,16,8,4,2,1,0},
};

for(i=0;i<smooth_dim;i++){
for(j=0;j<smooth_dim;j++){
total += smooth1[i][j];
}}

for(i=0;i<margin;i++){
for(j=0;j<W;j++){
out_image[i][j] = image[i][j];
}}


for(i=H-margin;i<H;i++){
for(j=0;j<W;j++){
out_image[i][j] = image[i][j];
}}

for(i=0;i<H;i++){
for(j=0;j<margin;j++){
out_image[i][j] = image[i][j];
}}

for(i=0;i<H;i++){
for(j=W-margin;j<W;j++){
out_image[i][j] = image[i][j];
}}

for(i=margin;i<H-margin;i++){
for(j=margin;j<W-margin;j++){
temp = 0;
for(x=-margin;x<(margin+1);x++){
for(y=-margin;y<(margin+1);y++){
temp += image[x+i][y+j]*smooth1[x+margin][y+margin];
}}
temp = temp/(total);
out_image[i][j]= temp;
}}

//output to a matlab file
FILE *fp;
fp = fopen("smooth.m","w+");

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

