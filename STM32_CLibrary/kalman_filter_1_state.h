/*
 * kalman_filter_1_state.h
 *
 *  Created on: Apr 26, 2026
 *      Author: Akkarasaknarong
 */

#ifndef INC_KALMAN_FILTER_1_STATE_H_
#define INC_KALMAN_FILTER_1_STATE_H_

typedef struct {
    float a; // Dynamic
    float h; // Measurement
    float r; // Sensor variance
    float q; // Process variance

    float x_prev ; // Previous state
    float p_prev ;// Previous Prediction
} KalmanFilter1State_t;

void kalman_filter_1state_init(KalmanFilter1State_t *kf);
void kalman_filter_1state_set_model(KalmanFilter1State_t *kf,
                                    float a,
									float h,
                                    float q,
                                    float r);
float kalman_filter_1state_update(KalmanFilter1State_t *kf, float z);
#endif /* INC_KALMAN_FILTER_1_STATE_H_ */
