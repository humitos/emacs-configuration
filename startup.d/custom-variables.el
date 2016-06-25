(custom-set-variables
 '(safe-local-variable-values
   (quote
    (
     (eval pyvenv-workon
	   (quote emacs-default))
     (eval pyvenv-workon
	   (quote mozio))
     (eval pyvenv-workon
	   (quote mozio-commons))
     (eval pyvenv-workon
	   (quote mozio-ondemand))
     (eval pyvenv-workon
	   (quote mozio-data-entry))
     (py-docformatter-options "--wrap-summaries=80" "--wrap-descriptions=80" "--pre-summary-newline" "--no-blank")
     (py-docformatter-options "--wrap-summaries=120 --wrap-descriptions=120 --pre-summary-newline --no-blank")
     (py-docformatter-options "--wrap-summaries=120" "--wrap-descriptions=120" "--pre-summary-newline" "--no-blank")
     (py-autopep8-options "--global-config=/home/humitos/.autopep8rc")
     (py-autopep8-options "--global-config=/home/humitos/mozio/autopep8rc")
     (elpy-test-django-runner-command "/home/humitos/mozio/mozio/manage.py" "test" "--noinput" "--keepdb" "--failfast")
     (elpy-test-django-runner-command "/home/humitos/mozio/ondemand/manage.py" "test" "--noinput" "--keepdb" "--failfast")
     (elpy-test-django-runner-command "/home/humitos/mozio/data-entry/manage.py" "test" "--noinput" "--keepdb" "--failfast")
     ))))
