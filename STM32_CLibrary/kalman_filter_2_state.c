/*
 * Kalman_Filter.c
 *
 *  Created on: Apr 16, 2026
 *      Author: Akkarasaknarong
 */
#include "kalman_filter_2_state.h"

static void mat2x2_mul_mat2x2(float a[2][2], float b[2][2], float out[2][2]) {
	out[0][0] = a[0][0] * b[0][0] + a[0][1] * b[1][0];
	out[0][1] = a[0][0] * b[0][1] + a[0][1] * b[1][1];
	out[1][0] = a[1][0] * b[0][0] + a[1][1] * b[1][0];
	out[1][1] = a[1][0] * b[0][1] + a[1][1] * b[1][1];
}

static void mat2x2_mul_mat2x1(float a[2][2], float x[2], float out[2])
{
    out[0] = a[0][0] * x[0] + a[0][1] * x[1];
    out[1] = a[1][0] * x[0] + a[1][1] * x[1];
}


static void mat1x2_mul_mat2x2(float h[2], float p[2][2], float out[2])
{
    out[0] = h[0] * p[0][0] + h[1] * p[1][0];
    out[1] = h[0] * p[0][1] + h[1] * p[1][1];
}

static void mat2_add(float a[2][2], float b[2][2], float out[2][2])
{
    out[0][0] = a[0][0] + b[0][0];
    out[0][1] = a[0][1] + b[0][1];
    out[1][0] = a[1][0] + b[1][0];
    out[1][1] = a[1][1] + b[1][1];
}

static void mat2_sub(float a[2][2], float b[2][2], float out[2][2])
{
    out[0][0] = a[0][0] - b[0][0];
    out[0][1] = a[0][1] - b[0][1];
    out[1][0] = a[1][0] - b[1][0];
    out[1][1] = a[1][1] - b[1][1];
}

static void mat2_transpose(float a[2][2], float out[2][2])
{
    out[0][0] = a[0][0];
    out[0][1] = a[1][0];
    out[1][0] = a[0][1];
    out[1][1] = a[1][1];
}

void kalman_filter_2state_init(KalmanFilter2State_t *kf){
    kf->a[0][0] = 1.0f;  kf->a[0][1] = 0.0f;
    kf->a[1][0] = 0.0f;  kf->a[1][1] = 1.0f;

    kf->q[0][0] = 0.0f;  kf->q[0][1] = 0.0f;
    kf->q[1][0] = 0.0f;  kf->q[1][1] = 0.0f;

    kf->h[0] = 1.0f;
    kf->h[1] = 0.0f;

    kf->r = 0.0f;

    kf->x[0] = 0.0f;
    kf->x[1] = 0.0f;

    kf->p[0][0] = 1.0f;  kf->p[0][1] = 0.0f;
    kf->p[1][0] = 0.0f;  kf->p[1][1] = 1.0f;
}

void kalman_filter_2state_set_model(KalmanFilter2State_t *kf,
                             float a[2][2],
                             float q[2][2],
                             float h[2],
                             float r)
{
    kf->a[0][0] = a[0][0];  kf->a[0][1] = a[0][1];
    kf->a[1][0] = a[1][0];  kf->a[1][1] = a[1][1];

    kf->q[0][0] = q[0][0];  kf->q[0][1] = q[0][1];
    kf->q[1][0] = q[1][0];  kf->q[1][1] = q[1][1];

    kf->h[0] = h[0];
    kf->h[1] = h[1];

    kf->r = r;
}

void kalman_filter_2state_update(KalmanFilter2State_t *kf, float z)
{
	// State 0: Define previous state ----------------------------
    float x_prev[2] = { kf->x[0], kf->x[1] };
    float p_prev[2][2] = {
        { kf->p[0][0], kf->p[0][1] },
        { kf->p[1][0], kf->p[1][1] }
    };
    // -----------------------------------------------------------
	// State 1: predict state ------------------------------------
    float x_pred[2];
	mat2x2_mul_mat2x1(kf->a, x_prev, x_pred);

	float p_pred[2][2];
	float at[2][2];
	float ap[2][2];
	mat2_transpose(kf->a, at);
	mat2x2_mul_mat2x2(kf->a, p_prev, ap);
	mat2x2_mul_mat2x2(ap, 	at, p_pred);
	mat2_add(p_pred, kf->q, p_pred);
	// -----------------------------------------------------------
	// State 2: Correction state ---------------------------------
	// Calculate K Gain
	float ph_t[2];
	float hp[2];
	float k[2];
	float s;
	mat2x2_mul_mat2x1(p_pred, kf->h, ph_t); // ph_t = p_pred * H' -> 2x1
	mat1x2_mul_mat2x2(kf->h, p_pred, hp); // hp = H * p_pred  -> 1x2
	s = ((hp[0] * kf->h[0]) + (hp[1] * kf->h[1])) + kf->r; //  s = H * p_pred * H' + R   -> scalar
	k[0] = ph_t[0] / s; // K = (p_pred * H') / s -> 2x1
	k[1] = ph_t[1] / s;
	// Calculate Error
	float error;
	error = z - ((kf->h[0] * x_pred[0]) + (kf->h[1] * x_pred[1]));  // error = z - H * x_pred -> scalar
	// Calculate x_est
	float x_est[2];
	// x_est = x_pred + (K * error) -> 2x1
	x_est[0] = x_pred[0] + (k[0] * error);
	x_est[1] = x_pred[1] + (k[1] * error);

	// Calculate p_est
	float kh[2][2];
	float i[2][2] = { { 1.0f, 0.0f }, { 0.0f, 1.0f } };
	float i_kh[2][2];
	float p_est[2][2];
	// kh = K * H -> 2x2
	kh[0][0] = k[0] * kf->h[0];
	kh[0][1] = k[0] * kf->h[1];
	kh[1][0] = k[1] * kf->h[0];
	kh[1][1] = k[1] * kf->h[1];
	// i_kh = I - K * H -> 2x2
	mat2_sub(i, kh, i_kh);
	// p_est = (I - K * H) * p_pred -> 2x2
	mat2x2_mul_mat2x2(i_kh, p_pred, p_est);
	// -----------------------------------------------------------
	// State 3: Save previous state ----------------------------
	kf->x[0] = x_est[0];
	kf->x[1] = x_est[1];

	kf->p[0][0] = p_est[0][0];
	kf->p[0][1] = p_est[0][1];
	kf->p[1][0] = p_est[1][0];
	kf->p[1][1] = p_est[1][1];
    // -----------------------------------------------------------
}

