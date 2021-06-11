

    XDEF  speaker 
    XREF SendsChr 

  speaker:  
; should add
; jingle for setup menu 
; jingle for inflight audio
; audio scale for ascend and descend
                    ldx 3,sp 

                    ldy 5,sp 

                     

         lp1:      ldaa 1,y+ 

                    psha  

                    call  SendsChr 

                    pula    

                    dex    

                       

                    bne lp1 

                    rtc 

                    nop 