#lang racket
(provide fetch-quest (struct-out quest))

(struct quest (title points duration))


(define quest-adjectives (list "Golden" "Silver" "Fabled" "Magical" "Enchanted" "Lost" "Holy"))
(define quest-objects (list "Grail" "Banana" "Pineapple" "Sword" "Mace" "Pants"))
(define quest-places (list "the Virgins" "Thor" "Loki" "R'Lyeh" "the Heavens" "the Ocean" "the King"))

(define (pick-random l)
  (first (shuffle l)))

(define (build-title)
  (string-append "Fetch the " (pick-random quest-adjectives) " " (pick-random quest-objects) " of " (pick-random quest-places)))

(define (fetch-quest)
  (quest (build-title) 100 30))
