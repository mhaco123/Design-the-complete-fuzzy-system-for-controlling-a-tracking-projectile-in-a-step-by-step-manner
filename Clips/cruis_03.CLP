
;;; These are the function facts

(deffacts functions
	(function SpeedDif input)
	(function OriDif input)
	(function g multiplier)
	(function actSpeed output)
	(function actOri output))


;; Fuzzy Set definition
(deftemplate SpeedDif ;definition of fuzzy variable ‘SpeedDifference’
 0 120 m/s
 ( 
  (N (-120 1) (0 0))
  (Zero (0 0) (0 1) (1 120))
  (P (0 0) (120 1))
 )
)

(deftemplate OriDif ;definition of fuzzy variable ‘Orientation’ 
0 180 degree
 ( 
  (Zero (0 1) (0 1))
  (P (1 0) (1 1) (0 90))
  (N (1 0) (180 1))
 )
)

(deftemplate actSpeed ;definition of fuzzy variable ‘act’ 
 ( 
  (DecSpeed (-120 1) (0 0))
  (Firing (0 0) (0 1) (1 120))
  (IncSpeed (0 0) (120 1))
 )
)

(deftemplate actOri ;definition of fuzzy variable ‘act’ 
 ( 
  (DecOri (0 1) (90 0))
  (Firing (90 0) (90 1) (180 0))
  (IncOri (90 0) (180 1))
 )
)


;; FAM rule definition
(defrule one
 (SpeedDif Zero)
 (OriDif Zero)
 =>
 (assert (ActSpeed  Firing)))
 (assert (ActOri  Firing)))

(defrule two
 (SpeedDif P)
 (OriDif Zero)
 =>
 (assert (ActSpeed  DecSpeed)))

(defrule three
 (SpeedDif Zero)
 (OriDif P)
 =>
 (assert (ActOri  DecOri)))

(defrule Four
 (SpeedDif P)
 (OriDif P)
 =>
 (assert (ActSpeed  DecSpeed)))
 (assert (ActOri  DecOri)))

(defrule five
 (SpeedDif N)
 (OriDif Zero)
 =>
 (assert (ActSpeed  IncSpeed)))

(defrule Six
 (SpeedDif Zero)
 (OriDif N)
 =>
 (assert (ActOri  IncOri)))

(defrule Seven
 (SpeedDif N)
 (OriDif N)
 =>
 (assert (ActSpeed  IncSpeed)))
 (assert (ActOri  IncOri)))
