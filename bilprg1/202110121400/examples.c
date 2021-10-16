#include <stdio.h>

static int this   = 3;
static int that   = 5;
static int result = 0;

int main()
{
	result = this + that;

	printf("%d\n", result);

	return 0;
}
