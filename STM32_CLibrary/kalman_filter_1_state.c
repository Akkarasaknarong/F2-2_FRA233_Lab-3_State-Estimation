/*
 * kalman_filter_1_state.c
 *
 *  Created on: Apr 26, 2026
 *      Author: Akkarasaknarong
 */

#include "kalman_filter_1_state.h"

void kalman_filter_1state_init(KalmanFilter1State_t *kf) {
	kf->a = 1.0f;
	kf->h = 1.0f;
	kf->q = 0.0f;
	kf->r = 1.0f;
	kf->x_prev = 0.0f;
	kf->p_prev = 1.0f;
}

void kalman_filter_1state_set_model(KalmanFilter1State_t *kf, float a, float h, float q,  float r) {
	kf->a = a;
	kf->q = q;
	kf->h = h;
	kf->r = r;
}

float kalman_filter_1state_update(KalmanFilter1State_t *kf, float z) {
	// State 1: Prediction
	float x_pred = kf->x_prev;
	float p_pred = kf->p_prev + kf->q;

	// State 2: Correction
	float k = (p_pred)/(p_pred + kf->r);
	float error = z - kf->x_pred;

	float x_est = x_pred + (k * error);
	float p_est = (1.0f - k) * p_pred;

	// State 3: Save previous state
	kf->x_prev = x_est;
	kf->p_prev = p_est;

	return kf->x_est;
}

