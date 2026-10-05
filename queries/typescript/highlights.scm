; extends

; Type slots win over semantic tokens (LSP priority 125-127), so a class
; used as a type reads as a type. Declaration names are left alone.
(type_arguments (type_identifier) @type.reference (#set! priority 130))
(type_annotation (type_identifier) @type.reference (#set! priority 130))
(union_type (type_identifier) @type.reference (#set! priority 130))
(intersection_type (type_identifier) @type.reference (#set! priority 130))
(array_type (type_identifier) @type.reference (#set! priority 130))

; Effect.gen opens a program scope: paint the callee with EffectGen.
; Structural match, so the words "Effect.gen" in comments or strings stay put.
(call_expression
  function: (member_expression
    object: (identifier) @_obj
    property: (property_identifier) @_prop) @effect.gen
  (#eq? @_obj "Effect")
  (#eq? @_prop "gen")
  (#set! priority 130))
