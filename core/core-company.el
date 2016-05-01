;;; core-company.el

(use-package company
  :init
  (setq company-idle-delay nil
        company-minimum-prefix-length 2
        company-tooltip-limit 10
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil
        company-dabbrev-code-other-buffers t
        company-tooltip-align-annotations t
        company-require-match 'never
        company-global-modes '(not eshell-mode comint-mode erc-mode message-mode help-mode)
        company-frontends '(company-pseudo-tooltip-frontend company-echo-metadata-frontend)
        company-backends '((company-capf company-keywords))

        company-quickhelp-delay nil
        company-statistics-file (concat narf-temp-dir "/company-stats-cache.el"))

  :config
  ;; Rewrites evil-complete to use company-dabbrev
  (setq evil-complete-next-func     'narf/company-evil-complete-next
        evil-complete-previous-func 'narf/company-evil-complete-previous)
  (push 'company-sort-by-occurrence company-transformers)

  (define-key company-active-map "\C-w" nil)

  (global-company-mode +1))

(use-package company-dabbrev :commands company-dabbrev)

(use-package company-dabbrev-code :commands company-dabbrev-code)

(use-package company-quickhelp
  :after company
  :config (company-quickhelp-mode +1))

(use-package company-statistics
  :after company
  :config (company-statistics-mode +1))

(use-package company-files
  :commands company-files)

(use-package company-dict
  :commands company-dict
  :config (setq company-dict-dir (concat narf-private-dir "/dict")))

(use-package company-template
  :after ac-php-company)

(provide 'core-company)
;;; core-company.el ends here
