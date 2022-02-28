(in-package :cl-user)
(defpackage crud.models
  (:use :cl
        :mito)
  (:export :note))
(in-package :crud.models)

(mito:deftable note ()
  ((creator-name :col-type (or (:varchar 256) :null)
                 :accessor creator-name)
   (note-text    :col-type :text
                 :accessor text)))

