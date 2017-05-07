/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "F:/Projecto/github repo/VHDL/BnB.vhd";
extern char *IEEE_P_3499444699;
extern char *IEEE_P_2592010699;

char *ieee_p_2592010699_sub_1837678034_503743352(char *, char *, char *, char *);
char *ieee_p_3499444699_sub_4232465333_3536714472(char *, char *, char *, char *, int );


static void work_a_1679166359_3212880686_p_0(char *t0)
{
    char t5[16];
    char t6[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned char t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(43, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(46, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB7;

LAB9:
LAB8:
LAB3:    t1 = (t0 + 2832);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(45, ng0);
    t1 = (t0 + 1032U);
    t7 = *((char **)t1);
    t1 = (t0 + 4468U);
    t8 = ieee_p_2592010699_sub_1837678034_503743352(IEEE_P_2592010699, t6, t7, t1);
    t9 = ieee_p_3499444699_sub_4232465333_3536714472(IEEE_P_3499444699, t5, t8, t6, 1);
    t10 = (t5 + 12U);
    t11 = *((unsigned int *)t10);
    t12 = (1U * t11);
    t13 = (4U != t12);
    if (t13 == 1)
        goto LAB5;

LAB6:    t14 = (t0 + 2912);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t9, 4U);
    xsi_driver_first_trans_fast_port(t14);
    goto LAB3;

LAB5:    xsi_size_not_matching(4U, t12, 0);
    goto LAB6;

LAB7:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 1032U);
    t7 = *((char **)t1);
    t1 = (t0 + 2912);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t14 = *((char **)t10);
    memcpy(t14, t7, 4U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB8;

}


extern void work_a_1679166359_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1679166359_3212880686_p_0};
	xsi_register_didat("work_a_1679166359_3212880686", "isim/Barrel_Shift_TB_isim_beh.exe.sim/work/a_1679166359_3212880686.didat");
	xsi_register_executes(pe);
}
