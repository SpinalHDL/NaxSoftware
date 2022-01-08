/*
 * FreeRTOS Kernel V10.2.1
 * Copyright (C) 2019 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * http://www.FreeRTOS.org
 * http://aws.amazon.com/freertos
 *
 * 1 tab == 4 spaces!
 */

/* FreeRTOS kernel includes. */
#include <FreeRTOS.h>
#include <task.h>

#include "bsp.h"
#include "riscv.h"

/******************************************************************************
 * This project provides two demo applications.  A simple blinky style project,
 * and a more comprehensive test and demo application.  The
 * mainCREATE_SIMPLE_BLINKY_DEMO_ONLY setting (defined in this file) is used to
 * select between the two.  The simply blinky demo is implemented and described
 * in main_blinky.c.  The more comprehensive test and demo application is
 * implemented and described in main_full.c.
 *
 * This file implements the code that is not demo specific, including the
 * hardware setup and standard FreeRTOS hook functions.
 *
 * ENSURE TO READ THE DOCUMENTATION PAGE FOR THIS PORT AND DEMO APPLICATION ON
 * THE http://www.FreeRTOS.org WEB SITE FOR FULL INFORMATION ON USING THIS DEMO
 * APPLICATION, AND ITS ASSOCIATE FreeRTOS ARCHITECTURE PORT!
 *
 */

/* Set mainCREATE_SIMPLE_BLINKY_DEMO_ONLY to one to run the simple blinky demo,
or 0 to run the more comprehensive test and demo application. */
#define mainCREATE_SIMPLE_BLINKY_DEMO_ONLY    1

/*
 * main_blinky() is used when mainCREATE_SIMPLE_BLINKY_DEMO_ONLY is set to 1.
 * main_full() is used when mainCREATE_SIMPLE_BLINKY_DEMO_ONLY is set to 0.
 */
#if mainCREATE_SIMPLE_BLINKY_DEMO_ONLY == 1
    extern void main_blinky( void );
#else
    extern void main_full( void );
#endif /* #if mainCREATE_SIMPLE_BLINKY_DEMO_ONLY == 1 */

/* Prototypes for the standard FreeRTOS callback/hook functions implemented
within this file.  See https://www.freertos.org/a00016.html */
void vApplicationMallocFailedHook( void );
void vApplicationIdleHook( void );
void vApplicationStackOverflowHook( TaskHandle_t pxTask, char *pcTaskName );
void vApplicationTickHook( void );

/* Prepare hardware to run the demo. */
static void prvSetupHardware( void );

/* Send a message to the UART initialised in prvSetupHardware. */
void vSendString( const char * const pcString );

extern void hal_setup();

#include "tests.h"
#include "timers.h"
#define mainCHECK_TIMER_PERIOD_MS			( 100UL / portTICK_PERIOD_MS )
/*-----------------------------------------------------------*/


static void prvCheckTimerCallback( TimerHandle_t xTimer );



void  __attribute__ ((noinline)) c_fail(){
    while(1);
}
void  __attribute__ ((noinline)) c_pass(){
    while(1);
}
void exit(int error){
    if(error) c_fail(); else c_pass();
    while(1);
}

int main( void )
{
    TimerHandle_t xCheckTimer = NULL;
    prvSetupHardware();
    bsp_putString("Create tests\n");
    createTests();

    bsp_putString("Create check timer\n");
    xCheckTimer = xTimerCreate( "CheckTimer",					/* A text name, purely to help debugging. */
                                ( mainCHECK_TIMER_PERIOD_MS ),	/* The timer period, in this case 3000ms (3s). */
                                pdTRUE,							/* This is an auto-reload timer, so xAutoReload is set to pdTRUE. */
                                ( void * ) 0,					/* The ID is not used, so can be set to anything. */
                                prvCheckTimerCallback			/* The callback function that inspects the status of all the other tasks. */
                              );

	if( xCheckTimer != NULL )
	{
        bsp_putString("Start check timer\n");
		xTimerStart( xCheckTimer, 0 );
	}

	vTaskStartScheduler();

	return 0;

}

int32_t checkTime = 0;
int32_t totalTime = 0;
static void prvCheckTimerCallback(__attribute__ ((unused)) TimerHandle_t xTimer )
{
	checkTime += 100;
	totalTime += 100;
    bsp_putString("Check tick\n");

	if(checkTime < CHECK_PERIOD_MS){
		return;
	}
	checkTime -= CHECK_PERIOD_MS;

	unsigned long ulErrorFound = checkTests();
	if( ulErrorFound != pdFALSE )
	{
		bsp_putString("Error found!\n");

	}else{
		if(totalTime < CHECK_COUNT*CHECK_PERIOD_MS)
			return;
		bsp_putString("PASS!\n");
	}

	exit(ulErrorFound);

	/* Stop scheduler */
    vTaskEndScheduler();
}

/*-----------------------------------------------------------*/

static void prvSetupHardware( void )
{
    extern void freertos_risc_v_trap_handler();
    csr_write(mtvec, freertos_risc_v_trap_handler);

    hal_setup();

    vSendString( "Hello world\n" );
}
/*-----------------------------------------------------------*/

void vToggleLED( void )
{
static uint32_t ulLEDState = 0;

    //GPIO_set_outputs( &g_gpio_out, ulLEDState );
    //ulLEDState = !ulLEDState;
}
/*-----------------------------------------------------------*/

void vSendString( const char * const pcString )
{
    bsp_putString(pcString);
}
/*-----------------------------------------------------------*/

void vApplicationMallocFailedHook( void )
{
    /* vApplicationMallocFailedHook() will only be called if
    configUSE_MALLOC_FAILED_HOOK is set to 1 in FreeRTOSConfig.h.  It is a hook
    function that will get called if a call to pvPortMalloc() fails.
    pvPortMalloc() is called internally by the kernel whenever a task, queue,
    timer or semaphore is created.  It is also called by various parts of the
    demo application.  If heap_1.c or heap_2.c are used, then the size of the
    heap available to pvPortMalloc() is defined by configTOTAL_HEAP_SIZE in
    FreeRTOSConfig.h, and the xPortGetFreeHeapSize() API function can be used
    to query the size of free heap space that remains (although it does not
    provide information on how the remaining heap might be fragmented). */
    taskDISABLE_INTERRUPTS();
    __asm volatile( "ebreak" );
    for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationIdleHook( void )
{
    /* vApplicationIdleHook() will only be called if configUSE_IDLE_HOOK is set
    to 1 in FreeRTOSConfig.h.  It will be called on each iteration of the idle
    task.  It is essential that code added to this hook function never attempts
    to block in any way (for example, call xQueueReceive() with a block time
    specified, or call vTaskDelay()).  If the application makes use of the
    vTaskDelete() API function (as this demo application does) then it is also
    important that vApplicationIdleHook() is permitted to return to its calling
    function, because it is the responsibility of the idle task to clean up
    memory allocated by the kernel to any task that has since been deleted. */
}
/*-----------------------------------------------------------*/

void vApplicationStackOverflowHook( TaskHandle_t pxTask, char *pcTaskName )
{
    ( void ) pcTaskName;
    ( void ) pxTask;

    /* Run time stack overflow checking is performed if
    configCHECK_FOR_STACK_OVERFLOW is defined to 1 or 2.  This hook
    function is called if a stack overflow is detected. */
    taskDISABLE_INTERRUPTS();
    __asm volatile( "ebreak" );
    for( ;; );
}
/*-----------------------------------------------------------*/

void vApplicationTickHook( void )
{
    /* The tests in the full demo expect some interaction with interrupts. */
    #if( mainCREATE_SIMPLE_BLINKY_DEMO_ONLY != 1 )
    {
        extern void vFullDemoTickHook( void );
        vFullDemoTickHook();
    }
    #endif
}


