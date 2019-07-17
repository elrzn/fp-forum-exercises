(defparameter *table* (make-hash-table :test #'equal))

(defun make-key (word)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type string word))
  (sort (string-downcase word) #'char-lessp))

(defun add-word (word)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type string word))
  (let* ((key (make-key word))
         (curr-value (gethash key *table*)))
    (setf (gethash key *table*) (cons word curr-value))))

(defun load-words (filename)
  (declare (optimize (speed 3) (safety 0)))
  (declare (type string filename))
  (with-open-file (stream filename :external-format :latin1)
    (loop for line = (read-line stream nil 'eof)
          until (eq line 'eof)
          do (add-word line))))

(defun compute-table ()
  (declare (optimize (speed 3) (safety 0)))
  (let ((cnt 0))
    (declare (type fixnum cnt))
    (loop for value being the hash-values of *table*
          when (> (list-length value) 1)
            do (progn
                 (format t "~{~a ~}~%" value)
                 (incf cnt)))
    (princ cnt)
    cnt))

(load-words "./wordlist.txt")
(compute-table)
