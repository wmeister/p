(defun rplaca (x a) (setf (car x) a))
(defun rplacd (x a) (setf (cdr x) a))
(setf #'error #'(php error))
(setf #'macroexpand #'(php macroexpand))
(setf #'macroexpand-1 #'(php macroexpand1))
(setf #'length #'(php length))
(setf #'null #'(php lisp_null))
(setf #'not #'(php lisp_null))
(setf #'make-symbol #'(php gensym))
(setf #'gensym #'(php gensym))
(setf #'intern #'(php intern))
(setf #'unintern #'(php unintern))
(setf #'stringp #'(php lisp_stringp))
(setf #'arrayp #'(php lisp_arrayp))
(setf #'symbolp #'(php lisp_symbolp))
(setf #'consp #'(php lisp_consp))
;(defun atomp (s) (not (or (funcall (php consp) s) (funcall (php is_array) s))))
(setf #'print #'(php lisp_print))
(defun parse (s) (funcall (php parse) s) t)
(setf #'eval #'(php lisp_eval))
(defun list arg arg)
(setf #'cons #'(php cons))
(setf #'caar #'(php caar))
(setf #'cadr #'(php cadr))
(setf #'cddr #'(php cddr))
(defun cdar (s) (cdr (funcall (php car) s)))
(defun caaar (s) (car (funcall (php caar) s)))
(defun caadr (s) (car (funcall (php cadr) s)))
(defun cadar (s) (car (funcall (php cdar) s)))
(defun cdaar (s) (cdr (funcall (php caar) s)))
(setf #'caddr #'(php caddr))
(defun cdadr (s) (cdr (funcall (php cadr) s)))
(defun cddar (s) (cdr (funcall (php cdar) s)))
(defun cdddr (s) (funcall (php cdddr) s))
(defun load (s) (funcall (php lisp_load) s))
(setf #'compile-file #'(php compile_file))
(defun code-char (c)
  (if (< c 128)
    (funcall (php chr) c)
    (funcall (php mb_convert_encoding) (funcall (php pack) "N" c) "UTF-8" "UCS-4BE")))
(defun char-code (s)
  (funcall (php unpack) "N" (funcall (php mb_convert_encoding) s "UCS-4BE" "UTF-8")))
(setf #'quit #'(php exit))
(setf #'load #'(php lisp_load))
(setf #'numberp #'(php is_numeric))
(defun 1+ (n) (+ 1 n))
(defun 1- (n) (- n 1))
(defmacro when (expression . body) `(if ,expression (progn ,@body)))
(defmacro cond clauses
  (if (= (length clauses) 1)
      (if (eq (caar clauses) t)
          `(progn ,@(cdar clauses))
        `(when ,(caar clauses)
            ,@(cdar clauses)))
    `(if ,(caar clauses)
         (progn ,@(cdar clauses))
       (cond ,@(cdr clauses)))))
(defmacro dolist ((var listform . resultform) . body)
  `(progn
     (funcall #'(php dolist) (lambda (,var) ,@body) ,listform)
     ,@resultform))
(defmacro dotimes ((var count . resultform) . body)
  `(progn
     (funcall #'(php dotimes) (lambda (,var) ,@body) ,count)
     ,@resultform))
(defun count (what seq)
  (let ((n 0))
    (dolist (x seq n)
      (if (eq x what) (setf n (1+ n))))))
