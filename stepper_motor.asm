    XDEF stepper_motor
    
    
MY_CONSTANTS: SECTION 

port_s:       equ $248 ;equate port s to $248 
port_s_ddr:   equ $24a ;equate port sddr to $24a  
port_t_ddr:    equ $243;  
port_t:       equ   $240  
port_p:       equ   $258  
port_p_ddr:    equ  $25A 

My_variable:  SECTION

values:     dc.b   $0a,$12,$14,$0c   
delaycount: ds.w    1 

stepper_motor:

;each plane has its own combination of switches 
; when the combination is pressed and a certain switch is dedicated for yhe ascend and descend.
; the ascend and descend loop is called

stepload: ldx #values

;to trigger ascend or descend 
          
ascend: 
          ldaa 1,x+
          staa port_p
          jsr  persecond
          incb
          cmpb #4
          beq stepload
          bra ascend
          
descend:
        ldaa 3,x
        dex
        staa port_p
        jsr persecond
        incb
        cmpb #4
        beq stepload
        bra descend
        
  
persecond: ldy #1000; per second 
   loop:   dey
           bne loop
           rts

  ; addition of slow pick up of speed of the stepper motor 
  ; addition of slow drop of the speed of the stepper motor

   