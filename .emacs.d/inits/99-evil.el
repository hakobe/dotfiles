(setq-default evil-auto-indent t
              evil-shift-width 2
              evil-cross-lines nil
              evil-echo-state nil
              evil-want-C-i-jump nil
              evil-want-fine-undo t
              evil-want-C-w-in-emacs-state t
              evil-search-module 'evil-search
              evil-ex-search-vim-style-regexp t)

(el-get-bundle! evil
  (evil-mode 1)
  ;; keys
  (defun evil-swap-key (map key1 key2)
    "Swap KEY1 and KEY2 in MAP."
    (let ((def1 (lookup-key map key1))
          (def2 (lookup-key map key2)))
      (define-key map key1 def2)
      (define-key map key2 def1)))

  ;; move cursor visually by default
  (evil-swap-key evil-motion-state-map "j" "gj")
  (evil-swap-key evil-motion-state-map "k" "gk"))

(el-get-bundle evil-leader
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "w" #'save-buffer)
  (global-evil-leader-mode))

(el-get-bundle evil-jumper
  (global-evil-jumper-mode))

(el-get-bundle tarao/elisp)

(el-get-bundle tarao/evil-plugins
  :features (evil-mode-line evil-little-word evil-operator-comment evil-operator-moccur)
  :depends (color-moccur))

(el-get-bundle bling/evil-visualstar
  (global-evil-visualstar-mode t))

(el-get-bundle evil
  ;; helm
  (with-eval-after-load-feature (helm evil-leader)
    (evil-leader/set-key
      ";" #'helm-mini
      "r" #'helm-git-project
      "f" #'helm-find-files
      "o" #'helm-occur
      "q" #'helm-ghq
      "p" #'helm-show-kill-ring
      "x" #'helm-M-x)
    )

  ;; go
  (with-eval-after-load-feature (go-mode)

    (evil-define-key 'insert go-mode-map
      (kbd "C-]") #'godef-jump)

    (evil-define-key 'normal go-mode-map
      (kbd "C-]") #'godef-jump)

    )

  ;; scala

  (add-to-list 'evil-insert-state-modes 'sbt-mode)

  (with-eval-after-load-feature 'scala-mode2
    (defun tarao/scala-join-line ()
      "Adapt `scala-indent:join-line' to behave more like evil's
  line join. `scala-indent:join-line' acts like the vanilla
  `join-line', joining the current line with the previous
  one. The vimmy way is to join the current line with the next.
  Try to move to the subsequent line and then join. Then manually
  move point to the position of the join."
      (interactive)
      (let (join-pos)
        (save-excursion
          (goto-char (line-end-position))
          (unless (eobp)
            (forward-line)
            (call-interactively #'scala-indent:join-line)
            (setq join-pos (point))))
        (when join-pos
          (goto-char join-pos))))
    (evil-define-key 'normal scala-mode-map (kbd "C-j") #'tarao/scala-join-line)
    )

  (defmacro with-ensime-inf-switch (&rest form)
    `(progn
       ,@form
       (ensime-inf-switch)
       (evil-insert-state)))

  (defmacro with-sbt-switch (&rest form)
    (eval-and-compile
      (require 'sbt-mode)
      (defvar sbt:submode))
    `(scala/with-project-sbt
      (let ((buf (sbt:buffer-name))
            (display-buffer-fallback-action '(display-buffer-same-window)))
        (unless (comint-check-proc buf) (sbt-start))
        (let ((submode (buffer-local-value 'sbt:submode (get-buffer buf))))
          (unless (or (eq submode 'console)
                      (eq submode 'paste-mode))
            (sbt-command "console")
            (with-current-buffer buf
              (setq sbt:submode 'console))))
        ,@form
        (switch-to-buffer buf)
        (evil-insert-state))))

  (with-eval-after-load-feature (ensime evil-leader)
    (evil-define-key 'insert ensime-mode-map
      (kbd ".") #'scala/completing-dot
      (kbd "C-]") #'ensime-edit-definition
      (kbd "C-t") #'ensime-pop-find-definition-stack)

    (evil-define-key 'normal ensime-mode-map
      (kbd "C-]") #'ensime-edit-definition
      (kbd "C-t") #'ensime-pop-find-definition-stack)

    (evil-make-overriding-map ensime-popup-buffer-map 'normal)

    (evil-define-key 'normal ensime-inspector-mode-map
      (kbd "q") #'ensime-popup-buffer-quit-function)

    (evil-make-overriding-map ensime-refactor-info-map 'normal)
    (evil-define-key 'normal ensime-refactor-info-map
      (kbd "RET") (lookup-key ensime-refactor-info-map (kbd "c")))

    (evil-make-overriding-map ensime-compile-result-map 'normal)
    (evil-define-key 'normal ensime-compile-result-map
      (kbd "n") #'forward-button
      (kbd "N") #'backward-button)

    (evil-make-overriding-map sbt:mode-map 'insert)
    (evil-define-key 'insert sbt:mode-map
      (kbd "C-p") #'comint-previous-input
      (kbd "C-n") #'comint-next-input
      (kbd "C-u") #'comint-kill-input)

    (defun ensime-inf-eval-buffer-switch ()
      "Send buffer content to shell and switch to it in insert mode."
      (interactive)
      (with-ensime-inf-switch (ensime-inf-eval-buffer)))

    (evil-define-operator ensime-inf-eval-region-switch (beg end)
      "Send region content to shell and switch to it in insert mode."
      :motion evil-line
      (with-ensime-inf-switch (ensime-inf-eval-region beg end)))

    (defun sbt:send-buffer-switch ()
      "Send buffer content to shell and switch to it in insert mode."
      (interactive)
      (with-sbt-switch (sbt:send-buffer)))

    (evil-define-operator sbt:send-region-switch (beg end)
      "Send region content to shell and switch to it in insert mode."
      :motion evil-line
      (with-sbt-switch (sbt:send-region beg end)))

    (evil-leader/set-key-for-mode 'scala-mode
      "/"  'ensime-search
;      "?"  'ensime-scalex

;      "bc" 'ensime-sbt-do-compile
;      "bC" 'ensime-sbt-do-clean
;      "bi" 'ensime-sbt-switch
;      "bp" 'ensime-sbt-do-package
;      "br" 'ensime-sbt-do-run
;
;      "ct" 'ensime-typecheck-current-file
;      "cT" 'ensime-typecheck-all
;
;      "db" 'ensime-db-set-break
;      "dB" 'ensime-db-clear-break
;      "dC" 'ensime-db-clear-all-breaks
;      "dc" 'ensime-db-continue
;      "dd" 'ensime-db-start
;      "di" 'ensime-db-inspect-value-at-point
;      "dl" 'ensime-db-list-locals
;      "dn" 'ensime-db-next
;      "do" 'ensime-db-step-out
;      "dq" 'ensime-db-quit
;      "dr" 'ensime-db-run
;      "ds" 'ensime-db-step
;      "dt" 'ensime-db-backtrace
;
;      "ee" 'ensime-print-errors-at-point
;      "el" 'ensime-show-all-errors-and-warnings
;      "es" 'ensime-stacktrace-switch
;
;      "gg" 'ensime-edit-definition
;      "gi" 'ensime-goto-impl
;      "gt" 'ensime-goto-test
;
;      "hh" 'ensime-show-doc-for-symbol-at-point
;      "hu" 'ensime-show-uses-of-symbol-at-point
;      "ht" 'ensime-print-type-at-point
;
;      "ii" 'ensime-inspect-type-at-point
;      "iI" 'ensime-inspect-type-at-point-other-frame
;      "ip" 'ensime-inspect-project-package

;      "nF" 'ensime-reload-open-files
;      "ns" 'ensime
;      "nS" 'ensime-gen-and-restart

      "rd" 'ensime-refactor-inline-local
      "rD" 'ensime-undo-peek
      "rf" 'ensime-format-source
      "ri" 'ensime-refactor-organize-imports
      "rm" 'ensime-refactor-extract-method
      "rr" 'ensime-refactor-rename
      "rt" 'ensime-import-type-at-point
      "rv" 'ensime-refactor-extract-local

;      "ta" 'ensime-sbt-do-test
;      "tr" 'ensime-sbt-do-test-quick
;      "tt" 'ensime-sbt-do-test-only
;
;      "sa" 'ensime-inf-load-file
;      "sb" 'ensime-inf-eval-buffer
;      "sB" 'ensime-inf-eval-buffer-switch
;      "si" 'ensime-inf-switch
;      "sr" 'ensime-inf-eval-region
;      "sR" 'ensime-inf-eval-region-switch

      "z"  'ensime-expand-selection-command
      )
    )
  )
