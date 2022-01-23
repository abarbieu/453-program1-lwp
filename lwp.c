#include <stdio.h>
#include <stdlib.h>
#include "lwp.h"

schedfun *scheduler = NULL;
lwp_context proc_table[LWP_PROC_LIMIT];
ptr_int_t *realSP; // oldSP is to free on exit
int procs = 0;
lwp_context *curr_proc;
int curr_idx = 0;


int round_robin(){
    return (curr_idx + 1) % procs;
    // int prev_proc = qpop();
    // qins(prev_proc);
    // return qhead->idx;
}
//---------LWP---------

int new_lwp(lwpfun func, void *arg, size_t stacksize){
    ptr_int_t *sp, *stack, *newbp;
    lwp_context new_proc;

    if(procs == LWP_PROC_LIMIT){
        return -1;
    }
    stack = (ptr_int_t *) malloc(stacksize * sizeof(ptr_int_t));
    sp = stack + stacksize;

    *sp = (ptr_int_t) arg;
    *(--sp) = (ptr_int_t) lwp_exit;
    *(--sp) = (ptr_int_t) func;
    *(--sp) = (ptr_int_t) 0x88888888; // bogus bp
    newbp = sp;
    // 6 bogus registers
    *(--sp) = 0x99999999;
    *(--sp) = 0xAAAAAAAA;
    *(--sp) = 0xBBBBBBBB;
    *(--sp) = 0xCCCCCCCC;
    *(--sp) = 0xDDDDDDDD;
    *(--sp) = 0xEEEEEEEE;
    *(--sp) = 0xFFFFFFFF;
    
    *(--sp) = (ptr_int_t) newbp; // real bp
    
    new_proc.pid = procs;
    new_proc.stack = stack;
    new_proc.stacksize = stacksize;
    new_proc.sp = sp;

    proc_table[new_proc.pid] = new_proc;
    
    ++procs;
    return new_proc.pid;
}

void lwp_exit(){
    int i;

    if(procs <= 1){
        lwp_stop();
        return;
    }
    for(i = curr_idx; i < procs; i++){
        proc_table[i] = proc_table[i+1];
    }
    procs--;
    
    if(scheduler == NULL){
        curr_idx %= procs;
    }else{
        curr_idx = (*scheduler)();
    }
    curr_proc = &proc_table[curr_idx];

    SetSP(curr_proc->sp);
    RESTORE_STATE();
}

int lwp_getpid(){
    return curr_proc->pid;
}

void lwp_yield(){
    SAVE_STATE();
    GetSP(curr_proc->sp);
    if(scheduler == NULL){
        curr_idx = round_robin();
    }else{
        curr_idx = (*scheduler)();
    }
    curr_proc = &proc_table[curr_idx];
    SetSP(curr_proc->sp);
    RESTORE_STATE();
}

void lwp_start(){
    if(procs == 0){
        return; // no threads to run
    }
    SAVE_STATE();
    GetSP(realSP);

    curr_proc = &proc_table[curr_idx];

    SetSP(curr_proc->sp);
    RESTORE_STATE();
}

void lwp_stop(){
    SetSP(realSP);
    RESTORE_STATE();
}

void lwp_set_scheduler(schedfun sched){
    if(scheduler == NULL){
        scheduler = malloc(sizeof(schedfun));
    }
    *scheduler = sched;
}