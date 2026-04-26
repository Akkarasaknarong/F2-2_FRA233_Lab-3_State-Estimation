/*
 * Serial_frame.c
 *
 *  Created on: Apr 21, 2026
 *      Author: Akkarasaknarong
 */

#include "Serial_frame.h"
#include <string.h>

static uint8_t SerialFrame_Checksum(const uint8_t *data, uint16_t len) {
	uint8_t sum = 0;
	for (uint16_t i = 0; i < len; i++) {
		sum += data[i];
	}
	return sum;
}

void SerialFrame_Init(SerialFrame_t *frame, UART_HandleTypeDef *huart) {
	frame->huart = huart;
	frame->payload_len = 0;
	memset(frame->tx_buf, 0, sizeof(frame->tx_buf));
}

void SerialFrame_Reset(SerialFrame_t *frame) {
	frame->payload_len = 0;
}

HAL_StatusTypeDef SerialFrame_AddPayload(SerialFrame_t *frame, const void *data,uint16_t size) {
	if ((frame->payload_len + size) > SERIAL_MAX_PAYLOAD) {
		return HAL_ERROR;
	}

	memcpy(&frame->tx_buf[3 + frame->payload_len], data, size);
	frame->payload_len += size;

	return HAL_OK;
}

HAL_StatusTypeDef SerialFrame_Transmit(SerialFrame_t *frame,uint32_t Timeout) {
	uint16_t total_len;

	frame->tx_buf[0] = SERIAL_HEADER1;
	frame->tx_buf[1] = SERIAL_HEADER2;
	frame->tx_buf[2] = frame->payload_len;
	frame->tx_buf[3 + frame->payload_len] = SerialFrame_Checksum(frame->tx_buf,3 + frame->payload_len);
	total_len = 2 + 1 + frame->payload_len + 1 ;
	HAL_StatusTypeDef status = HAL_UART_Transmit(frame->huart, frame->tx_buf, total_len, Timeout);

	frame->payload_len = 0 ;
	return status ;
}
