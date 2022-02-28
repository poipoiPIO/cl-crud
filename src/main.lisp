(defpackage crud
  (:use :cl
        :crud.routes
        :log4cl
        :clack)
  (:export :main))
(in-package :crud)

(defun main (port)
  (progn (clack:clackup crud.routes:*app* 
                 :port port)
  (log:info "Server is started on port: " port)))
