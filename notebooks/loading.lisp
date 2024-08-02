(defun loading (message)
    (jupyter:clear :wait)(jupyter:markdown (format nil "# ![](./loading.gif) ~a " message))
)