;; Fuzzy Set definition
(deftemplate SpeedDifference ;definition of fuzzy variable ‘SpeedDifference’ 0 120 m/s
 ( 
  (Zero (0 1) (60 0))
  (low (60 0) (60 1) (120 0))
  (high (60 0) (120 1))
 )
)

(deftemplate OrientationDifference ;definition of fuzzy variable ‘Orientation’ 0 180 degree
 ( 
  (Zero (0 1) (90 0))
  (low (90 0) (90 1) (120 0))
  (high (90 0) (120 1))
 )
)

;; get crisp inputs
(defrule Get_Observations
 ?i <- (initial-fact)
 =>
 (printout t "Enter angle: ")
 (bind ?response (read))
 (assert (crispAngle ?response))
 (printout t "Enter angle delta: ")
 (bind ?response (read))
 (assert (crispDAngle ?response))
 (retract ?i))

;; fuzzify the inputs
(defrule fuzzify
 (crispAngle ?a)
 (crispDAngle ?d)
 =>
 (assert (Angle (?a 0) (?a 1) (?a 0)))
 (assert (DAngle (?d 0) (?d 1) (?d 0)))
)
;; defuzzify the outputs
(defrule defuzzify1
 (declare (salience -1))
 ?f <- (Act ?)
 =>
 (bind ?t (moment-defuzzify ?f))
 (printout t "action--> " ?t crlf))



;; FAM rule definition
(defrule one
 (Angle Pos)
 (DAngle Pos)
 =>
 (assert (Act BP)))

(defrule two
 (Angle Pos)
 (DAngle Zer)
 =>
 (assert (Act P)))

(defrule three
 (Angle Pos)
 (DAngle Neg)
 =>
 (assert (Act Z)))

(defrule Four
 (Angle Zer)
 (DAngle Pos)
 =>
 (assert (Act P)))

(defrule five
 (Angle Zer)
 (DAngle Zer)
 =>
 (assert (Act Z)))

(defrule Six
 (Angle Zer)
 (DAngle Neg)
 =>
 (assert (Act N)))
(defrule NP
 (Angle Neg)
 (DAngle Pos)
 =>
 (assert (Act Z)))

(defrule Seven
 (Angle Neg)
 (DAngle Zer)
 =>
 (assert (Act N)))

(defrule Eight
 (Angle Neg)
 (DAngle Neg)
 =>
 (assert (Act BN)))



(deffacts fuzzy-fact
(age young) ; a fuzzy fact
)

(defrule one ; a rule that matches and asserts fuzzy facts
(Speed_error big)
=>
(assert (Throttle_change small))
) 