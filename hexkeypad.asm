    XDEF hexkeypad
    XDEF debounce

    XDEF val3
    XDEF ton
    XDEF sequence1
    XDEF sequence2


My_variable:  SECTION 

val3         ds.b  1 
ton          ds.b  1 


MY_CONSTANTS: SECTION 

port_u        equ   $268 

port_u_ddr    equ   $26A 

port_u_ppr    equ   $26D 

port_u_enable equ   $26C 

port_s        equ   $248 

port_s_ddr    equ   $24a 

port_t:       equ   $240 

ddr_t:        equ  $242 
sequence1  dc.b  $70, $B0, $D0, $E0, $00 

sequence2  dc.b  $eb, $77, $7b, $7d, $b7, $bb, $bd, $d7, $db, $dd, $e7, $ed, $7e, $be, $de,$ee, $ff 


 hexkeypad:
 
            bset port_u,#$F0   ; set upper four bit as output and lower four bit as input 

            bset port_u_ddr , #$F0 

            bset port_s_ddr , #$FF 

            bset port_u_ppr, #$F0 

            bset port_u_enable ,#$0F       

  

    store: ldx #sequence1  ; enter row sequence 

           ldy #sequence2   ; enter key sequence 

           ldab #0 

      

         

            

     load: ldaa 1,x+             ; go through row sequence 

            cmpa #$00               ; and compare with terminator if equal start over 

            beq store 

            staa port_u ; sequence sent to port_U 

            jsr debounce ;delay debounce  

            ldaa port_u 

            staa val3    ; load port u value in val3 

            brset port_u,#$0f, load   ; go through start loop again if no button pressed 

                    

      loop1:  

            ldaa 1,y+      ; go through key sequence 

            cmpa val3       ; compare with port_u val and if equal store the value in ton 

            beq storeval 

            incb 

            cmpb #16; checks if end of all keys as total number of keys is 16 

            bra loop1 

             

 

    storeval: stab ton 

              
              rts 
debounce: 

           pshy 

           ldy #1000 

   delay:  dey  

           bne delay 

           puly   

           rts 