;;; editor/format/config.el -*- lexical-binding: t; -*-

(defvar +format-on-save-enabled-modes
  '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
        sql-mode)        ; sqlformat is currently broken
  "A list of major modes in which to enable `format-all-mode'.

This mode will auto-format buffers when you save them.

If this list begins with `not', then it negates the list.
If it is `t', it is enabled in all modes.
If nil, it is disabled in all modes, the same as if the +onsave flag wasn't
  used at all.")


;;
;; Bootstrap

(defun +format|enable-on-save-maybe ()
  "Enable formatting on save in certain major modes.

This is controlled by `+format-on-save-enabled-modes'."
  (unless (or (eq major-mode 'fundamental-mode)
              (cond ((booleanp +format-on-save-enabled-modes)
                     (null +format-on-save-enabled-modes))
                    ((eq (car +format-on-save-enabled-modes) 'not)
                     (memq major-mode (cdr +format-on-save-enabled-modes)))
                    ((not (memq major-mode +format-on-save-enabled-modes))))
              (not (require 'format-all nil t))
              (equal (format-all-probe) (list nil nil)))
    (add-hook 'before-save-hook #'+format|buffer nil t)))

(when (featurep! +onsave)
  (add-hook 'after-change-major-mode-hook #'+format|enable-on-save-maybe))