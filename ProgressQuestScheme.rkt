#lang racket/gui
(require "quests.rkt")


;; TODO:
;; Quests funktionaler machen -- Dauer/Rest
;; Dokumentation
;; Score zufällig verteilen

(define current-quest #f)
(define current-gauge #f)
(define current-score 0)

(define app (new frame%
                 [label "Progress Quest"]
                 [width 640]
                 [height 480]))

(define score-panel (new horizontal-panel% [parent app] [stretchable-height #f]))
(define score-label (new message% [parent score-panel] [label "Score: 0"]))
(define main-panel (new vertical-panel% [parent app] [style '(vscroll)]))

(define (do-quest-progress)
  (define max-value (send current-gauge get-range))
  (define current-value (send current-gauge get-value))
  (if (< current-value max-value)
      (send current-gauge set-value (+ current-value 1))
      (begin
        (raise-score (quest-points current-quest))
        (add-quest main-panel))))

(define (raise-score p)
  (set! current-score (+ current-score p))
  (send score-label set-label (format "Score:~a" current-score)))

(define (add-quest p)
  (set! current-quest (fetch-quest))
  (define quest-pane (new vertical-pane%
       [parent p]
       [stretchable-height #f]))
  (new message%
       [parent quest-pane]
       [label (quest-title current-quest)])
  (set! current-gauge (new gauge%
       [parent quest-pane]
       [label #f]
       [range (quest-points current-quest)])))

(add-quest main-panel)
(define current-timer (new timer% [interval 200] [notify-callback do-quest-progress]))
                           

(send app show #t)