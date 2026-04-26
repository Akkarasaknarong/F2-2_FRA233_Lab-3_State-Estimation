/*
 * hc-sr504.cpp
 *
 *  Created on: Apr 13, 2026
 *      Author: Akkarasaknarong
 */

#include "hc_sr04.h"

static void HCSR04_DelayUs(TIM_HandleTypeDef *htim, uint16_t us)
{
    __HAL_TIM_SET_COUNTER(htim, 0);
    while (__HAL_TIM_GET_COUNTER(htim) < us)
    {
    }
}

void HCSR04_Init(HCSR04_HandleTypeDef *sensor,
                 GPIO_TypeDef *trig_port,
                 uint16_t trig_pin,
                 TIM_HandleTypeDef *htim_ic,
                 TIM_HandleTypeDef *htim_delay_us)
{
    sensor->trig_port = trig_port;
    sensor->trig_pin = trig_pin;
    sensor->htim_ic = htim_ic;
    sensor->htim_delay_us = htim_delay_us;
    sensor->echo_time_us = 0;

    HAL_TIM_Base_Start(sensor->htim_ic);
    HAL_TIM_IC_Start(sensor->htim_ic, TIM_CHANNEL_1);
    HAL_TIM_IC_Start(sensor->htim_ic, TIM_CHANNEL_2);
    HAL_TIM_Base_Start(sensor->htim_delay_us);
}

float HCSR04_ReadDistanceCm(HCSR04_HandleTypeDef *sensor)
{
    HAL_GPIO_WritePin(sensor->trig_port, sensor->trig_pin, GPIO_PIN_SET);
    HCSR04_DelayUs(sensor->htim_delay_us, 10);
    HAL_GPIO_WritePin(sensor->trig_port, sensor->trig_pin, GPIO_PIN_RESET);
    sensor->echo_time_us = __HAL_TIM_GET_COMPARE(sensor->htim_ic, TIM_CHANNEL_2);

    if (sensor->echo_time_us == 0 || sensor->echo_time_us > 36000)
    {
        return -1.0f;
    }

    return (float)sensor->echo_time_us / 58.0f;
}


