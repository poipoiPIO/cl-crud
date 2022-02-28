(in-package :cl-user)
(defpackage crud.db
  (:use :cl
        :crud.models
        :mito)
  (:export :note 
           :remove-note
           :add-note
           :get-all
           :find-note
           :update-note-text))
(in-package :crud.db)

(mito:connect-toplevel :sqlite3 :database-name "db.sqlite")
(mito:ensure-table-exists 'crud.models:note) ;if table doesn't exist make it

(defun add-note (creator-name note-text)
  (let 
    ((object (make-instance 'crud.models:note :creator-name creator-name :note-text note-text)))
    (mito:insert-dao object)))

(defun remove-note (note-id)
  (mito:delete-by-values 'crud.models:note :id note-id))

(defun get-all ()
  (mito:retrieve-dao 'note))

(defun find-note (note-id)
  (mito:find-dao 'crud.models:note :id note-id))

(defun update-note-text (note-id updated-text)
  (let ((res (find-note note-id)))
  (setf (slot-value res 'CRUD.MODELS::note-text) updated-text) 
  (mito:save-dao res)))
