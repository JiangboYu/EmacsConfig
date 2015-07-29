;;; Jiangbo Yu yjb7049@gmail.com
;;;

;;(setq sml/shorten-directory t)
;;(setq sml/shorten-modes t)
;;(setq sml/name-width 40)
;;(setq sml/mode-width 20)
(setq path-to-ctags "/usr/bin/ctags")
(defun create-tags (dir-name)
    "Create tags file."
    (interactive "DDirectory: ")
    (shell-command
     (format "ctags -f %s -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(package-initialize)
(require 'ido)
(ido-mode t)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-X") 'smex)
(global-set-key (kbd "C-c M-x") 'smex-update)
(require 'env-var-import)
(env-var-import)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
;;;setting for go lang
(defun go-mode-setup()
  (setq compile-command "go build -v && go test -v && go vet && hello")
  (custom-set-variables
   '(go-command "/usr/local/go/bin/go"))
  (define-key (current-local-map) "C-c C-c" 'compile)
  (go-eldoc-setup)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump)
  )


(add-hook 'go-mode-hook 'go-mode-setup)


;;general setting
(setq transient-mark-mode t)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
;;
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'light)
;(set-frame-parameter nil 'background-mode 'dark)

(enable-theme 'solarized)

(add-to-list 'custom-theme-load-path "~/.emacs.d/moe-theme.el/")
(add-to-list 'load-path "~/.emacs.d/lisp/")
;;(load-theme 'hickey t)
(require 'tramp)
(setq tramp-default-method "ssh")
;(load-theme 'solarized-dark t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;windows manipulation
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(setq column-number-mode t)
;; Window manipulation
;;(global-set-key [(control kp-6)] 'enlarge-window-horizontally)
;;(global-set-key [(control kp-4)] 'shrink-window-horizontally)
;;(global-set-key [(control kp-8)] 'enlarge-window)
;;(global-set-key [(control kp-2)] 'shrink-window)
;; map the window manipulation keys to meta 0, 1, 2, o
(global-set-key (kbd "M-3") 'split-window-horizontally);
(global-set-key (kbd "M-2") 'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-0") 'delete-window) ; was digit-argument
(global-set-key (kbd "M-o") 'other-window) ; was facemenu-keymap
;;(global-set-key (kbd "C-f") 'find-file)
(global-set-key (kbd "M-s") 'toggle-eshell-visor);
(require 'package)
;;(set-face-attribute 'mode-line nil
;;                     :foreground "Black"
;;                     :background "DarkOrange"
;;                     :box)
;;;(require 'powerline)
;;;(setq sml/theme 'powerline)
;;;(powerline-default-theme)
;;(load "smart-mode-line-powerline-theme")
;;(setq powerline-arrow-shape 'curve)
;;(setq powerline-default-separator-dir '(right .left))

;;(setq package-enable-at-startup)
;(setq sml/no-confirm-load-theme t)
;;(sml/setup)
;(powerline-moe-theme)
;;(powerline-moe-theme)

;;(require 'moe-theme)
;;(setq moe-theme-highlight-buffer-id t)
;;(setq moe-theme-resize-markdown-title '(1.5 1.4 1.3 1.2 1.0 1.0))
;;(setq moe-theme-resize-org-title '(1.5 1.4 1.3 1.2 1.1 1.0 1.0 1.0 1.0))
;;(setq moe-theme-resize-rst-title '(1.5 1.4 1.3 1.2 1.1 1.0))
(powerline-default-theme)
(autoload 'octave-mode "octave-mod" nil t)
;;(moe-theme-set-color 'cyan)
;;(moe-dark)

(require 'autopair)
(autopair-global-mode)
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  )
  ;;(add-to-list 'ac-head::include-directories '":/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/6.0/include")
  ;;)
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;;fix iedit bug in mac
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;; start flymake-google-cpplint-load
;;(defun my:flymake-google-init ()
;;  (require 'flymake-google-cpplint)
;;  (customize-set-variable
;;   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
;;  (flymake-google-cpplint-load)
;;  )
;;(add-hook 'c-mode-hook 'my:flymake-google-init)
;;(add-hook 'c++-mode-hook 'my:flymake-google-init)

;(require 'google-c-style)
;(add-hook 'c-mode-common-hook 'google-set-c-style)
;;(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;(semantic-mode 1)
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;;(setq auto-mode-alist
;;      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(menu-bar-mode -1)
(global-set-key (kbd "C-x g") 'magit-status)

;;(setq desktop-restore-frames nil)
;;(require 'cc-mode)
;;(setq-default c-basic-offset 4 c-default-style "linux")
;;(setq-default tab-width 4 indent-tabs-mode t)
;;(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
;; turn on save place so that when opening a file, the cursor will be at the last position.
;; Semantic
;(global-semantic-idle-completions-mode t)
;(global-semantic-decoration-mode t)
;(global-semantic-highlight-func-mode t)
;(global-semantic-show-unmatched-syntax-mode t)

;; CC-mode

;; (add-hook 'c-mode-hook '(lambda ()
;;         (setq ac-sources (append '(ac-source-semantic) ac-sources))
;;         (local-set-key (kbd "RET") 'newline-and-indent)
;;         (linum-mode t)
;;         (semantic-mode t)))
;(global-linum-mode 1)
(require 'saveplace)
(setq-default save-place t)
;;start auto-complete with emacs
(require 'auto-complete)
;;do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)
(require 'yasnippet)
(yas-global-mode 1)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "d7088a7105aa09cc68e3d058f89917e07e0505e0f4ab522a6045ec8092d67c44" "87bee8dd980504d41c043e83c24abbbdb780ce5afb9c312f6915ed0aad2630ee" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "7bde52fdac7ac54d00f3d4c559f2f7aa899311655e7eb20ec5491f3b5c533fe8" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "25e803c02e139e480508c9f7545c6062a0ff861ce11f31b71fa1217154cf6009" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" default)))
 '(sml/mode-width
   (if
       (eq powerline-default-separator
	   (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s" powerline-default-separator
			    (car powerline-default-separator-dir)))
		   (quote powerline-active1)
		   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s" powerline-default-separator
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active1)
		   nil)))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s" powerline-default-separator
			    (car powerline-default-separator-dir)))
		   nil
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
		  (quote display)
		  (funcall
		   (intern
		    (format "powerline-%s-%s" powerline-default-separator
			    (cdr powerline-default-separator-dir)))
		   (quote powerline-active2)
		   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
