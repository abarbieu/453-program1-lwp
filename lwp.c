#include <stdio.h>
#include <stdlib.h>
#include "lwp.h"

schedfun *scheduler;
lwp_context ptable[LWP_PROC_LIMIT];
ptr_int_t *realSP;
int procs = 0;
int curr_proc;

// queue definition for round robin
typedef struct node{
    int id;
    struct node *prev;
    struct node *next;
} qnode;

qnode *head, *qtail;
void qins(int id){
    if(qhead == NULL){
        qhead = (qnode *) malloc(sizeof(qnode));
        qhead->id = id;
        qhead->prev = NULL;
        qhead->next = NULL;
        qtail = qhead;
    }else{
        qtail->next = (qnode *) malloc(sizeof(qnode));
        qtail->next->id = id;
        qtail->next->prev = qtail;
        qtail->next->next-> = NULL;
        qtail = qtail->next;
    }
}

int qpop(){
    int popped = qhead->id;
    node *oldhead = qhead;
    qhead = qhead->next;
    free(oldhead);
    return popped;
}

int qdel(int id){
    node *curr = qhead, *deleted;
    while(curr != NULL){
        if(curr->id == id){
            deleted = curr;
            curr->prev->next = curr->next;
            curr->next->prev = curr->prev;
            free(deleted;
            return id;
        }else{
            curr = curr->next;
        }
    }
    return -1;
}

int round_robin(){
    int out = qpop();
    qins(out);
    return out;
}

//---------LWP---------

int new_lwp(lwpfun func, void *arg, size_t stacksize){
    ptr_int_t *sp, *stack, *newbp;

    if(procs == LWP_PROC_LIMIT){
        return -1;
    }
    curr_proc = procs;
    stack = malloc(stacksize * sizeof(ptr_int_t));
    sp = stack + stacksize;



    *(--sp) = (ptr_int_t) arg;
    *(--sp) = (ptr_int_t) lwp_exit;
    *(--sp) = (ptr_int_t) func;
    *(--sp) = (ptr_int_t) 0xABCDEF01234; // bogus bp
    newbp = sp;
    // 6 bogus registers
    *(--sp) = 0x99999999
    *(--sp) = 0xAAAAAAAA;
    *(--sp) = 0xBBBBBBBB;
    *(--sp) = 0xCCCCCCCC;
    *(--sp) = 0xDDDDDDDD;
    *(--sp) = 0xEEEEEEEE;
    *(--sp) = 0xFFFFFFFF;
    
    *(--sp) = (ptr_int_t) newbp // real bp
    
    ptable[curr_proc].pid = ++procs;
    ptable[curr_proc].stack = stack;
    ptable[curr_proc].stacksize = stacksize;
    ptable[curr_proc].sp = sp;

    ++procs;
    return ptable[curr_proc].pid;
}

void lwp_exit(){
    return;
}

int lwp_getpid(){
    return ptable[curr_proc].pid;
}

void lwp_yield(){
    SetSP(ptable[curr_proc].sp);
    RESTORE_STATE();
    // SAVE_STATE();
    // GetSP(ptable[curr_proc].sp);
    // if(scheduler == NULL){
    //     scheduler = round_robin;
    // }
    // curr_proc = scheduler();
    // SetSP(ptable[curr_proc].sp);
    // RESTORE_STATE();
}

void lwp_start(){
}

void lwp_stop(){
}

void lwp_set_scheduler(schedfun sched){
    if(sched == NULL){
        scheduler = round_robin;
    }else{
        scheduler = sched;
    }
}

/* General helper functions */
void *malloc_s(size_t size) {
    /* Malloc and check errors */
    void *loc;
    if (!(loc = malloc(size))) {
        return loc;
    }
    else {
        perror("malloc failure");
        exit(EXIT_FAILURE);
    }
}