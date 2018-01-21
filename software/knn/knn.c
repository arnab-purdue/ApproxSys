#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
//#include <sys/time.h>
#include <time.h>
#include <sys/timeb.h>
//#include "pointsnew2.h"
//#include "pointval.h"
#include "pointval4x.h"
#include "pointsnew.h"
//#include "input98.h"
#include "input4x_99.h"
//#include "input.h"

void compute_dist( int *, int*, int*, int, int, int );
static inline unsigned int get_sq_dist(int *, int *, int, int);
void find_topk(int *,int *, int);
int classify (int *, int *);

int main()
{
    int ar,sr,pr,rr,loopspts, loopsdim, deg, loopsnear;
    loopspts = 1;//sr
    loopsdim = 1;//sr
    loopsnear = 1; //pr
    deg = 0;    //rr
    int *points,*class_p,*inp,*dist_ar,*topk;
    int class_inp,i,j;
    float q;
    int correct;
    float accuracy;
	
    points = &point_val[0][0];
    class_p = &class_val[0];
    dist_ar = (int *) malloc(sizeof(int)*(num_points+1));
    topk = (int *) malloc(sizeof(int)*k);

    for(i=0;i<k;i++)
    {
      topk[i] = num_points;
    }
    dist_ar[num_points] = 2147483647;

    
    for(i=0;i<no_inputs;i++)
    { 
	    for(j=0;j<k;j++)
	    {
	    	topk[j] = num_points;
	    }
        inp = &input[i][0];        
        compute_dist(points,inp,dist_ar,loopspts,loopsdim,deg);
        find_topk(dist_ar,topk, loopsnear);
        class_inp = classify(topk,class_p);
        if(class_inp == class_test[i]){correct ++;}
    }

// Arnab added
int test_n = no_inputs;
    printf("Classification accuracy %f \n",(float)correct/(float)test_n);
    return 0;
}

void compute_dist( int *points, int*inp, int* dist_ar, int loopspts, int loopsdim, int deg)
{
	int i;
	for(i=0;i<num_points;i=i+loopspts)
	{
	    dist_ar[i] = get_sq_dist((points+dim*i),inp,loopsdim,deg);
       // printf(" %d\n" ,dist_ar[i]);
 	}
}

static inline unsigned int get_sq_dist(int *v1, int *v2, int loopsdim, int deg)
{
	int i;
        int temp1, temp2, actual_ans;
	unsigned int sum = 0;
	for (i = 0; i < dim; i=i+loopsdim)
	{
		//actual_ans = ((v1[i] - v2[i]) * (v1[i] - v2[i]));
		actual_ans = pow((v1[i] - v2[i]),2);
        sum += actual_ans; 
	}
	return sum;
}

void find_topk(int *dist_ar,int *topk, int loopsnear)
{
	int i,j,temp,temp1,set;
	for(i=0;i<num_points;i=i+loopsnear)
	{
	   set = 0;
	   for(j=0;j<k;j++)
	   {
			if(set ==0 && dist_ar[i] < dist_ar[topk[j]])
			{
				temp = topk[j];
				topk[j] = i;
				set = 1;
			}
			else if(set ==1)
		    {
					temp1 = topk[j];
					topk[j] = temp;
					temp = temp1;
			}
	   }
	}
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

