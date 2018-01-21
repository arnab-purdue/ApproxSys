#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>
#include <sys/timeb.h>
///#include <sys/time.h>
//#include "scaledown_points_qbin1.h"
#include "scaledown_points.h"
#include "pointsnew2.h"
//#include "pointsnew.h"
//#include "pointval.h"
//quality knobs
#define dim1 8 
#define dim2 4
#define dim3 2
#define qual 0.375
//#define approxstart 16 //valid only fro 32->64
#define k1 1 //0.125
#define k2 1 //0.25 
#define k3 1 //0.50
#define k4 1 //0.75
#define k5 1//not used 
//#define dim_count 784
#define dim_count 196
#define pts_terminate num_points
#define pointskip 1
#define degcomp 0
//#define RNR
#define skip 1
//float k2= (2*k1);
//float k3= (3*k1);
//float k4= (4*k1);
//float k5= (5*k1); //not used 

void compute_dist(int *,int *,int *);
static inline unsigned int get_sq_dist_98(int *, int *, int);
static inline unsigned int get_sq_dist_196(int *, int *, int);
static inline unsigned int get_sq_dist_392(int *, int *, int);
static inline unsigned int get_sq_dist_784(int *, int *, int);
void find_topk(int *,int *,int *,int *, int *);
int classify (int *, int *);
void knn();
int finaldist(int, int *, int *,int, int);
int compare(int, int);

//quality knobs
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

int deg1 = 0;//0; //0
int deg2 = 0;//1; //0
int deg3 = 0;//2; //1
int deg4 = 0;//3; //2
int deg5 = 0;//4; //3
int degree = 0;

void main()
{
knn();
}

int flaglast = 0;
#ifdef RNR
FILE *ofp;
#endif

void knn()
{
    int *points,*class_p,*inp,*dist_ar,*dist_ar1,*topk;
    int class_inp,i,j;
    int correct =0;
    float err_perc;
    err_perc =0.0;	
    points = &point_val[0][0];
    class_p = &class_val[0];
    dist_ar = (int *) malloc(sizeof(int)*(num_points+1));
    dist_ar1 = (int *) malloc(sizeof(int)*(num_points+1));
    topk = (int *) malloc(sizeof(int)*k);
    #ifdef RNR
    ofp = fopen("approx.h","w");
    fprintf(ofp,"#ifndef APPROX_H_\n");
    fprintf(ofp,"#define APPROX_H_\n");
    fprintf(ofp,"int approx_ranks[1797][3823] = {");
    #endif
    for(i=0;i<k;i++)
    {
      topk[i] = num_points;
    }
    dist_ar[num_points] = 2147483647;
//Arnab added for calculating time
long long int start_time,time_difference;
long long int start_time_sec, time_difference_sec;
struct timespec gettime_now;
clock_gettime(CLOCK_REALTIME, &gettime_now);
start_time_sec = gettime_now.tv_sec;
start_time = gettime_now.tv_nsec;
    
    for(i=0;i<no_inputs;i++)
    {
	if (i == (no_inputs-1))
	{
	flaglast = 1;
	}
	#ifdef PTS
	printf("Point = %d\n",i);
	#endif
	    for(j=0;j<k;j++)
	    {
	    	topk[j] = num_points;
	    }
        	inp = &input[i][0];        
        	compute_dist(points,inp,dist_ar1);
        	find_topk(points,inp,dist_ar,dist_ar1,topk);
        	class_inp = classify(topk,class_p);
        	if(class_inp == class_test[i]){correct ++;}
    }
// Arnab added
struct timespec gettime_now_2;
clock_gettime(CLOCK_REALTIME, &gettime_now_2);
time_difference_sec = gettime_now_2.tv_sec - start_time_sec; 
time_difference = gettime_now_2.tv_nsec - start_time + 1000000000LL*time_difference_sec;
float time_sec = (float) time_difference/1000000000.0;
printf("Main = %llu\n",time_difference);
printf("Main = %f\n",time_sec);
		#ifdef RNR
		fprintf(ofp,"};\n");
		fprintf(ofp,"#endif /*APPROX_H_*/");
		fclose(ofp);
		#endif
    #ifdef APQ
    printf("Classification accuracy: %f \n",((float)correct/ (float)no_inputs));
    #endif
    err_perc = 100*(float)(no_inputs-correct)/(float)(no_inputs);
    float hitsxk1 = (float)countxk1/(float)(no_inputs*k);	
    float hitsxk2 = (float)countxk2/(float)(no_inputs*k);	
    float hitsxk3 = (float)countxk3/(float)(no_inputs*k);	
    float hitsxk4 = (float)countxk4/(float)(no_inputs*k);	
    float hitsx1 = (float)countx1/(float)(no_inputs*k);	
    float hitsxskip = (float)countxskip/(float)(no_inputs*k);	
    
    float hitslvl2_k1 = (float)countlvl2_k1/(float)(no_inputs*k);	
    float hitslvl2_k2 = (float)countlvl2_k2/(float)(no_inputs*k);	
    float hitslvl2_k3 = (float)countlvl2_k3/(float)(no_inputs*k);	
    float hitslvl2_k4 = (float)countlvl2_k4/(float)(no_inputs*k);	
    float hitsl2 = (float)countl2/(float)(no_inputs*k);	
    float hitslvl2skip = (float)countlvl2skip/(float)(no_inputs*k);	
    
    float hitslvl3_k1 = (float)countlvl3_k1/(float)(no_inputs*k);	
    float hitslvl3_k2 = (float)countlvl3_k2/(float)(no_inputs*k);	
    float hitslvl3_k3 = (float)countlvl3_k3/(float)(no_inputs*k);	
    float hitslvl3_k4 = (float)countlvl3_k4/(float)(no_inputs*k);	
    float hitsl3 = (float)countl3/(float)(no_inputs*k);	
    float hitslvl3skip = (float)countlvl3skip/(float)(no_inputs*k);	
    
    #ifdef APQ
    printf("Perc. Degradation = %.3f\n",err_perc);
    #endif
    #ifdef EPS
    printf("dim98-k1 = %d\n",(int)round(hitsxk1));
    printf("dim98-k2 = %d\n",(int)round(hitsxk2));
    printf("dim98-k3 = %d\n",(int)round(hitsxk3));
    printf("dim98-k4 = %d\n",(int)round(hitsxk4));
    printf("dim98-1 = %d\n",(int)round(hitsx1));
    printf("dim98-skip = %d\n",(int)round(hitsxskip));
    
    printf("dim196-k1 = %d\n",(int)round(hitslvl2_k1));
    printf("dim196-k2 = %d\n",(int)round(hitslvl2_k2));
    printf("dim196-k3 = %d\n",(int)round(hitslvl2_k3));
    printf("dim196-k4 = %d\n",(int)round(hitslvl2_k4));
    printf("dim196-1 = %d\n",(int)round(hitsl2));
    printf("dim196-skip = %d\n",(int)round(hitslvl2skip));
    
    printf("dim392-k1 = %d\n",(int)round(hitslvl3_k1));
    printf("dim392-k2 = %d\n",(int)round(hitslvl3_k2));
    printf("dim392-k3 = %d\n",(int)round(hitslvl3_k3));
    printf("dim392-k4 = %d\n",(int)round(hitslvl3_k4));
    printf("dim392-1 = %d\n",(int)round(hitsl3));
    printf("dim392-skip = %d\n",(int)round(hitslvl3skip));
    #endif
}

//void compute_dist( int *points, int*inp, int *dist_ap1,int *dist_ap2,int *dist_ap3, int* dist_ar1, int* dist_ar2, int* dist_ar3, int* dist_ar4, int pts_terminate, int pointskip, int dimcount, int dimskip, int deg)
void compute_dist(int *points, int* inp, int* dist_ar1)
{
	int i;
	for(i=0;i<pts_terminate;i=i+skip) //change -- not suitable
	{
	    dist_ar1[i] = get_sq_dist_98((points+dim*i),inp,degree);
 	}
}


static inline unsigned int get_sq_dist_98(int *v1, int *v2, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
        unsigned int sum = 0;
	for (i = 0; i < 98; i=i+skip) //change
	{
                temp1 = v1[i];
                //temp1 = ((temp1>>deg)<<deg);
                temp2 = v2[i];
                //temp2 = ((temp2>>deg)<<deg);
		//actual_ans = ((temp1 - temp2) * (temp1 - temp2));
		actual_ans = pow((temp1 - temp2),2);
		//actual_ans = abs(temp1 - temp2);
        sum += actual_ans; 
	}
	return sum;
}


static inline unsigned int get_sq_dist_196(int *v1, int *v2, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
        unsigned int sum = 0;
	for (i = 98; i < 196; i=i+skip) //change
	{
                temp1 = v1[i];
                //temp1 = ((temp1>>deg)<<deg);
                temp2 = v2[i];
                //temp2 = ((temp2>>deg)<<deg);
		//actual_ans = ((temp1 - temp2) * (temp1 - temp2));
		actual_ans = pow((temp1 - temp2),2);
		//actual_ans = abs(temp1 - temp2);
        sum += actual_ans; 
	}
	return sum;
}

static inline unsigned int get_sq_dist_392(int *v1, int *v2, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
        unsigned int sum = 0;
	for (i = 196; i < 392; i=i+skip) //change
	{
                temp1 = v1[i];
               // temp1 = ((temp1>>deg)<<deg);
                temp2 = v2[i];
               // temp2 = ((temp2>>deg)<<deg);
		//actual_ans = ((temp1 - temp2) * (temp1 - temp2));
		actual_ans = pow((temp1 - temp2),2);
		//actual_ans = abs(temp1 - temp2);
        sum += actual_ans; 
	}
	return sum;
}

static inline unsigned int get_sq_dist_784(int *v1, int *v2, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
        unsigned int sum = 0;
	for (i = 392; i < 784; i=i+skip) //change
	{
                temp1 = v1[i];
                //temp1 = ((temp1>>deg)<<deg);
                temp2 = v2[i];
                //temp2 = ((temp2>>deg)<<deg);
		//actual_ans = ((temp1 - temp2) * (temp1 - temp2));
		actual_ans = pow((temp1 - temp2),2);
		//actual_ans = abs(temp1 - temp2);
        sum += actual_ans; 
	}
	return sum;
}

int finaldist(int index, int* points, int* inp, int x, int base1)
{
	int level2, level3, level4;
	if (x>=(qual*base1))
	{
		countxskip++;
		return 2147483647;
	}
	else
	{
		level2 = x+get_sq_dist_196((points+dim*index),inp,0);
		return level2;
        //return (x+get_sq_dist_196((points+dim*index),inp,0) + get_sq_dist_392((points+dim*index),inp,0)+ get_sq_dist_784((points+dim*index),inp,0));
	}
/*	if (level2>=(qual*base1))
	{
		countlvl2skip++;
		return 2147483647;
	}
	else 
	{
		countl2++;
		level3 = level2+get_sq_dist_392((points+dim*index),inp,0);
	}
	if (level3>=qual*base1){
		countlvl3skip++;
		return 2147483647;
	}	
	else 
	{
		countl3++;
		level4 = level3+get_sq_dist_784((points+dim*index),inp,0);
		return level4;
	}*/
}

int compare(int ref ,int base)
{
	//if (ref<(qual*base))
	if (ref<(base))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

void find_topk(int* points, int* inp, int *dist_ar, int *dist_ar1,int *topk)
{
	int kcnt;
	int index,j,temp,temp1,set;
	int temp_dist;
	int flag;
	for(index=0;index<pts_terminate;index=index+1) //change--check once again
	{
	   set = 0;
	   for(j=0;j<k;j++)
	   {
		temp_dist = finaldist(index,points,inp,dist_ar1[index],dist_ar[topk[j]]);
		dist_ar[index] = temp_dist;
		flag = compare(temp_dist,dist_ar[topk[j]]);
		/*	if (flag == 1)
			{
			dist_ar[index] = get_sq_dist_98((points+dim*index),inp,0)+get_sq_dist_196((points+dim*index),inp,0)+ get_sq_dist_392((points+dim*index),inp,0)+get_sq_dist_784((points+dim*index),inp,0);//revise
			}
			else
			{
			dist_ar[index] = temp_dist;
			}
			if(set ==0 && dist_ar[i] < dist_ar[topk[j]])*/
			if((set ==0) && flag)
			{
				temp = topk[j];
				topk[j] = index;
				set = 1;
				//printf("index = %d\n",index); // revise
			}
			else if(set ==1)
		        {
					temp1 = topk[j];
					topk[j] = temp;
					temp = temp1;
			}
	   }
	}
	#ifdef RNR
	fprintf(ofp,"{");
	for(kcnt=0;kcnt<(k-1);kcnt++)
	{
	fprintf(ofp,"%d,",topk[kcnt]);
	}
	if (flaglast == 0){
	fprintf(ofp,"%d},\n",topk[k]);}
	else{
	fprintf(ofp,"%d}\n",topk[k]);}	
	#endif
}

int classify (int *topk, int *class_p)
{
        int i,c_inp;
	int max = -1;
	int A[num_classes] ={0};
	for(i=0;i<k;i++)
	{
		A[class_p[topk[i]]]++;	
	}
	for(i=0;i<num_classes;i++)
	{	
	   if(A[i]>max)
	   {
		   c_inp = i;
		   max =A[i];
	   }
	}
	return c_inp;
}

