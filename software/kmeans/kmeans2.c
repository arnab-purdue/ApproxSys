/* ECE695 SOC Project
Arnab Raha
Purdue University */

//All double variables turned to integer for Precision Scaling
#include <stdlib.h>
#include <stdio.h>
#include <float.h>
#include <math.h>
#include <string.h>
#include <time.h>
#include <sys/timeb.h>
//#include "pointskmeans.h"
//#include "panda2x.h"
//#include "panda_orig4x100.h"
//#include "panda_orig9x.h"
//#include "panda_orig4x.h"
#include "panda_approx4x_qbin8.h"

//#define MAX 576000//num_points 
//#define MAX 2304000//num_points 
//#define MAX 1920000//num_points 

#define rows 600
#define cols 800
#define pixels 480000

#define MAX pixels//num_points 
#define DIMS 3 //64 
#define CLUSTERS 3
#define INTEGER_MAX 2147483647
//quality knobs

#define dim1 8 
#define dim2 4
#define dim3 2
#define qual 1

#define ctrl 1
#define dim 3
//#define approxstart 16 //valid only fro 32->64
#define k1 1 //0.125
#define k2 1 //0.25
#define k3 1 //0.50
#define k4 1 //0.75
#define k5 1 
#define pointskip 1
#define degcomp 0

//#define RNR
static inline unsigned int get_sq_dist_8(int *, int *, int);
static inline unsigned int get_sq_dist_16(int *, int *, int);
static inline unsigned int get_sq_dist_32(int *, int *, int);
static inline unsigned int get_sq_dist_64(int *, int *, int);
int finaldist(int, int *, int *,int, int);

//loop counters
int total_count=0;
int countxk1=0;
int countxk2=0;
int countxk3=0;
int countxk4=0;
int countx1=0;
int countxskip=0;
int countlvl2_k1=0;
int countlvl2_k2=0;
int countlvl2_k3=0;
int countlvl2_k4=0;
int countl2=0;
int countlvl2skip=0;
int countlvl3_k1=0;
int countlvl3_k2=0;
int countlvl3_k3=0;
int countlvl3_k4=0;
int countl3=0;
int countlvl3skip=0;

int deg1 = 0; //0
int deg2 = 0; //0
int deg3 = 0; //1
int deg4 = 0; //2
int deg5 = 0; //3
int degree = 0;
int countskip = 0;

int main(void)
{
FILE *fp;
//fp = fopen("panda_approx4x_qbin6_ctrl_iter7.m", "w+");
//Arnab added for calculating time
long long int start_time,time_difference;
long long int start_time_sec, time_difference_sec;
struct timespec gettime_now;
clock_gettime(CLOCK_REALTIME, &gettime_now);
start_time_sec = gettime_now.tv_sec;
start_time = gettime_now.tv_nsec;

   int n = MAX;
   int m = DIMS;
   int k = CLUSTERS;
   int **centroids = 0;   
	
/* output cluster label for each data point */
   int *labels = (int*)calloc(n, sizeof(int));
   int z,h, i, j; /* loop counters, of course :) */
   int *counts = (int*)calloc(k, sizeof(int)); /* size of each cluster */
   int old_error, error = MAX; /* sum of squared euclidean distance */
   int **c = centroids ? centroids : (int**)calloc(k, sizeof(int*));
   int **c1 = (int**)calloc(k, sizeof(int*)); /* temp centroids */
 
//Declared for RNR
   int *points, *inp;  
   points = &point_val[0][0];  
   /* initialization */

   for (h = i = 0; i < k; h += n/k , i++) {
       c1[i] = (int*)calloc(m, sizeof(int));
       if (!centroids) {
       c[i] = (int*)calloc(m, sizeof(int));
      }
      /* pick k points as initial centroids */
      for (j = m-1; j-- >= 0; c[i][j] = point_val[h][j]);
   }

   /* main loop */

//   do 
for (z=0;z<7;z++)
{
int radius[k];
int il;
int tempo, trigger;
for (il = 0; il<k ; il++)
{
radius[il] = 0;
}
      /* save error from last step */
      old_error = error, error = 0;
      /* clear old counts and temp centroids */
      for (i = 0; i < k; i++)
        {
          counts[i] = 0;
          for (j = 0; j < m; j++)
           {
		c1[i][j] = 0;
	}
      }
	
	int del_dist; 
	for (h = 0; h < n; h=h+1) {
	// for printing the adjacent distances
        //printf("%d\n",h);
	countskip = countskip + 1;
	trigger = 0; 
	/* identify the closest cluster */
         int min_distance = INTEGER_MAX;
         for (i = 0; i < k; i++) {
            int distance = 0;
            int tempdist = 0;
	inp = &c[i][0];
	//distance = finaldist(h,points,inp,tempdist,min_distance);//Arnab, need to change
        //distance = get_sq_dist_8((points+dim*h),inp,0)+get_sq_dist_16((points+dim*h),inp,0)+ get_sq_dist_32((points+dim*h),inp,0)+get_sq_dist_64((points+dim*h),inp,0);//revise
        for (j = m-1; j>=0; j=j-1)
	{
	distance = distance + pow((point_val[h][j] - c[i][j]),2);//*(point_val[h][j] - c[i][j]); //orig
	}
	if (distance < min_distance) {
               labels[h] = i;
               min_distance = distance;//revise
        //printf("Cluster = %d, Min = %d\n",i,distance);
	     }
	}


//***************************************************************       	
	//added for LOW D
	int comp_distance = radius[labels[h]]*ctrl;
	if (min_distance > radius[labels[h]])
	{
	radius[labels[h]] = min_distance;
	}
	else if (min_distance < comp_distance)
	{
	//printf ("%d\n",h);
	trigger = 1;
	tempo =labels[h];
	h++;
	labels[h] = tempo;
	}
	 
	//modified for LD
	/* update size and temp centroid of the destination cluster */
        if(trigger == 1){
	for (j = m-1; j >= 0; j--) 
		{
		c1[labels[h]][j] = c1[labels[h]][j] +  2*point_val[h-1][j];
	        }
		counts[labels[h]] = counts[labels[h]] + 2;
         /* update standard error */
         error = error + 2*min_distance;
        }
          else {
        for (j = m-1; j >= 0; j--) 
        	{
        	c1[labels[h]][j] = c1[labels[h]][j] +  point_val[h][j];
                }
        	counts[labels[h]] = counts[labels[h]] + 1;
         /* update standard error */
         error = error + min_distance;
        }
//***************************************************************************
}
      for (i = 0; i < k; i++) { /* update all centroids */
         for (j = 0; j < m; j++) {
            if(counts[i]>0)
		 c[i][j] = (c1[i][j] / counts[i]);// orig
            else
		 c[i][j] = c1[i][j];
         }
      }

   }
int rn,rd;
double err = 0.0;
for(rn=0;rn<n;rn++)
{
for(rd=m-1;rd>=0;rd--)
{
err+=pow((point_val[rn][rd]-c[labels[rn]][rd]),2);
}
}
// Arnab added
struct timespec gettime_now_2;
clock_gettime(CLOCK_REALTIME, &gettime_now_2);
time_difference_sec = gettime_now_2.tv_sec - start_time_sec; 
time_difference = gettime_now_2.tv_nsec - start_time + 1000000000LL*time_difference_sec;
float time_sec = (float) time_difference/1000000000.0;
//printf("Main = %llu\n",time_difference);
//printf("Main = %f\n",time_sec);


//printing results
double result = (err)/MAX;
//Output
printf("Mean Distance Error => %f \n",result);
printf("PTs => %d \n",countskip);
//clusters
for (i=0;i<k;i++)
{
printf("Cluster %d => %d \n",i,counts[i]);
}

int row = rows;
int col = cols;

//fp = fopen("classimgcreatemem.m", "w+");
/*
fprintf(fp,"rows = %d\n",row);
fprintf(fp,"cols = %d\n",col);
fprintf(fp,"X = [\n");
int rw,cl;
for (rw=0;rw<row;rw++){
for (cl=0;cl<col;cl++){
fprintf(fp,"%d ",labels[rw*col+cl]);
}
fprintf(fp,"\n",labels[rw*col+cl]);
}
fprintf(fp,"];");
*/

return 0;
}

static inline unsigned int get_sq_dist_8(int *v1, int *v2, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
        unsigned int sum = 0;
	for (i = 0; i < 8; i=i+1) //change
	{
                temp1 = v1[i];
                temp1 = ((temp1>>deg)<<deg);
                temp2 = v2[i];
                temp2 = ((temp2>>deg)<<deg);
		actual_ans = ((temp1 - temp2) * (temp1 - temp2));
		//actual_ans = abs(temp1 - temp2);
        sum += actual_ans; 
	}
	return sum;
}


static inline unsigned int get_sq_dist_16(int *v1, int *v2, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
        unsigned int sum = 0;
	for (i = 8; i < 16; i=i+1) //change
	{
                temp1 = v1[i];
                temp1 = ((temp1>>deg)<<deg);
                temp2 = v2[i];
                temp2 = ((temp2>>deg)<<deg);
		actual_ans = ((temp1 - temp2) * (temp1 - temp2));
		//actual_ans = abs(temp1 - temp2);
        sum += actual_ans; 
	}
	return sum;
}

static inline unsigned int get_sq_dist_32(int *v1, int *v2, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
        unsigned int sum = 0;
	for (i = 16; i < 32; i=i+1) //change
	{
                temp1 = v1[i];
                temp1 = ((temp1>>deg)<<deg);
                temp2 = v2[i];
                temp2 = ((temp2>>deg)<<deg);
		actual_ans = ((temp1 - temp2) * (temp1 - temp2));
		//actual_ans = abs(temp1 - temp2);
        sum += actual_ans; 
	}
	return sum;
}

static inline unsigned int get_sq_dist_64(int *v1, int *v2, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
        unsigned int sum = 0;
	for (i = 32; i < 64; i=i+1) //change
	{
                temp1 = v1[i];
                temp1 = ((temp1>>deg)<<deg);
                temp2 = v2[i];
                temp2 = ((temp2>>deg)<<deg);
		actual_ans = ((temp1 - temp2) * (temp1 - temp2));
		//actual_ans = abs(temp1 - temp2);
        sum += actual_ans; 
	}
	return sum;
}

int finaldist(int index, int* points, int* inp, int x, int base1)
{
	int level2, level3, level4;
	if (x<(k1*qual*base1))
	{
		countxk1++;
		level2 = x+get_sq_dist_16((points+dim*index),inp,deg1);
	}
	else if (x<(k2*qual*base1))
	{
		countxk2++;
		level2 = x+get_sq_dist_16((points+dim*index),inp,deg2);
	}
	else if (x<(k3*qual*base1))
	{
		countxk3++;
		level2 = x+get_sq_dist_16((points+dim*index),inp,deg3);
	}
	else if (x<(k4*qual*base1))
	{
		countxk4++;
		level2 = x+get_sq_dist_16((points+dim*index),inp,deg4);
	}
	else if  (x<(qual*base1))
	{
		countx1++;
		level2 = x+get_sq_dist_16((points+dim*index),inp,deg5);
	}
	else
	{
		countxskip++;
		return 2147483647;
	}
	
	if (level2<(k1*qual*base1))
	{
		countlvl2_k1++;
		level3 = level2+get_sq_dist_32((points+dim*index),inp,deg1);
	}
	else if (level2<(k2*qual*base1))
	{
		countlvl2_k2++;
		level3 = level2+get_sq_dist_32((points+dim*index),inp,deg2);
	}
	else if (level2<(k3*qual*base1))
	{
		countlvl2_k3++;
		level3 = level2+get_sq_dist_32((points+dim*index),inp,deg3);
	}
	else if (level2<(k4*qual*base1))
	{
		countlvl2_k4++;
		level3 = level2+get_sq_dist_32((points+dim*index),inp,deg4);
	}
	else if  (level2<(qual*base1))
	{
		countl2++;
		level3 = level2+get_sq_dist_32((points+dim*index),inp,deg5);
	}
	else
	{
		countlvl2skip++;
		return 2147483647;
        }
	
	if (level3<(k1*qual*base1))
	{
		countlvl3_k1++;
		level4 = level3+get_sq_dist_64((points+dim*index),inp,deg1);
		return level4;
	}
	else if (level3<(k2*qual*base1))
	{
		countlvl3_k2++;
		level4 = level3+get_sq_dist_64((points+dim*index),inp,deg2);
		return level4;
	}
	else if (level3<(k3*qual*base1))
	{
		countlvl3_k3++;
		level4 = level3+get_sq_dist_64((points+dim*index),inp,deg3);
		return level4;
	}
	else if (level3<(k4*qual*base1))
	{
		countlvl3_k4++;
		level4 = level3+get_sq_dist_64((points+dim*index),inp,deg4);
		return level4;
	}
	else if  (level3<(qual*base1))
	{
		countl3++;
		level4 = level3+get_sq_dist_64((points+dim*index),inp,deg5);
		return level4;
	}
	else
	{
		countlvl3skip++;
		return 2147483647;
	}
}
