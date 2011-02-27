(defun error (s) ((php error) s))
(defun macroexpand (s) ((php macroexpand) s))
(defun macroexpand-1 (s) ((php macroexpand1) s))
(defun rplaca (x a) (setf (car x) a))
(defun rplacd (x a) (setf (cdr x) a))
(defun length (s) ((php length) s))
(defun null (s) ((php is_null) s))
(defun not (s) ((php is_null) s))
(defun make-symbol (s) ((php gensym) s))
(defun gensym () ((php gensym)))
(defun intern (s) ((php intern) s))
(defun unintern (s) ((php unintern) s))
(defun stringp (s) ((php is_string) s))
(defun symbolp (s) ((php symbolp) s))
(defun consp (s) ((php consp) s))
(defun atomp (s) (not ((php consp) s)))
(defun print (s) ((php lisp_print) s))
(defun parse (s) ((php parse) s) t)
(defun eval (s) ((php lisp_eval) s))
(defun list arg arg)
(defun cons (a b) ((php cons) a b))
(defun caar (s) ((php caar) s))
(defun cadr (s) ((php cadr) s))
(defun cddr (s) ((php cddr) s))
(defun cdar (s) (cdr ((php car) s)))
(defun caaar (s) (car ((php caar) s)))
(defun caadr (s) (car ((php cadr) s)))
(defun cadar (s) (car ((php cdar) s)))
(defun cdaar (s) (cdr ((php caar) s)))
(defun caddr (s) ((php caddr) s))
(defun cdadr (s) (cdr ((php cadr) s)))
(defun cddar (s) (cdr ((php cdar) s)))
(defun cdddr (s) ((php cdddr) s))
(defun load (s) ((php lisp_load) s))
(defun compile-file (in out) ((php compile_file) in out))
(defun cond->if form
  (if form
    (if (consp (car form))
       `(if ,(caar form) (progn ,@(cdar form)) ,(apply #'cond->if (cdr form)))
       (let ((one (gensym)))
         `(let ((,one ,(caar form)))
            (if ,one ,one ,(apply #'cond->if (cdr form))))))
    'nil))
(defmacro cond form
  (apply #'cond->if form))
