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
  (count 1 neighbours))

(defun resurrect? (neighbours)
  (or (= (count-alive-neighbours neighbours) 2)
      (= (count-alive-neighbours neighbours) 3)))

(defun iterate (world)
  (let ((w (car (get-size world))) (h (cdr (get-size world))))
    (loop for x from 0 to w do
          (loop for y from 0 to h do
                (if (resurrect? (get-cell-neighbours world x y))
                  (set-cell world x y 2)))))
  world)

(defvar *w* (create-world 5 5))
*w*
(set-cell *w* 3 2 1)
(iterate *w*)


