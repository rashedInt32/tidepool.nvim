; extends

; Type slots win over semantic tokens (LSP priority 125-127), so a class
; used as a type reads as a type. Declaration names are left alone.
(type_arguments (type_identifier) @type.reference (#set! priority 130))
(type_annotation (type_identifier) @type.reference (#set! priority 130))
(union_type (type_identifier) @type.reference (#set! priority 130))
(intersection_type (type_identifier) @type.reference (#set! priority 130))
(array_type (type_identifier) @type.reference (#set! priority 130))
