#include <stdio.h>
#include <stdlib.h>
//#include "params.h"
//#include "params_20_identity.h"
#include "params_tanh_q.h"
#include "test_images_2.h"
#include "test_labels.h"
#include <sys/time.h>
#include <omp.h>
#include<math.h>
//Arnab changed this value
#define SIZE 10000

// Swagath Mod for quantizing outputs of neurons //
float op_max = -10000;
float op_min = 10000;

// Swagath Mod for Approximation //
typedef enum  {REL,RATE,SIG,NIL,EXP_RATE} ER_TYPE;
ER_TYPE er_type = NIL;
float er_amt[2] = {50,20};
// END //

typedef struct {
    // Layer Parameters
    int neu_c;
    int win_s;
    int fea_c;
    int fea_s;
} nnl;

int neu_mac_acc(int* , int* , int,               int );
int neu_mac    (int* , int* , int,               int );
int neu_mac_ws (int* , int* , int , int,         int );
int neu_mac_w  (int* , int* , int , int* , nnl*, int );
int tanh (int);
int tanh1 (int);
// ******** I0 ******** //
int outI0[1024];

nnl I0 = {1024, 0, 1, 32};

// ******** C1 ******** //
int outC1[4704];
int* i_n_addC1[4704];
int* w_n_addC1[4704];
int* b_n_addC1[4704];
int* o_n_addC1[4704];
int* c_n_addC1[4704];
int ctC1[6][1] = {1,1,1,1,1,1};
int idC1[4704];

nnl C1 = {4704, 5, 6, 28};

// ******** S2 ******** //
int outS2[1176];
int* i_n_addS2[1176];
int* w_n_addS2[1176];
int* b_n_addS2[1176];
int* o_n_addS2[1176];

nnl S2 = {1176, 2, 6, 14};

// ******** C3 ******** //
int outC3[1600];
int* i_n_addC3[1600];
int* w_n_addC3[1600];
int* b_n_addC3[1600];
int* o_n_addC3[1600];
int* c_n_addC3[1600];
int ctC3[16][6] = { {1,1,1,0,0,0},
                    {0,1,1,1,0,0},
                    {0,0,1,1,1,0},
                    {0,0,0,1,1,1},
                    {1,0,0,0,1,1},
                    {1,1,0,0,0,1},
                    {1,1,1,1,0,0},
                    {0,1,1,1,1,0},
                    {0,0,1,1,1,1},
                    {1,0,0,1,1,1},
                    {1,1,0,0,1,1},
                    {1,1,1,0,0,1},
                    {1,1,0,1,1,0},
                    {0,1,1,0,1,1},
                    {1,0,1,1,0,1},
                    {1,1,1,1,1,1}
                  };
int idC3[1600];
nnl C3 = {1600, 5, 16, 10};

// ******** S4 ******** //
int outS4[400];
int* i_n_addS4[400];
int* w_n_addS4[400];
int* b_n_addS4[400];
int* o_n_addS4[400];

nnl S4 = {400, 2, 16, 5};

// ******* C5 ******** //
int outC5[120];
int* i_n_addC5[120];
int* w_n_addC5[120];
int* b_n_addC5[120];
int* o_n_addC5[120]; 

nnl C5 = {120, 0, 1, 1};

// ******* F6 ******** //
int out[10];
int* i_n_addF6[10];
int* w_n_addF6[10];
int* b_n_addF6[10];
int* o_n_addF6[10]; 

nnl F6 = {10, 0, 1, 1};

// ******** Result ******* //
float accuracy;
int no_c;
int num_correct;

int main ()
{
    
    // Lenet 5 Architecture
    int n;
    
    // Precomputation of I/W/B/O addresses
    int i,j,k; 
    int nc,index,indexp;
    int* w_ptr;
    int* b_ptr;
    int* i_ptr;
    int* o_ptr;
    int* c_ptr; 
    // C1
    nc = 0;
    w_ptr = wbC1; 
    b_ptr = &wbC1[150];
    c_ptr = &ctC1[0][0];
    for (i=0; i < C1.fea_c; i++)
    {
        for(j=0; j < C1.fea_s;j+=2)
        {
            for(k=0; k < C1.fea_s; k+=2)
            {
                index = i * C1.fea_s * C1.fea_s + j * C1.fea_s + k;
                indexp = j * I0.fea_s + k;
                i_ptr = outI0 + indexp;
                o_ptr = outC1 + index;
                i_n_addC1[nc] = i_ptr;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index;
                nc++;
                i_n_addC1[nc] = i_ptr+1;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+1;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+1;
                nc++;
                i_n_addC1[nc] = i_ptr+I0.fea_s;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+C1.fea_s;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+C1.fea_s;
                nc++;
                i_n_addC1[nc] = i_ptr+I0.fea_s+1;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+C1.fea_s+1;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+C1.fea_s+1;
                nc++;
            }
        }
        w_ptr += C1.win_s * C1.win_s;
        b_ptr ++;
        c_ptr+= I0.fea_c;
    }
    // S2
    nc = 0;
    w_ptr = wbS2; 
    b_ptr = &wbS2[6];
    for (i=0; i < S2.fea_c; i++)
    {
        for(j=0; j < S2.fea_s;j++)
        {
            for(k=0; k < S2.fea_s; k++)
            {
                index = i * C1.fea_s * C1.fea_s + j*2*C1.fea_s + k*2;
                i_ptr = outC1 + index;
                o_ptr = outS2 + nc;
                i_n_addS2[nc] = i_ptr;
                w_n_addS2[nc] = w_ptr;
                b_n_addS2[nc] = b_ptr;
                o_n_addS2[nc] = o_ptr;
                nc++;
            }
        }
        w_ptr ++;
        b_ptr ++;
    }
    // C3
    nc = 0;
    w_ptr = wbC3; 
    b_ptr = &wbC3[2400];
    for (i=0; i < C3.fea_c; i++)
    {
        c_ptr = &ctC3[i][0];
        for(j=0; j < C3.fea_s;j+=2)
        {
            for(k=0; k < C3.fea_s; k+=2)
            {
                index = i * C3.fea_s * C3.fea_s + j * C3.fea_s + k;
                indexp = j * S2.fea_s + k;
                i_ptr = outS2 + indexp;
                o_ptr = outC3 + index;
                i_n_addC3[nc] = i_ptr;
                w_n_addC3[nc] = w_ptr;
                b_n_addC3[nc] = b_ptr;
                o_n_addC3[nc] = o_ptr;
                c_n_addC3[nc] = c_ptr;
                idC3[nc] = index;
                nc++;
                i_n_addC3[nc] = i_ptr+1;
                w_n_addC3[nc] = w_ptr;
                b_n_addC3[nc] = b_ptr;
                o_n_addC3[nc] = o_ptr+1;
                c_n_addC3[nc] = c_ptr;
                idC3[nc] = index+1;
                nc++;
                i_n_addC3[nc] = i_ptr+S2.fea_s;
                w_n_addC3[nc] = w_ptr;
                b_n_addC3[nc] = b_ptr;
                o_n_addC3[nc] = o_ptr+C3.fea_s;
                c_n_addC3[nc] = c_ptr;
                idC3[nc] = index+C3.fea_s;
                nc++;
                i_n_addC3[nc] = i_ptr+S2.fea_s+1;
                w_n_addC3[nc] = w_ptr;
                b_n_addC3[nc] = b_ptr;
                o_n_addC3[nc] = o_ptr+C3.fea_s+1;
                c_n_addC3[nc] = c_ptr;
                idC3[nc] = index+C3.fea_s+1;
                nc++;
            }
        }
        for(j=0;j<S2.fea_c;j++)
        {
            if(ctC3[i][j]==1)
            {
                w_ptr += C3.win_s * C3.win_s;
            }
        }
        b_ptr ++;
    }
    // S4
    nc = 0;
    w_ptr = wbS4; 
    b_ptr = &wbS4[16];
    for (i=0; i < S4.fea_c; i++)
    {
        for(j=0; j < S4.fea_s;j++)
        {
            for(k=0; k < S4.fea_s; k++)
            {
                index = i*C3.fea_s * C3.fea_s + j*2*C3.fea_s + k*2;
                i_ptr = outC3 + index;
                o_ptr = outS4 + nc;
                i_n_addS4[nc] = i_ptr;
                w_n_addS4[nc] = w_ptr;
                b_n_addS4[nc] = b_ptr;
                o_n_addS4[nc] = o_ptr;
                nc++;
            }
        }
        w_ptr ++;
        b_ptr ++;
    }

    // C5
    nc = 0;
    w_ptr = wbC5; 
    b_ptr = &wbC5[48000];
    i_ptr = outS4;
    o_ptr = outC5;
    for (i=0; i < C5.neu_c; i++)
    {
        i_n_addC5[nc] = i_ptr;
        w_n_addC5[nc] = w_ptr + nc * S4.neu_c;
        b_n_addC5[nc] = b_ptr + nc;
        o_n_addC5[nc] = o_ptr + nc;
        nc++;
    }
    
    // F6
    nc = 0;
    w_ptr = wbF6; 
    b_ptr = &wbF6[1200];
    i_ptr = outC5;
    o_ptr = out;
    for (i=0; i < F6.neu_c; i++)
    {
        i_n_addF6[nc] = i_ptr;
        w_n_addF6[nc] = w_ptr + nc * C5.neu_c;
        b_n_addF6[nc] = b_ptr + nc;
        o_n_addF6[nc] = o_ptr + nc;
        nc++;
    }
    // *************** Actual forward propagation ***************** //
    int size = SIZE;
    num_correct = 0;
    int ipc;
    timeval st_time,end_time;
    gettimeofday(&st_time,NULL);
    for (ipc=0;ipc<size;ipc++)
    {
        for(n=0; n < I0.neu_c; n++)
        {
            outI0[n] = test_images[ipc][n];
        }
        // C1
        //printf("Next layer\n");
        //neu_c shows the total number of pixels
        #pragma omp parallel for
        for(n=0; n < C1.neu_c ; n++)
        {
            //printf(" %d \n",n);
            *(o_n_addC1[n]) = neu_mac_w(i_n_addC1[n],w_n_addC1[n],C1.win_s,c_n_addC1[n], &I0,*(b_n_addC1[n])); 
            //*(o_n_addC1[n]) += *(b_n_addC1[n]);
            //printf(" %d : %f\n",idC1[n],*(o_n_addC1[n]));
           // printf("%08x, %d\n",*(o_n_addC1[n]),*(b_n_addC1[n]));
        }
        // S2
        //printf("S2 layer\n");
        for(n=0; n < S2.neu_c ; n++)
        {
        //    printf(" %d \n",n);
            *(o_n_addS2[n]) = neu_mac_ws(i_n_addS2[n],w_n_addS2[n],S2.win_s,C1.fea_s,*(b_n_addS2[n])); 
            //*(o_n_addS2[n]) += *(b_n_addS2[n]);
            //printf("%08x\n",*(o_n_addS2[n]));
            //printf("%d,",*(o_n_addS2[n]));
        }
        //printf("\n");
        // C3
    //    printf("C3 layer\n");
        #pragma omp parallel for
        for(n=0; n < C3.neu_c ; n++)
        {
    //        printf(" %d \n",n);
            *(o_n_addC3[n]) = neu_mac_w(i_n_addC3[n],w_n_addC3[n],C3.win_s,c_n_addC3[n], &S2,*(b_n_addC3[n])); 
            //*(o_n_addC3[n]) += *(b_n_addC3[n]);
            //printf(" %d : %f\n",idC3[n],*(o_n_addC3[n]));
//            printf("%08x\n",*(o_n_addC3[n]));
        }
        // S4
        //printf("S4 layer\n");
        for(n=0; n < S4.neu_c ; n++)
        {
  //          printf(" %d \n",n);
            *(o_n_addS4[n]) = neu_mac_ws(i_n_addS4[n],w_n_addS4[n],S4.win_s,C3.fea_s,*(b_n_addS4[n])); 
            //*(o_n_addS4[n]) += *(b_n_addS4[n]);
           // printf(" %d : %f\n",n,*(o_n_addS4[n]));
        //    printf("%d,",*(o_n_addS4[n]));
        }
        // C5
       // printf("C5 layer\n");
        #pragma omp parallel for
        for(n=0; n < C5.neu_c ; n++)
        {
            //printf(" %d \n",n);
            *(o_n_addC5[n]) = neu_mac(i_n_addC5[n],w_n_addC5[n],S4.neu_c,*(b_n_addC5[n]));
            //*(o_n_addC5[n]) += *(b_n_addC5[n]);
         //   printf(" %d : %d\n",n,*(o_n_addC5[n]));
        }
        // F6
       // printf("F6 layer\n");
        for(n=0; n < F6.neu_c ; n++)
        {
            //printf(" %d \n",n);
            *(o_n_addF6[n]) = neu_mac_acc(i_n_addF6[n],w_n_addF6[n],C5.neu_c,*(b_n_addF6[n]));
            //*(o_n_addF6[n]) += *(b_n_addF6[n]);
     //       printf(" %d : %d\n",n,*(o_n_addF6[n]));
        }
        // Find Max value to get label and update result
       //printf("OUTPUT %d\n",ipc);
        int max_val = -10000;
        int prediction = -1; 
        for(n=0;n <  F6.neu_c ; n++)
        {
            if (out[n] > max_val) 
            {
                max_val = out[n];
                prediction = n;
            }
            //printf("%f\n",out[n]);

        }
        if( prediction == test_labels[ipc])
        {
            num_correct++;
        }
    }
    gettimeofday(&end_time,NULL);
    printf("Time: %f\n",end_time.tv_sec-st_time.tv_sec+((double)(end_time.tv_usec-st_time.tv_usec))/1000000);// Update
    accuracy = (float)num_correct/size;
    printf("Correct: %d out of %d\n",num_correct,size);// Update
    printf ("OP_max = %f ,       OP_min = %f\n",op_max,op_min);
}

//assuming this is the accurate version of mac for the cnn
int neu_mac_acc (int* ip_st, int* w_st, int size, int bias)
{
    int i;
    int* ip = ip_st;
    int* w = w_st;
    int op = 0;
    for (i=0;i < size; i++)
    {
        op += *ip * *w;
     //   printf ("%d,%d :: %d\n",*ip,*w,op);
        ip++;
        w++;
    }
    //printf("%08x\n",op);
    op += bias*127;
    //printf("Bias : %08x\n",op);
   // op_max = (op > op_max) ? op : op_max;
   // op_min = (op < op_min) ? op : op_min;
    //op = tanh((int)op/16384.0);
    op = tanh(op);
    //printf("%08x\n",op);
    return (op);
}

int neu_mac (int* ip_st, int* w_st, int size, int bias)
{
    int i;
    int* ip = ip_st;
    int* w = w_st;
    int op = 0;
    for (i=0;i < size; i++)
    {
        int  actual_ans = *ip * *w;
        int sign_ans = (actual_ans >= 0) ? 1 : -1;
        int  approx_ans = actual_ans;
        int  er_range;
        int abs_actual_ans;
        switch(er_type)
        {
            case REL:
                abs_actual_ans = (actual_ans >= 0) ? actual_ans : (-1*actual_ans);
                er_range = 2*er_amt[1]*abs_actual_ans/100;
                if(er_range != 0)
                {
                    int error = (rand () % er_range) - er_range/2;
                    approx_ans = sign_ans*(abs_actual_ans + error);
                    //printf("Here: Act:%d  Approx:%d\n",actual_ans,approx_ans);
                }
                else
                {
                    approx_ans = actual_ans;
                    //printf("NO Approx: Act:%d  Approx:%d\n",actual_ans,approx_ans);
                }
                break;
            case RATE:
                if(rand()%1000 < er_amt[1]*10)
                {
                    approx_ans = sign_ans * rand()%16384;
                    //printf("Here: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                }
                else
                {
                    approx_ans = actual_ans;
                    //printf("NO Approx: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                }
                break;
            case EXP_RATE: approx_ans = actual_ans;
            case NIL: approx_ans = actual_ans;
            default: approx_ans = actual_ans;
        }
        op += approx_ans;
        ip++;
        w++;
    }
    //printf("%08x\n",op);
    op += bias*127;
    //printf("%08x\n",op);
   // op_max = (op > op_max) ? op : op_max;
   // op_min = (op < op_min) ? op : op_min;
    //op = tanh((int)op/16384.0);
    op = tanh(op);
    //printf("%08x\n",op);
    return (op);
}

int neu_mac_ws (int* ip_st, int* w_st, int win_size, int ip_fea_dim, int bias)
{
    int i,j;
    int* ip = ip_st;
    int op = 0;
    int ip_incr = ip_fea_dim - win_size;
    for (i=0;i < win_size; i++)
    {
        for(j=0;j<win_size;j++)
        {
            int  actual_ans = *ip * *w_st;
            int sign_ans = (actual_ans >= 0) ? 1 : -1;
            int  approx_ans = actual_ans;
            int  er_range;
            //switch(er_type)
            //{
            //    case REL:
            //        er_range = 2*er_amt[0]*actual_ans/100;
            //        if(er_range != 0)
            //        {
            //            int error = (rand () % er_range) - er_range/2;
            //            approx_ans = actual_ans + error;
            //            //printf("Here: Act:%d  Approx:%d\n",actual_ans,approx_ans);
            //        }
            //        else
            //        {
            //            approx_ans = actual_ans;
            //            //printf("NO Approx: Act:%d  Approx:%d\n",actual_ans,approx_ans);
            //        }
            //        break;
            //    case RATE:
            //        if(rand()%1000 < er_amt[0]*10)
            //        {
            //            approx_ans = sign_ans * rand()%16384;
            //            //printf("Here: Act:%f  Approx:%f\n",actual_ans,approx_ans);
            //        }
            //        else
            //        {
            //            approx_ans = actual_ans;
            //            //printf("NO Approx: Act:%f  Approx:%f\n",actual_ans,approx_ans);
            //        }
            //        break;
            //    case EXP_RATE: approx_ans = actual_ans;
            //    case NIL: approx_ans = actual_ans;
            //    default: approx_ans = actual_ans;
            //}
            op += approx_ans;
            ip++;
        }
        ip += ip_incr; 
    }
    op = op/(win_size*win_size);
    //printf("Before Bias :%08x\n",op);
    op += bias*127;
    //printf("Before Bias :%08x\n",op);
    //printf(" Bias: %08x\n",op);
   // op_max = (op > op_max) ? op : op_max;
  //  op_min = (op < op_min) ? op : op_min;
  //  op = tanh((int)op/16384.0);
    op = tanh(op);
    //printf("%08x\n",op);
    return (op);
}

int neu_mac_w (int* ip_st, int* w_st, int win_size, int* ct_st, nnl* ip_lay, int bias)
{
    int h,i,j;
    int* ip; 
    int* w = w_st;
    int op = 0;
    int ip_incr = ip_lay->fea_s - win_size;
    //                printf("***************\n");
    for (h=0; h < ip_lay->fea_c ; h++)
    {
        ip = ip_st + h * ip_lay->fea_s * ip_lay->fea_s;
        if(*(ct_st+h)==1)
        {
            for (i=0;i < win_size; i++)
            {
                for(j=0;j<win_size;j++)
                {
     //               printf("Here:weights :%d\n",*w);
                    int  actual_ans = *ip * *w;
                    int  sign_ans = (actual_ans >= 0) ? 1 : -1;
                    int  approx_ans = actual_ans;
                    int  er_range;
                    int  abs_actual_ans;
                    switch(er_type)
                    {
                        case REL:
                            abs_actual_ans = (actual_ans >= 0) ? actual_ans : (-1*actual_ans);
                            er_range = 2*er_amt[0]*abs_actual_ans/100;
                            if(er_range != 0)
                            {
                                int error = (rand () % er_range) - er_range/2;
                                approx_ans = sign_ans*(abs_actual_ans + error);
                                //printf("Here: Act:%d  Approx:%d\n",actual_ans,approx_ans);
                            }
                            else
                            {
                                approx_ans = actual_ans;
                                //printf("NO Approx: Act:%d  Approx:%d\n",actual_ans,approx_ans);
                            }
                            break;
                        case RATE:
                            if(rand()%1000 < er_amt[0]*10)
                            {
                                approx_ans = sign_ans * rand()%16384;
                                //printf("Here: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                            }
                            else
                            {
                                approx_ans = actual_ans;
                                //printf("NO Approx: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                            }
                            break;
                        case EXP_RATE: approx_ans = actual_ans;
                        case NIL: approx_ans = actual_ans;
                        default: approx_ans = actual_ans;
                    }
                    op += approx_ans;
                    ip++;
                    w++;
                }
                ip += ip_incr; 
            }
        }
    //printf("%08x\n",op);
    }
    //printf("MAC : %08x\n",op);
    op += bias*127;
    //printf("MAC+B : %08x = %08x\n",bias*127,op);
    op = tanh(op);
    //  op = tanh((int)op/16384.0);
    return (op);
}

int tanh1 (int x)
{
    if(x >= 16129)
    {
        return(127.0);
    }
    else if (x <= -16129)
    {
        return(-127.0);
    }
    else
    {
        long int ox = 260144641 - (x*x >> 1); // 16129 ^ 2
        return ((x*ox) >> 35); 
    }
    //float ex = exp(x); 
    //float emx = exp(-x);
    //return ((ex-emx)/(ex+emx));
    //return(x-pow(x,3)/3+2*pow(x,5)/15);
}

int tanh (int x)
{
    if(x >= 16129)
    {
        return(127.0);
    }
    else if (x <= -16129)
    {
        return(-127.0);
    }
    else
    {
        int xabs = (x < 0) ? (-1 * x) : x; 
        int x2 = xabs * xabs ;
        int x2rs1 = x2 >> 1; 
        long int ox = 260144641 - x2rs1; // 16129 ^ 2
        long int xox = xabs * ox;
        long int xoxrs = xox >> 35;
        long int tanhx = (x<0) ? (-1 * xoxrs) : xoxrs; 
        //printf("x : %d\n",x);
        //printf("xabs: %d\n",xabs);
        //printf("x2 : %d\n",x2);
        //printf("x2rs1: %d\n",x2rs1);
        //printf("ox : %d\n",ox);
        //printf("xox : %d\n",xox);
        //printf("xoxrs : %d\n",xoxrs);
        //printf("tanh : %d\n",tanhx);
        return (tanhx); 
    //    long int ox = 260144641 - (x*x >> 1); // 16129 ^ 2
    //    return ((x*ox) >> 35); 
    }
    //float ex = exp(x); 
    //float emx = exp(-x);
    //return ((ex-emx)/(ex+emx));
    //return(x-pow(x,3)/3+2*pow(x,5)/15);
}


/*
                i_n_addC1[nc] = i_ptr+2;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+2;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+2;
                nc++;
                i_n_addC1[nc] = i_ptr+3;
                w_n_addC1[nc] = w_ptr;
                b_n_addC1[nc] = b_ptr;
                o_n_addC1[nc] = o_ptr+3;
                c_n_addC1[nc] = c_ptr;
                idC1[nc] = index+3;
                nc++;
*/
/*
                            if((al_sig > 1000) && (rand()%1000 < er_amt[0]*10))
                            {
                                approx_ans = rand()%65535;
                                //printf("Here0: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                            }
                            else if((al_sig > 100)  && (al_sig <= 1000) && (rand()%1000 < er_amt[1]*10))
                            {
                                approx_ans = rand()%65535;
                                //printf("Here1: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                            }
                            else if((al_sig > 10) && (al_sig <= 100) && (rand()%1000 < er_amt[2]*10))
                            {
                                approx_ans = rand()%65535;
                                //printf("Here2: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                            }
                            else if((al_sig > 1)  && (al_sig <= 10) && (rand()%1000 < er_amt[3]*10))
                            {
                                approx_ans = rand()%65535;
                                //printf("Here3: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                            }
                            else
                            {
                                approx_ans = actual_ans;
                                //printf("NO Approx: Act:%f  Approx:%f\n",actual_ans,approx_ans);
                            }
                            break;
                    
                    
                            */
