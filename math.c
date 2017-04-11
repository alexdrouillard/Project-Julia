#include <stdio.h>
#include <math.h>
#include <stdbool.h>

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

float string_to_float(const char* s){
  float rez = 0, fact = 1;
  if (*s == '-'){
    s++;
    fact = -1;
  };
  for (int point_seen = 0; *s; s++){
    if (*s == '.'){
      point_seen = 1; 
      continue;
    };
    int d = *s - '0';
    if (d >= 0 && d <= 9){
      if (point_seen) fact /= 10.0f;
      rez = rez * 10.0f + (float)d;
    };
  };
  return rez * fact;
}

void print_float(float a) {
	printf("%f ", a);

}

void print_linebreak() {
	printf("\n");

}

void print_complex(float a, float b) {
    printf("%f + %fi\n", a, b);
}

void print_int(int a) {
    printf("%d\n", a);
}
