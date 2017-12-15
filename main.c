/*
 * 2017, Aurelio Colosimo <aurelio@aureliocolosimo.it>
 * This file is part of fatfs-stm32f4:
 * https://github.com/colosimo/fatfs-stm32
 * MIT License
 */

#include <basic.h>
#include <kprint.h>

void main(void)
{
	u32 ticks = 0;
	int i = 0;

	kprint("Hello from ff_demo\r\n");

	while(1) {
		if (systicks() - ticks > 1000) {
			ticks = systicks();
			kprint(".");
			i++;
			if (i == 60) {
				i = 0;
				kprint("\r\n");
			}
		}
	}
}
