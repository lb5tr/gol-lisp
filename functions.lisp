;basic functions for game-of-life
;written on the knee, need some work
(in-package :gol)

(defun create-world (x y)
  (make-array (list x y)))

(defmacro get-cell (world x y)
  `(aref ,world ,y ,x))

(defun set-cell (world x y val)
  (setf (get-cell world x y) val)
  world)

(defun get-size (world)
  (cons (array-dimension world 1) (array-dimension world 0)))

(defun check-limits (world x y)
  (let ((size (get-size world)))
    (and (> x -1) (> y -1) (< x (car size)) (< y (cdr size)))))

(defun cell-alive? (world x y)
  (= (get-cell world x y) 1))

(defun get-offset-table (x y)
  (mapcar 
    (lambda (p) 
      (cons (+ (car p) x)
            (+ (cdr p) y)))
    '((0 . 1) (1 . 0) (1 . 1) (-1 . 0) (-1 . -1) (0 . -1) (1 . -1) (-1 . 1))))

(defun get-cell-neighbours (world x y)
  (loop for offset in (get-offset-table x y)
        when (check-limits world (car offset) (cdr offset))
        collect (get-cell world (car offset) (cdr offset)))) 

(defun count-alive-neighbours (neighbours)
  (+  (count 1 neighbours) (count 3 neighbours)))

(defun resurrect? (world x y)
  (and 
    (= (count-alive-neighbours (get-cell-neighbours world x y)) 3)
    (not (cell-alive? world x y))))

(defun kill? (world x y)
  (let ((nc (count-alive-neighbours (get-cell-neighbours world x y))))
    (and 
      (or (< nc 2) (> nc 3))
      (cell-alive? world x y))))

(defun generate (world)
  (let ((w (- (car (get-size world)) 1)) (h (- (cdr (get-size world)) 1)))
    (loop for x from 0 to w do
          (loop for y from 0 to h do
                (cond
                  ((resurrect? world x y) (set-cell world x y 2))
                  ((kill? world x y) (set-cell world x y 3)))))
  world))

(defun apply-generation (world)
  (let ((w (- (car (get-size world)) 1)) (h (- (cdr (get-size world)) 1)))
    (loop for x from 0 to w do
          (loop for y from 0 to h do
                (cond
                  ((= (get-cell world x y) 2) (set-cell world x y 1))
                  ((= (get-cell world x y) 3) (set-cell world x y 0)))))
  world))

