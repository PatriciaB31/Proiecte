(defun c:CBrk (/ ss tmp i j ent elst inc) ;functie cu 7 variabile locale
  

  (or Cbrk:num (setq Cbrk:num 2))

  (cond ((setq ss (ssget '((0 . "CIRCLE"))))		;selecteaza tipul de elemente care sunt prelucrate
         
         (initget 6)					;protejeaza utilizatorul de a introduce valori negative sau 0
         (and (setq tmp (getint (strcat "\nSpecify Number of Sections <" (itoa Cbrk:num) "> : ")))	;numarul de sectiuni
              (setq Cbrk:num tmp))

         (setq i -1)
         (while (setq ent (ssname ss (setq i (1+ i))))
           (setq elst (entget ent) inc (/ (* 2 pi) cBrk:num) j -1)

           (repeat cbrk:num
             (entmake (list (cons   0 "ARC")
                            (assoc  8  elst)
                            (assoc 10  elst)
                            (assoc 40  elst)
                            (cons  50 (* (setq j (1+ j)) inc))
                            (cons  51 (* (1+ j) inc))))
             
             (entmake (list (cons   0 "LINE")
                            (assoc  8   elst)
                            (assoc 10   elst)
                            (cons  11 (polar (cdr (assoc 10 elst))
                                             (* j inc)
                                             (cdr (assoc 40 elst)))))))
         (entdel ent))))

  (princ))

  (defun TextB ( / point inaltime unghi txt)			
    
  (setq point (getpoint "\nSelectati un punct: "))			
     
  (setq inaltime (getint "\nSelectati o inaltime: "))		

  (setq unghi (getint "\nSelectati un unghi: "))			

  (setq txt (getstring "\nIntroduceti un text: "))			

  	(command "TEXT" point inaltime unghi txt)		

  (princ)								

) 
(defun C:SeteazaCuloareText  ( / ss i txt txtData nrC culoare)		

  (initget 7) 

  (setq nrC (getint "\nSelecteaza un numar pentru culoare: 1-Albastru, 2-Galben, 3-Verde, 4-Rosu"))									

  (cond ((equal nrC 1) (setq culoare "blue"))				

((equal nrC 2) (setq culoare "yellow"))				

((equal nrC 3) (setq culoare "green"))				

((equal nrC 4) (setq culoare "red")))				

   

  (setq ss (ssget "X" '((0 . "TEXT"))))						

  (setq i 0)									 

 

  (repeat (sslength ss)								 

    (setq txt (ssname ss i))							

    (setq txtData (entget txt))							

 

    (command "chprop" txt "" "color" culoare "")					 

 

    (setq i (1+ i))									

  ) 

  (princ)										

) 