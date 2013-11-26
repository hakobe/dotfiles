(setq-default evil-auto-indent t
              evil-shift-with 4
              evil-cross-lines nil
              evil-echo-state nil
              evil-want-C-i-jump nil
              evil-want-fine-undo t
              evil-search-module 'evil-search
              evil-ex-search-vim-style-regexp t)

;; fix evil.rcp
(add-to-list 'el-get-sources '(:name evil :build (("make" "all")) :info nil))

(add-to-list 'el-get-sources
    '(:name tarao-elisp
           :type github
           :pkgname "tarao/elisp"
           :description "tarao's great elisps" ))

(add-to-list 'el-get-sources
    '(:name tarao-evil-plugins
           :type github
           :pkgname "tarao/evil-plugins"
           :description "tarao's great evil plugins"
           :depends (tarao-elisp evil) ))

(el-get 'sync '(evil evil-leader tarao-elisp tarao-evil-plugins))

(global-evil-leader-mode)
(require 'evil)
(evil-mode 1)

(evil-leader/set-leader ",")
(evil-leader/set-key
  "w" 'save-buffer
)

;; keys
(defun evil-swap-key (map key1 key2)
  "Swap KEY1 and KEY2 in MAP."
  (let ((def1 (lookup-key map key1))
        (def2 (lookup-key map key2)))
    (define-key map key1 def2)
    (define-key map key2 def1)))

;; move cursor visually by default
(evil-swap-key evil-motion-state-map "j" "gj")
(evil-swap-key evil-motion-state-map "k" "gk")

;; plugins

(require 'evil-mode-line)
