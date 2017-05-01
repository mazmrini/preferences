;; custom methods
(defun prev-line-new-line-indent ()
  (previous-line)
  (end-of-line)
  (newline-and-indent)
  )

(defun auto-curly-indent ()
  (insert-char '125)
  (backward-char)
  (newline-and-indent)
  (prev-line-new-line-indent)
  )


;; packages
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'auto-complete)
(global-auto-complete-mode t)

(elpy-enable)
(setq elpy-rpc-backend "jedi")
;;(elpy-use-ipython "ipython")
(elpy-use-ipython "ipython3")


(add-to-list 'load-path "~/.emacs.d/elpa/neotree")
(require 'neotree)
(setq neo-smart-open t)
(global-set-key (kbd "C-x RET") 'neotree-toggle)


;; theme and look
(load-theme 'ample-flat t)
(enable-theme 'ample-flat)

(set-default-font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 136)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq frame-title-format "Emacs")
(show-paren-mode)
(set-default 'cursor-type 'bar)
(global-hl-line-mode)
(global-linum-mode t)
(global-visual-line-mode t)

(custom-set-variables '(initial-frame-alist (quote ((fullscreen . maximized)))))



;; backup files
(setq make-backup-files nil)
(setq auto-save-default nil)



;; key bindings
(global-unset-key "\C-k")
(global-set-key (kbd "C-k C-a") '(lambda() (interactive) (kill-line 0)) )
(global-set-key (kbd "C-k C-e") '(lambda() (interactive) (kill-line)) )
(global-set-key (kbd "C-k C-k") '(lambda() (interactive) (kill-whole-line)) )
(global-set-key (kbd "C-j") '(lambda() (interactive) (newline-and-indent)) )
(global-set-key (kbd "M-j") '(lambda() (interactive) (auto-curly-indent)))

;; programming
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(delete-selection-mode 1)


;; C++ and C
(setq-default c-default-style "stroustrup")
(setq-default c-basic-offset 4)
;;(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))
;;(add-hook 'c-mode-common-hook '(lambda () (c-toggle-hungry-state 1)))



;; irony
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; behavior
(setq confirm-kill-emacs 'y-or-n-p)
