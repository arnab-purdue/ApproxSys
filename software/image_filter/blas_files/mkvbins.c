#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define vbin0 0
#define vbin1 1
#define vbin2 2
#define vbin3 3
#define vbin4 4
#define vbin5 5
#define smooth_dim 15

int main(){

int val_vbin0=0;
int val_vbin1=8;
int val_vbin2=64;
int val_vbin3=256;
int val_vbin4=1024;
int val_vbin5=4096;
int vbin_n=6;

static int smooth2[smooth_dim][smooth_dim] ={
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

int i,j,k,l,m,n;
int temp;
FILE *fp;
fp = fopen("smooth2_vbin.h","w+");
fprintf(fp,"#define vbin_n %d",vbin_n);
fprintf(fp,"int val_vbin[vbin_n] = {%d,%d,%d,%d,%d,%d};",val_vbin0,val_vbin1,val_vbin2,val_vbin3,val_vbin4,val_vbin5);
fprintf(fp,"int smooth2_vbin[%d][%d]={\n",smooth_dim,smooth_dim);

for(i=0;i<smooth_dim;i++){
fprintf(fp,"{");
for(j=0;j<smooth_dim;j++){
if (smooth2[i][j]==0){
temp = vbin0;
}
else if (smooth2[i][j]<=16){
temp = vbin1;
}
else if (smooth2[i][j]<128){
temp = vbin2;
}
else if (smooth2[i][j]<=512){
temp = vbin3;
}
else if (smooth2[i][j]<=2048){
temp = vbin4;
}
else{
temp = vbin5;
}
fprintf(fp,"%d,",temp);
}
fprintf(fp,"},\n");
}

fprintf(fp,"};\n");

return 0;
}
