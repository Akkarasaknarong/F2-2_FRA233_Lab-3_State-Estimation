/*
 * hc-sr504.h
 *
 *  Created on: Apr 13, 2026
 *      Author: Akkarasaknarong
 */

#ifndef HC_SR04_H_
#define HC_SR04_H_

#include "stm32g4xx_hal.h"
#include <stdint.h>

typedef struct {
    GPIO_TypeDef *trig_port;
    uint16_t trig_pin;
    TIM_HandleTypeDef *htim_ic;
    TIM_HandleTypeDef *htim_delay_us;
    uint32_t echo_time_us;
} HCSR04_HandleTypeDef;

void HCSR04_Init(HCSR04_HandleTypeDef *sensor,
                 GPIO_TypeDef *trig_port,
                 uint16_t trig_pin,
                 TIM_HandleTypeDef *htim_ic,
                 TIM_HandleTypeDef *htim_delay_us);
float HCSR04_ReadDistanceCm(HCSR04_HandleTypeDef *sensor);

#endif /* HC_SR04_H_ */
