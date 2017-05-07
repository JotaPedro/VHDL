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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_0017514958;
char *STD_STANDARD;
char *IEEE_P_2592010699;
char *IEEE_P_3620187407;
char *IEEE_P_3499444699;
char *WORK_P_0742361385;
char *SYNOPSYS_P_3308480207;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_p_0742361385_init();
    work_a_1679166359_3212880686_init();
    work_a_0269445667_3212880686_init();
    work_a_4025018205_3212880686_init();
    work_a_0286128724_3212880686_init();
    synopsys_p_3308480207_init();
    ieee_p_0017514958_init();
    work_a_0902411490_3212880686_init();
    work_a_1899197625_3212880686_init();
    work_a_0989779605_3212880686_init();
    work_a_1535883916_3212880686_init();
    work_a_1066189871_3212880686_init();
    work_a_0852850041_2372691052_init();


    xsi_register_tops("work_a_0852850041_2372691052");

    IEEE_P_0017514958 = xsi_get_engine_memory("ieee_p_0017514958");
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    WORK_P_0742361385 = xsi_get_engine_memory("work_p_0742361385");
    SYNOPSYS_P_3308480207 = xsi_get_engine_memory("synopsys_p_3308480207");

    return xsi_run_simulation(argc, argv);

}