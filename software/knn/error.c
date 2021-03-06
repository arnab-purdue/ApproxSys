#include<stdio.h>
#include<stdlib.h>
#include<math.h>

#define MAX 10
#define page_size 1024 //in bytes
//#include "pointskmeans.h"
//#include "RGB_orig_test_800_600_2.h"
//#include "sobel_800x600_image.h"
//#define maxim
#include "RGB_orig_digit_1600_1200_lower_res_tmp_2.h"
#define approx

/*
#define dim1 8 
#define dim2 16
#define dim3 48
#define dim4 64
*/

//#define dim 600
#define dim 3
#define num_points 120000
//#define num_points 800


int main(){
int cnt_vect,cnt_dim;  
int rand_gen;
//original definitions
//int qbinst1[MAX]={0,1,2,10,15,20,25,30,35,50};
//int qbinst2[MAX]={0,1,2,10,15,20,25,30,35,50};
//synthetic definitions

time_t t;
srand((unsigned) time(&t));
//srand((unsigned) 2);

int qbinst2[MAX]={0,1,2,5,10,15,20,25,30,40};

int qbin_ind1 = 2;
int qbin_ind2 = 0;
int qbin_ind3 = 0;
int qbin_ind4 = 2;
  //float per = qbinst2[9]/(page_size/4);
  //int qbinst3[MAX]=[];
  //int qbinst4[MAX]=[];
int max = 0;

#ifdef maxim 
for(cnt_vect=0;cnt_vect<num_points;cnt_vect++){
for(cnt_dim=0;cnt_dim<dim;cnt_dim++){
if (point_val[cnt_vect][cnt_dim]>max){
max = point_val[cnt_vect][cnt_dim];
}
}}

printf("Max = %d\n",max);

#endif

#ifdef approx
//srand(2); 
for(cnt_vect=0;cnt_vect<num_points;cnt_vect++){
for(cnt_dim=0;cnt_dim<dim;cnt_dim++){
 rand_gen = rand()%(page_size); //considering the bits have been marked 
 if(rand_gen<qbinst2[qbin_ind1]){
 point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] ^ (1 <<(rand()%8));
// image1[cnt_vect][cnt_dim] = image1[cnt_vect][cnt_dim] ^ (1 <<(rand()%8));
 // point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] | (1 <<(rand()%8));
 // point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] & ~(1 <<(rand()%8));
}}
/*for(cnt_dim=dim1;cnt_dim<dim2;cnt_dim++){
 rand_gen = rand()%(page_size); //considering the bits have been marked 
 if(rand_gen<qbinst2[qbin_ind2]){
 point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] ^ (1 <<(rand()%8));
 //point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] | (1 <<(rand()%8));
 //point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] & ~(1 <<(rand()%8));
}}
for(cnt_dim=dim2;cnt_dim<dim3;cnt_dim++){
 rand_gen = rand()%(page_size); //considering the bits have been marked 
 if(rand_gen<qbinst2[qbin_ind3]){
 point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] ^ (1 <<(rand()%8));
 //point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] | (1 <<(rand()%8));
 //point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] & ~(1 <<(rand()%8));
}}
for(cnt_dim=dim3;cnt_dim<dim4;cnt_dim++){
 rand_gen = rand()%(page_size); //considering the bits have been marked 
 if(rand_gen<qbinst2[qbin_ind4]){
 point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] ^ (1 <<(rand()%8));
 //point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] | (1 <<(rand()%8));
 //point_val[cnt_vect][cnt_dim] = point_val[cnt_vect][cnt_dim] & ~(1 <<(rand()%8));
}*/
}
#endif
 
FILE *fd;
//fd = fopen("drampointskmeans.h", "w+");
fd = fopen("digitrecog400_300.h", "w+");
fprintf(fd,"int point_val[%d][%d] = {\n",num_points,dim);
//fprintf(fd,"signed int image1[%d][%d] = {\n",num_points,dim);
for(cnt_vect=0;cnt_vect<num_points;cnt_vect++){
fprintf(fd,"{");
for(cnt_dim=0;cnt_dim<dim;cnt_dim++){
fprintf(fd,"%d,",point_val[cnt_vect][cnt_dim]);
//fprintf(fd,"%d,",image1[cnt_vect][cnt_dim]);
}
fprintf(fd,"},\n");
}
fprintf(fd,"};");


fclose(fd);
return 0;

}

