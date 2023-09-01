(load (parse-namestring (concatenate 'string (sb-ext:posix-getenv "ROS_ROOT") "lisp/scripts/roslisp-sbcl-init")))
(asdf:load-system :cram-projection-demos)
(quit)
