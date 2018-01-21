#include <stdio.h>
//#include "params.h"
//#include "params_20_identity.h"
#include "params_tanh_q.h"
#include "test_images_2.h"
#include "test_labels.h"
#include <sys/time.h>
#include <omp.h>
#include<math.h>
#define SIZE 10000

// Swagath Mod for quantizing outputs of neurons //
float scale_min = -1;
float scale_max = 1;
int no_levels = 256;
float lev_range = (scale_max - scale_min)/no_levels;
float op_max = -10000;
float op_min = 10000;
// Swagath Mod for Approximation //
typedef enum  {REL,RATE,SIG,NIL,EXP_RATE} ER_TYPE;
ER_TYPE er_type = REL;
float er_amt = 0;
// END //

typedef struct {
    // Layer Parameters
    int neu_c;
    int win_s;
    int fea_c;
    int fea_s;
} nnl;

float neu_mac (float* , float* , int, float );
float neu_mac_ws (float* , float* , int , int, float  );
float neu_mac_w (float* , float* , int , int* , nnl*, float );
float tanh (float);
// ******** I0 ******** //
float outI0[1024];

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
float outC5[120];
float* i_n_addC5[120];
float* w_n_addC5[120];
float* b_n_addC5[120];
float* o_n_addC5[120]; 

nnl C5 = {120, 0, 1, 1};

// ******* F6 ******** //
float out[10];
float* i_n_addF6[10];
float* w_n_addF6[10];
float* b_n_addF6[10];
float* o_n_addF6[10]; 

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
    float* w_ptr;
    float* b_ptr;
    float* i_ptr;
    float* o_ptr;
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
        #pragma omp parallel for
        for(n=0; n < C1.neu_c ; n++)
        {
            *(o_n_addC1[n]) = neu_mac_w(i_n_addC1[n],w_n_addC1[n],C1.win_s,c_n_addC1[n], &I0,*(b_n_addC1[n])); 
            //*(o_n_addC1[n]) += *(b_n_addC1[n]);
            //printf(" %d : %f\n",idC1[n],*(o_n_addC1[n]));
        }
        // S2
        //printf("Next layer\n");
        for(n=0; n < S2.neu_c ; n++)
        {
            *(o_n_addS2[n]) = neu_mac_ws(i_n_addS2[n],w_n_addS2[n],S2.win_s,C1.fea_s,*(b_n_addS2[n])); 
            //*(o_n_addS2[n]) += *(b_n_addS2[n]);
            //printf(" %d : %f\n",n,*(o_n_addS2[n]));
        }
        // C3
        //printf("Next layer\n");
        #pragma omp parallel for
        for(n=0; n < C3.neu_c ; n++)
        {
            *(o_n_addC3[n]) = neu_mac_w(i_n_addC3[n],w_n_addC3[n],C3.win_s,c_n_addC3[n], &S2,*(b_n_addC3[n])); 
            //*(o_n_addC3[n]) += *(b_n_addC3[n]);
            //printf(" %d : %f\n",idC3[n],*(o_n_addC3[n]));
        }
        // S4
        //printf("Next layer\n");
        for(n=0; n < S4.neu_c ; n++)
        {
            *(o_n_addS4[n]) = neu_mac_ws(i_n_addS4[n],w_n_addS4[n],S4.win_s,C3.fea_s,*(b_n_addS4[n])); 
            //*(o_n_addS4[n]) += *(b_n_addS4[n]);
           // printf(" %d : %f\n",n,*(o_n_addS4[n]));
        }
        // C5
        //printf("Next layer\n");
        #pragma omp parallel for
        for(n=0; n < C5.neu_c ; n++)
        {
            *(o_n_addC5[n]) = neu_mac(i_n_addC5[n],w_n_addC5[n],S4.neu_c,*(b_n_addC5[n]));
            //*(o_n_addC5[n]) += *(b_n_addC5[n]);
            //printf(" %d : %f\n",n,*(o_n_addC5[n]));
        }
        // F6
        //printf("Next layer\n");
        for(n=0; n < F6.neu_c ; n++)
        {
            *(o_n_addF6[n]) = neu_mac(i_n_addF6[n],w_n_addF6[n],C5.neu_c,*(b_n_addF6[n]));
            //*(o_n_addF6[n]) += *(b_n_addF6[n]);
            //printf(" %d : %f\n",n,*(o_n_addF6[n]));
        }
        // Find Max value to get label and update result
        //printf("OUTPUT %d\n",ipc);
        float max_val = -10000.0;
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


float neu_mac (float* ip_st, float* w_st, int size, float bias)
{
    int i;
    float* ip = ip_st;
    float* w = w_st;
    float op = 0.0;
    for (i=0;i < size; i++)
    {
        op += *ip * *w;
        ip++;
        w++;
    }
    op += bias*128;
   // op_max = (op > op_max) ? op : op_max;
   // op_min = (op < op_min) ? op : op_min;
    //op = tanh((int)op/16384.0);
    op = tanh(op);
    //op_max = (op > op_max) ? op : op_max;
    //op_min = (op < op_min) ? op : op_min;
    //int op_lev  = (int) ((op - scale_min)/lev_range);
    //float qop = (int)((lev_range * op_lev + scale_min)*127);
    //float qop = (int) (op*127);
    return (op);
}

float neu_mac_ws (float* ip_st, float* w_st, int win_size, int ip_fea_dim, float bias)
{
    int i,j;
    float* ip = ip_st;
    float op = 0.0;
    int ip_incr = ip_fea_dim - win_size;
    for (i=0;i < win_size; i++)
    {
        for(j=0;j<win_size;j++)
        {
            op += *ip * *w_st;
            ip++;
        }
        ip += ip_incr; 
    }
    op = op/(win_size*win_size);
    op += bias*128;
   // op_max = (op > op_max) ? op : op_max;
  //  op_min = (op < op_min) ? op : op_min;
  //  op = tanh((int)op/16384.0);
    op = tanh(op);
    // Quantizing Output
    //op_max = (op > op_max) ? op : op_max;
    //op_min = (op < op_min) ? op : op_min;
    //int op_lev  = (int) ((op - scale_min)/lev_range);
    //float qop = lev_range * op_lev + scale_min;
    //float qop = (int) (op*127);
    return (op);
}

float neu_mac_w (float* ip_st, float* w_st, int win_size, int* ct_st, nnl* ip_lay, float bias)
{
    int h,i,j;
    float* ip; 
    float* w = w_st;
    float op = 0.0;
    int ip_incr = ip_lay->fea_s - win_size;
    for (h=0; h < ip_lay->fea_c ; h++)
    {
        ip = ip_st + h * ip_lay->fea_s * ip_lay->fea_s;
        if(*(ct_st+h)==1)
        {
            for (i=0;i < win_size; i++)
            {
                for(j=0;j<win_size;j++)
                {
                    float  approx_ans = *ip * *w;
                    op += approx_ans;
                    ip++;
                    w++;
                }
                ip += ip_incr; 
            }
        }
    }
    op += bias*128;
   // op_max = (op > op_max) ? op : op_max;
   // op_min = (op < op_min) ? op : op_min;
    //op = (int)op/16384.0;
    //op = tanh((int)op/16384.0);
    op = tanh(op);
    // Quantizing Output
    //int op_lev  = (int) ((op - scale_min)/lev_range);
    //float qop = lev_range * op_lev + scale_min;
    //float qop = (int) (op*127);
 //   printf ("Op: %f  .. Qop: %f .. Op_lev: %d\n", op,qop,op_lev);
    return (op);
}

float tanh (float x)
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
        float ox = 260144641 - (x*x/2);
        return ((x*ox)/pow(128,5)); 
        //return(x-pow(x,3)/2); //+2*pow(x,5)/15);
    }
    //float ox = 260144641 - (x*x/2);
    //return (x*ox/pow(127,6)); 
    //float ex = exp(x); 
    //float emx = exp(-x);
    //return ((ex-emx)/(ex+emx));
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
                    
                    
                    float  actual_ans = *ip * *w;
                    float  approx_ans;
                    float  er_range;
                    switch(er_type)
                    {
                        case REL:
                            er_range = 2*er_amt[0]*actual_ans/100;
                            if(er_range != 0)
                            {
                                int error = (rand () % er_range) - er_range/2;
                                approx_ans = actual_ans + error;
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
                                approx_ans = rand()%65535;
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
                            */
