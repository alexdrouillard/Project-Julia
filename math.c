#include <stdio.h>

float float_add(float a, float b){
	return a + b;

}

float float_subtract(float a, float b){
	return a - b;

}

float float_multiply(float a, float b){
	return a * b;

}

float float_divide(float a, float b){
	return a / b;

}

float int_to_float(int a) {
	return (float)a;

}

int float_to_int(float a) {
	return (int)a;
}

void print_float(float a) {
	printf("%f ", a);

}

void print_linebreak() {
	printf("/n");

}