CLASS lhc_student DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.

    METHODS validatephone FOR VALIDATE ON SAVE
      IMPORTING keys FOR Student~ValidatePhone.

    METHODS validatename FOR VALIDATE ON SAVE
      IMPORTING keys FOR Student~ValidateName.

    METHODS validateregno FOR VALIDATE ON SAVE
      IMPORTING keys FOR Student~ValidateRegno.

ENDCLASS.

CLASS lhc_student IMPLEMENTATION.

  METHOD get_instance_authorizations.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      APPEND VALUE #(
        %tky                    = <key>-%tky
        %op-%update             = if_abap_behv=>auth-allowed
        %op-%delete             = if_abap_behv=>auth-allowed
        %action-Edit            = if_abap_behv=>auth-allowed
      ) TO result.
    ENDLOOP.
  ENDMETHOD.

  METHOD validatephone.
    " Read relevant student instances
    READ ENTITIES OF zi_student IN LOCAL MODE
      ENTITY Student
        FIELDS ( Phone )
        WITH CORRESPONDING #( keys )
      RESULT DATA(students).

    LOOP AT students ASSIGNING FIELD-SYMBOL(<student>).
      IF <student>-Phone IS NOT INITIAL.
        " Check that phone contains only digits
        IF NOT matches( val = <student>-Phone regex = '^\d+$' ).
          APPEND VALUE #(
            %tky = <student>-%tky
          ) TO failed-student.
          APPEND VALUE #(
            %tky     = <student>-%tky
            %msg     = new_message_with_text(
                          severity = if_abap_behv_message=>severity-error
                          text     = 'Phone number must contain only digits.' )
            %element-Phone = if_abap_behv=>mk-on
          ) TO reported-student.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validatename.
    READ ENTITIES OF zi_student IN LOCAL MODE
      ENTITY Student
        FIELDS ( Name )
        WITH CORRESPONDING #( keys )
      RESULT DATA(students).

    LOOP AT students ASSIGNING FIELD-SYMBOL(<student>).
      IF <student>-Name IS INITIAL.
        APPEND VALUE #(
          %tky = <student>-%tky
        ) TO failed-student.
        APPEND VALUE #(
          %tky     = <student>-%tky
          %msg     = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text     = 'Student name is required.' )
          %element-Name = if_abap_behv=>mk-on
        ) TO reported-student.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateregno.
    READ ENTITIES OF zi_student IN LOCAL MODE
      ENTITY Student
        FIELDS ( Regno )
        WITH CORRESPONDING #( keys )
      RESULT DATA(students).

    LOOP AT students ASSIGNING FIELD-SYMBOL(<student>).
      IF <student>-Regno IS INITIAL.
        APPEND VALUE #(
          %tky = <student>-%tky
        ) TO failed-student.
        APPEND VALUE #(
          %tky     = <student>-%tky
          %msg     = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text     = 'Registration number is required.' )
          %element-Regno = if_abap_behv=>mk-on
        ) TO reported-student.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
