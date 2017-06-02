;;; .emacs-custom.el --- customisations
;; This is your default customistions file.
;; The emacs customize interace will append to this file.

;;; Commentary:
;; Here are some handy functions:
;; (standard-display-ascii ?\t "^I")  ;; show tabs
;; (setq-default indent-tabs-mode nil)   ;; turn off tabs
;;

;;; Code:

(setq custom-theme-directory (locate-user-emacs-file "themes"))
(setq diary-file "/Users/prezoladesigner/Sync/diary")
;; slime common lisp
(setq inferior-lisp-program "sbcl")

(ido-mode t)
(global-flycheck-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook 'py-isort-before-save)
(add-hook 'python-mode-hook '(lambda ()
          (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'sgml-mode-hook '(lambda ()
(define-key
         sgml-mode-map
         (kbd "RET") 'newline-and-indent)))

(define-key netsight-keymap (kbd "<kp-9>") 'magit-status)
(define-key netsight-keymap (kbd "<f15>") 'magit-blame-mode)
(define-key netsight-keymap (kbd "<f16>") 'cheej-ide-mode)
(define-key netsight-keymap (kbd "C-x p") 'netsight-other-window-back)
(define-key netsight-keymap (kbd "M-d") 'kill-word)
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)
(setq diary-european-date-forms t)


(defun cheej-ide-mode ()
  "Set up 2 column layout fullscreen."
  (interactive)
  (split-window-horizontally)
  (toggle-fullscreen))


;; open prezola github
(defun prezola-github ()
  (interactive)
  (call-process "open" nil 0 nil "https://github.com/prezola/prezola")
)

;; search github
(defun github-search (url)
  (interactive "sSearch for: ")
  (call-process "open" nil 0 nil (concat "http://github.com/search?q=" url))
  )

;; open github
(defun open-github (org project)
  "Open a github project page.  ORG - organisation PROJECT - the actual project."
  (interactive "sOrganisation: \nsProject: ")
  (call-process "open" nil 0 nil (concat "http://github.com/" org "/" project))
  )

;; Toggle full screen
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))


;; twitter
(setq twittering-use-master-password t)

;;; tide setup
;;; https://github.com/ananthakumaran/tide/blob/master/README.md
(require 'tide)

(defun setup-tide-mode ()
  "Set up tide mode."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1))

(add-hook 'typescript-mode-hook #'setup-tide-mode)
;;; end tide setup

;;; intero (haskell) mode
(add-hook 'haskell-mode-hook 'intero-mode)

;;; .emacs-custom.el ends here
