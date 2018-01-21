/* Created by Arnab Raha
 * 6/3/2016
 * BLAS implementation
 * Image Filter - Smoothening Function
 * Last edited: 6/3/2016
 */ 

#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include "val_trupchun.h"
#include "val_trupchun_tbin.h"
#include "smooth2_vbin.h"
#define smooth_dim 15
#define margin 7 //(smooth_dim-1)/2

int out_image[H][W];

int main(){

int i,j,k,l,x,y,z;
int temp;
int total;


for(i=0;i<smooth_dim;i++){
for(j=0;j<smooth_dim;j++){
total += val_vbin[smooth2_vbin[i][j]];
//total+=smooth1[i][j];
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
int map[tbin_n][vbin_n];
for(k=0;k<tbin_n;k++){
for(l=0;l<vbin_n;l++){
map[k][l]=0;
}}
for(x=-margin;x<(margin+1);x++){
for(y=-margin;y<(margin+1);y++){
map[image_tbin[x+i][y+j]][smooth2_vbin[x+margin][y+margin]]++;
}}
for(k=0;k<tbin_n;k++){
for(l=0;l<vbin_n;l++){
temp +=map[k][l]*val_tbin[k]*val_vbin[l];
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

