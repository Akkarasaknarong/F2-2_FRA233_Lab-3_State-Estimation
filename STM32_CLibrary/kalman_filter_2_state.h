/*
 * Kalman_Filter.h
 *
 *  Created on: Apr 16, 2026
 *      Author: Akkarasaknarong
 */

#ifndef INC_KALMAN_FILTER_2_STATE_H_
#define INC_KALMAN_FILTER_2_STATE_H_

typedef struct {
	float a[2][2];
	float q[2][2];
	float h[2];
	float r;

	float x[2];
	float p[2][2];
} KalmanFilter2State_t;

void kalman_filter_2state_init(KalmanFilter2State_t *kf);
void kalman_filter_2state_set_model(KalmanFilter2State_t *kf,
						     float a[2][2],
							 float q[2][2],
							 float h[2],
							 float r);
void kalman_filter_2state_update(KalmanFilter2State_t *kf, float z);
#endif /* INC_KALMAN_FILTER_2_STATE_H_ */
